DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_kota()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_kota
			(kode_kota, 
			nama_kota, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			k.kode_kota, 
			k.nama_kota, 
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		RIGHT JOIN db_penyewaan_kamera.tb_kota AS k
			ON IFNULL(kdw.kode_kota, '-1') = IFNULL(k.kode_kota, '-1') AND kdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE kdw.kode_kota IS NULL
		GROUP BY k.kode_kota
		ORDER BY k.kode_kota ASC;

		DROP TABLE IF EXISTS temp_kota;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_kota 
		SELECT kdw.row_key_kota, 
			kdw.kode_kota
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota AND kdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(kdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(kdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_kota AS kdw, 
			temp_kota
		SET kdw.current_flag = 'N', 
			kdw.valid_akhir = CURDATE()
		WHERE kdw.row_key_kota = temp_kota.row_key_kota
			AND kdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_kota
			(kode_kota, 
			nama_kota, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			k.kode_kota, 
			k.nama_kota, 
			p.nama_provinsi,
			kdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE k.kode_kota IN (SELECT DISTINCT kode_kota FROM temp_kota)
		GROUP BY k.kode_kota
		ORDER BY k.kode_kota ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_kota;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_kota
		SELECT kdw.row_key_kota, 
			kdw.kode_kota
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		LEFT JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota
		WHERE k.kode_kota IS NULL
			AND kdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_kota AS kdw, 
			temp_kota
		SET kdw.current_flag = 'N', 
			kdw.valid_akhir = CURDATE()
		WHERE kdw.row_key_kota = temp_kota.row_key_kota
			AND kdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_kota;
	END$$

DELIMITER ;