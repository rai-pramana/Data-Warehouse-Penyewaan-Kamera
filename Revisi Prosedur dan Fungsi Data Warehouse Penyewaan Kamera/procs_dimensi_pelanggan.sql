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
		DROP TABLE IF EXISTS stg_pelanggan;
		
		-- membuat tabel staging
		CREATE TEMPORARY TABLE stg_pelanggan
		SELECT 
			pl.kode_pelanggan AS kode_pelanggan, 
			func_capitalisasi(pl.nama_pelanggan) AS nama_pelanggan, 
			pl.no_tlp_pelanggan AS no_tlp_pelanggan,
			CASE
				WHEN pl.jenis_kelamin LIKE 'l' THEN 'L'
				WHEN pl.jenis_kelamin LIKE 'l%k%' THEN 'L'
				WHEN pl.jenis_kelamin LIKE 'p%a' THEN 'L'
				WHEN pl.jenis_kelamin LIKE 'p' THEN 'P'
				WHEN pl.jenis_kelamin LIKE 'p%n' THEN 'P'
				WHEN pl.jenis_kelamin LIKE 'w%n%a' THEN 'P'
			END AS jenis_kelamin,
			CASE 
				WHEN pl.alamat_pelanggan LIKE 'd%p%s%r' THEN 'Denpasar'
				WHEN pl.alamat_pelanggan LIKE 'b%d%g' THEN 'Badung'
				WHEN pl.alamat_pelanggan LIKE 't%b%n' THEN 'Tabanan'
				WHEN pl.alamat_pelanggan LIKE 'b%l%l%g' THEN 'Buleleng'
				WHEN pl.alamat_pelanggan LIKE 'b%ng%i' THEN 'Bangli'
				WHEN pl.alamat_pelanggan LIKE 'g%ny%r' THEN 'Gianyar'
				WHEN pl.alamat_pelanggan LIKE 'k%l%k%g' THEN 'Klungkung'
				WHEN pl.alamat_pelanggan LIKE 'd%p%s' THEN 'Denpasar'
				WHEN pl.alamat_pelanggan LIKE 's%b%y%' THEN 'Surabaya'
				WHEN pl.alamat_pelanggan LIKE 'k%t%n' THEN 'Klaten'
			END AS alamat_pelanggan, 
			CASE 
				WHEN k.nama_kota LIKE 'd%p%s%r' THEN 'Denpasar'
				WHEN k.nama_kota LIKE 'b%d%g' THEN 'Badung'
				WHEN k.nama_kota LIKE 't%b%n' THEN 'Tabanan'
				WHEN k.nama_kota LIKE 'b%l%l%g' THEN 'Buleleng'
				WHEN k.nama_kota LIKE 'b%ng%i' THEN 'Bangli'
				WHEN k.nama_kota LIKE 'g%ny%r' THEN 'Gianyar'
				WHEN k.nama_kota LIKE 'k%l%k%g' THEN 'Klungkung'
				WHEN k.nama_kota LIKE 'd%p%s' THEN 'Denpasar'
				WHEN k.nama_kota LIKE 's%b%y%' THEN 'Surabaya'
				WHEN k.nama_kota LIKE 'k%t%n' THEN 'Klaten'
			END AS nama_kota, 
			CASE 
				WHEN p.nama_provinsi LIKE 'b%l%i' THEN 'Bali'
				WHEN p.nama_provinsi LIKE 'j%w%t%r' THEN 'Jawa Timur'
				WHEN p.nama_provinsi LIKE 'j%w%t%n%h' THEN 'Jawa Tengah'
				WHEN p.nama_provinsi LIKE 'y%g%a' THEN 'Yogyakarta'
				WHEN p.nama_provinsi LIKE 'j%w%b%r%t' THEN 'Jawa Barat'
				WHEN p.nama_provinsi LIKE 'a%c%h' THEN 'Aceh'
				WHEN p.nama_provinsi LIKE 'k%l%t%r' THEN 'Kalimantan Timur'
				WHEN p.nama_provinsi LIKE 'k%l%b%r%t' THEN 'Kalimantan Barat'
			END AS nama_provinsi
		FROM db_penyewaan_kamera.tb_pelanggan AS pl
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi;


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
			pl.nama_kota,
			pl.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		RIGHT JOIN stg_pelanggan AS pl
			ON IFNULL(pldw.kode_pelanggan, '-1') = IFNULL(pl.kode_pelanggan, '-1') AND pldw.current_flag = 'Y'
		WHERE pldw.kode_pelanggan IS NULL
		GROUP BY pl.kode_pelanggan
		ORDER BY pl.kode_pelanggan ASC;

		DROP TABLE IF EXISTS temp_pelanggan;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pelanggan 
		SELECT pldw.row_key_pelanggan, 
			pldw.kode_pelanggan
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN stg_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan AND pldw.current_flag = 'Y'
		WHERE IFNULL(pldw.nama_pelanggan,'') <> IFNULL(pl.nama_pelanggan,'')
			OR IFNULL(pldw.no_tlp_pelanggan,'') <> IFNULL(pl.no_tlp_pelanggan,'')
			OR IFNULL(pldw.jenis_kelamin,'') <> IFNULL(pl.jenis_kelamin,'')
			OR IFNULL(pldw.alamat_pelanggan,'') <> IFNULL(pl.alamat_pelanggan,'')
			OR IFNULL(pldw.nama_kota,'') <> IFNULL(pl.nama_kota,'')
			OR IFNULL(pldw.nama_provinsi,'') <> IFNULL(pl.nama_provinsi,'');


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
			pl.nama_kota,
			pl.nama_provinsi,
			pldw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN stg_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan
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
		LEFT JOIN stg_pelanggan AS pl
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
		DROP TABLE IF EXISTS stg_pelanggan;
		DROP TABLE IF EXISTS temp_pelanggan;
	END$$

DELIMITER ;