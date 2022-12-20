DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_alat()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_alat 
			(kode_alat, 
			nama_alat, 
			harga_sewa_alat, 
			nama_merk, 
			nama_jenis_alat, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			a.kode_alat, 
			a.nama_alat, 
			a.harga_sewa_alat, 
			m.nama_merk, 
			ja.nama_jenis_alat,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		RIGHT JOIN db_penyewaan_kamera.tb_alat AS a
			ON IFNULL(adw.kode_alat, '-1') = IFNULL(a.kode_alat, '-1') AND adw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		INNER JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE adw.kode_alat IS NULL
		GROUP BY a.kode_alat
		ORDER BY a.kode_alat ASC;

		DROP TABLE IF EXISTS temp_alat;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_alat
		SELECT adw.row_key_alat, 
			adw.kode_alat
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat AND adw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE IFNULL(adw.nama_alat,'') <> IFNULL(a.nama_alat,'')
			OR IFNULL(adw.harga_sewa_alat,0) <> IFNULL(a.harga_sewa_alat,0)
			OR IFNULL(adw.nama_merk,'') <> IFNULL(m.nama_merk,'')
			OR IFNULL(adw.nama_jenis_alat,'') <> IFNULL(ja.nama_jenis_alat,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_alat AS adw, 
			temp_alat
		SET adw.current_flag = 'N', 
			adw.valid_akhir = CURDATE()
		WHERE adw.row_key_alat = temp_alat.row_key_alat
			AND adw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_alat
			(kode_alat, 
			nama_alat, 
			harga_sewa_alat, 
			nama_merk, 
			nama_jenis_alat, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			a.kode_alat, 
			a.nama_alat, 
			a.harga_sewa_alat, 
			m.nama_merk, 
			ja.nama_jenis_alat,
			adw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat
		JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE a.kode_alat IN (SELECT DISTINCT kode_alat FROM temp_alat)
		GROUP BY a.kode_alat
		ORDER BY a.kode_alat ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_alat;
		
		
		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_alat
		SELECT adw.row_key_alat, 
			adw.kode_alat
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		LEFT JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat
		WHERE a.kode_alat IS NULL
			AND adw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_alat AS adw, 
			temp_alat
		SET adw.current_flag = 'N', 
			adw.valid_akhir = CURDATE()
		WHERE adw.row_key_alat = temp_alat.row_key_alat
			AND adw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_alat;
	END$$

DELIMITER ;