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
		DROP TABLE IF EXISTS stg_supplier;
		
		-- membuat tabel staging
		CREATE TEMPORARY TABLE stg_supplier
		SELECT 
			sp.kode_supplier AS kode_supplier, 
			func_capitalisasi(sp.nama_supplier) AS nama_supplier, 
			sp.no_tlp_supplier AS no_tlp_supplier,
			CASE 
				WHEN sp.alamat_supplier LIKE 'd%p%s%r' THEN 'Denpasar'
				WHEN sp.alamat_supplier LIKE 'b%d%g' THEN 'Badung'
				WHEN sp.alamat_supplier LIKE 't%b%n' THEN 'Tabanan'
				WHEN sp.alamat_supplier LIKE 'b%l%l%g' THEN 'Buleleng'
				WHEN sp.alamat_supplier LIKE 'b%ng%i' THEN 'Bangli'
				WHEN sp.alamat_supplier LIKE 'g%ny%r' THEN 'Gianyar'
				WHEN sp.alamat_supplier LIKE 'k%l%k%g' THEN 'Klungkung'
				WHEN sp.alamat_supplier LIKE 'd%p%s' THEN 'Denpasar'
				WHEN sp.alamat_supplier LIKE 's%b%y%' THEN 'Surabaya'
				WHEN sp.alamat_supplier LIKE 'k%t%n' THEN 'Klaten'
			END AS alamat_supplier, 
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
		FROM db_penyewaan_kamera.tb_supplier AS sp
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi;


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
			sp.nama_kota,
			sp.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		RIGHT JOIN stg_supplier AS sp
			ON IFNULL(spdw.kode_supplier, '-1') = IFNULL(sp.kode_supplier, '-1') AND spdw.current_flag = 'Y'
		WHERE spdw.kode_supplier IS NULL
		GROUP BY sp.kode_supplier
		ORDER BY sp.kode_supplier ASC;

		DROP TABLE IF EXISTS temp_supplier;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_supplier 
		SELECT spdw.row_key_supplier, 
			spdw.kode_supplier
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN stg_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier AND spdw.current_flag = 'Y'
		WHERE IFNULL(spdw.nama_supplier,'') <> IFNULL(sp.nama_supplier,'')
			OR IFNULL(spdw.no_tlp_supplier,'') <> IFNULL(sp.no_tlp_supplier,'')
			OR IFNULL(spdw.alamat_supplier,'') <> IFNULL(sp.alamat_supplier,'')
			OR IFNULL(spdw.nama_kota,'') <> IFNULL(sp.nama_kota,'')
			OR IFNULL(spdw.nama_provinsi,'') <> IFNULL(sp.nama_provinsi,'');


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
			sp.nama_kota,
			sp.nama_provinsi,
			spdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN stg_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier
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
		LEFT JOIN stg_supplier AS sp
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
		DROP TABLE IF EXISTS stg_supplier;
		DROP TABLE IF EXISTS temp_supplier;
	END$$

DELIMITER ;