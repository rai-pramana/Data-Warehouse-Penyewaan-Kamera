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
		DROP TABLE IF EXISTS stg_kota;
		
		-- membuat tabel staging
		CREATE TEMPORARY TABLE stg_kota
		SELECT 
			k.kode_kota AS kode_kota, 
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
		FROM db_penyewaan_kamera.tb_kota AS k
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi;


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
			k.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		RIGHT JOIN stg_kota AS k
			ON IFNULL(kdw.kode_kota, '-1') = IFNULL(k.kode_kota, '-1') AND kdw.current_flag = 'Y'
		WHERE kdw.kode_kota IS NULL
		GROUP BY k.kode_kota
		ORDER BY k.kode_kota ASC;

		DROP TABLE IF EXISTS temp_kota;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_kota 
		SELECT kdw.row_key_kota, 
			kdw.kode_kota
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN stg_kota AS k
			ON kdw.kode_kota = k.kode_kota AND kdw.current_flag = 'Y'
		WHERE IFNULL(kdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(kdw.nama_provinsi,'') <> IFNULL(k.nama_provinsi,'');


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
			k.nama_provinsi,
			kdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN stg_kota AS k
			ON kdw.kode_kota = k.kode_kota
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
		LEFT JOIN stg_kota AS k
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
		DROP TABLE IF EXISTS stg_kota;
		DROP TABLE IF EXISTS temp_kota;
	END$$

DELIMITER ;