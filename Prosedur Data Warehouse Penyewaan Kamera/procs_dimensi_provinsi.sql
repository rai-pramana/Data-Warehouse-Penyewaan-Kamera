DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_provinsi()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_provinsi
			(kode_provinsi, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			p.kode_provinsi, 
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		RIGHT JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON IFNULL(pdw.kode_provinsi, '-1') = IFNULL(p.kode_provinsi, '-1') AND pdw.current_flag = 'Y'
		WHERE pdw.kode_provinsi IS NULL
		GROUP BY p.kode_provinsi
		ORDER BY p.kode_provinsi ASC;

		DROP TABLE IF EXISTS temp_provinsi;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_provinsi 
		SELECT pdw.row_key_provinsi, 
			pdw.kode_provinsi
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi AND pdw.current_flag = 'Y'
		WHERE IFNULL(pdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');

		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_provinsi AS pdw, 
			temp_provinsi
		SET pdw.current_flag = 'N', 
			pdw.valid_akhir = CURDATE()
		WHERE pdw.row_key_provinsi = temp_provinsi.row_key_provinsi
			AND pdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_provinsi
			(kode_provinsi, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			p.kode_provinsi, 
			p.nama_provinsi, 
			pdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi
		WHERE p.kode_provinsi IN (SELECT DISTINCT kode_provinsi FROM temp_provinsi)
		GROUP BY p.kode_provinsi
		ORDER BY p.kode_provinsi ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_provinsi;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_provinsi
		SELECT pdw.row_key_provinsi, 
			pdw.kode_provinsi
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		LEFT JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi
		WHERE p.kode_provinsi IS NULL
			AND pdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_provinsi AS pdw, 
			temp_provinsi
		SET pdw.current_flag = 'N', 
			pdw.valid_akhir = CURDATE()
		WHERE pdw.row_key_provinsi = temp_provinsi.row_key_provinsi
			AND pdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_provinsi;
	END$$

DELIMITER ;