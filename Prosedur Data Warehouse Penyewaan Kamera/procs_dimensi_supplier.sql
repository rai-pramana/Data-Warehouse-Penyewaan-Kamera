DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_supplier()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_supplier
			(kode_supplier, 
			nama_supplier, 
			no_tlp_supplier,
			alamat_supplier,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			sp.kode_supplier, 
			sp.nama_supplier, 
			sp.no_tlp_supplier, 
			sp.alamat_supplier,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		RIGHT JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON IFNULL(spdw.kode_supplier, '-1') = IFNULL(sp.kode_supplier, '-1') AND spdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE spdw.kode_supplier IS NULL
		GROUP BY sp.kode_supplier
		ORDER BY sp.kode_supplier ASC;

		DROP TABLE IF EXISTS temp_supplier;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_supplier 
		SELECT spdw.row_key_supplier, 
			spdw.kode_supplier
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier AND spdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(spdw.nama_supplier,'') <> IFNULL(sp.nama_supplier,'')
			OR IFNULL(spdw.no_tlp_supplier,'') <> IFNULL(sp.no_tlp_supplier,'')
			OR IFNULL(spdw.alamat_supplier,'') <> IFNULL(sp.alamat_supplier,'')
			OR IFNULL(spdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(spdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_supplier AS spdw, 
			temp_supplier
		SET spdw.current_flag = 'N', 
			spdw.valid_akhir = CURDATE()
		WHERE spdw.row_key_supplier = temp_supplier.row_key_supplier
			AND spdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_supplier
			(kode_supplier, 
			nama_supplier, 
			no_tlp_supplier,
			alamat_supplier,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			sp.kode_supplier, 
			sp.nama_supplier, 
			sp.no_tlp_supplier, 
			sp.alamat_supplier,
			k.nama_kota,
			p.nama_provinsi,
			spdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE sp.kode_supplier IN (SELECT DISTINCT kode_supplier FROM temp_supplier)
		GROUP BY sp.kode_supplier
		ORDER BY sp.kode_supplier ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_supplier;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_supplier
		SELECT spdw.row_key_supplier, 
			spdw.kode_supplier
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		LEFT JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier
		WHERE sp.kode_supplier IS NULL
			AND spdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_supplier AS spdw, 
			temp_supplier
		SET spdw.current_flag = 'N', 
			spdw.valid_akhir = CURDATE()
		WHERE spdw.row_key_supplier = temp_supplier.row_key_supplier
			AND spdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_supplier;
	END$$

DELIMITER ;