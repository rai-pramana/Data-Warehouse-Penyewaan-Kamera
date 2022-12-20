DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_pelanggan()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_pelanggan
			(kode_pelanggan, 
			nama_pelanggan, 
			no_tlp_pelanggan,
			jenis_kelamin,
			alamat_pelanggan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pl.kode_pelanggan, 
			pl.nama_pelanggan, 
			pl.no_tlp_pelanggan, 
			pl.jenis_kelamin, 
			pl.alamat_pelanggan,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		RIGHT JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON IFNULL(pldw.kode_pelanggan, '-1') = IFNULL(pl.kode_pelanggan, '-1') AND pldw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pldw.kode_pelanggan IS NULL
		GROUP BY pl.kode_pelanggan
		ORDER BY pl.kode_pelanggan ASC;

		DROP TABLE IF EXISTS temp_pelanggan;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pelanggan 
		SELECT pldw.row_key_pelanggan, 
			pldw.kode_pelanggan
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan AND pldw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(pldw.nama_pelanggan,'') <> IFNULL(pl.nama_pelanggan,'')
			OR IFNULL(pldw.no_tlp_pelanggan,'') <> IFNULL(pl.no_tlp_pelanggan,'')
			OR IFNULL(pldw.jenis_kelamin,'') <> IFNULL(pl.jenis_kelamin,'')
			OR IFNULL(pldw.alamat_pelanggan,'') <> IFNULL(pl.alamat_pelanggan,'')
			OR IFNULL(pldw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(pldw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_pelanggan AS pldw, 
			temp_pelanggan
		SET pldw.current_flag = 'N', 
			pldw.valid_akhir = CURDATE()
		WHERE pldw.row_key_pelanggan = temp_pelanggan.row_key_pelanggan
			AND pldw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_pelanggan
			(kode_pelanggan, 
			nama_pelanggan, 
			no_tlp_pelanggan,
			jenis_kelamin,
			alamat_pelanggan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pl.kode_pelanggan, 
			pl.nama_pelanggan, 
			pl.no_tlp_pelanggan, 
			pl.jenis_kelamin, 
			pl.alamat_pelanggan,
			k.nama_kota,
			p.nama_provinsi,
			pldw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pl.kode_pelanggan IN (SELECT DISTINCT kode_pelanggan FROM temp_pelanggan)
		GROUP BY pl.kode_pelanggan
		ORDER BY pl.kode_pelanggan ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pelanggan;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_pelanggan
		SELECT pldw.row_key_pelanggan, 
			pldw.kode_pelanggan
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		LEFT JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		WHERE pl.kode_pelanggan IS NULL
			AND pldw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_pelanggan AS pldw, 
			temp_pelanggan
		SET pldw.current_flag = 'N', 
			pldw.valid_akhir = CURDATE()
		WHERE pldw.row_key_pelanggan = temp_pelanggan.row_key_pelanggan
			AND pldw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pelanggan;
	END$$

DELIMITER ;