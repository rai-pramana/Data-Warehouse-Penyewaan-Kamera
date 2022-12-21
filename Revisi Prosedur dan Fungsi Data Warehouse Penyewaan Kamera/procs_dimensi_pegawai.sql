DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_pegawai()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		DROP TABLE IF EXISTS stg_pegawai;
		
		-- membuat tabel staging
		CREATE TEMPORARY TABLE stg_pegawai
		SELECT 
			pg.kode_pegawai AS kode_pegawai, 
			func_capitalisasi(pg.nama_pegawai) AS nama_pegawai, 
			pg.no_tlp_pegawai AS no_tlp_pegawai,
			CASE
				WHEN pg.jenis_kelamin LIKE 'l' THEN 'L'
				WHEN pg.jenis_kelamin LIKE 'l%k%' THEN 'L'
				WHEN pg.jenis_kelamin LIKE 'p%a' THEN 'L'
				WHEN pg.jenis_kelamin LIKE 'p' THEN 'P'
				WHEN pg.jenis_kelamin LIKE 'p%n' THEN 'P'
				WHEN pg.jenis_kelamin LIKE 'w%n%a' THEN 'P'
			END AS jenis_kelamin,
			CASE 
				WHEN pg.alamat_pegawai LIKE 'd%p%s%r' THEN 'Denpasar'
				WHEN pg.alamat_pegawai LIKE 'b%d%g' THEN 'Badung'
				WHEN pg.alamat_pegawai LIKE 't%b%n' THEN 'Tabanan'
				WHEN pg.alamat_pegawai LIKE 'b%l%l%g' THEN 'Buleleng'
				WHEN pg.alamat_pegawai LIKE 'b%ng%i' THEN 'Bangli'
				WHEN pg.alamat_pegawai LIKE 'g%ny%r' THEN 'Gianyar'
				WHEN pg.alamat_pegawai LIKE 'k%l%k%g' THEN 'Klungkung'
				WHEN pg.alamat_pegawai LIKE 'd%p%s' THEN 'Denpasar'
				WHEN pg.alamat_pegawai LIKE 's%b%y%' THEN 'Surabaya'
				WHEN pg.alamat_pegawai LIKE 'k%t%n' THEN 'Klaten'
			END AS alamat_pegawai, 
			func_capitalisasi(j.nama_jabatan) AS nama_jabatan,
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
		FROM db_penyewaan_kamera.tb_pegawai AS pg
		INNER JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi;


		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_pegawai
			(kode_pegawai, 
			nama_pegawai, 
			no_tlp_pegawai,
			jenis_kelamin,
			alamat_pegawai,
			nama_jabatan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pg.kode_pegawai, 
			pg.nama_pegawai, 
			pg.no_tlp_pegawai, 
			pg.jenis_kelamin, 
			pg.alamat_pegawai, 
			pg.nama_jabatan,
			pg.nama_kota,
			pg.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		RIGHT JOIN stg_pegawai AS pg
			ON IFNULL(pgdw.kode_pegawai, '-1') = IFNULL(pg.kode_pegawai, '-1') AND pgdw.current_flag = 'Y'
		WHERE pgdw.kode_pegawai IS NULL
		GROUP BY pg.kode_pegawai
		ORDER BY pg.kode_pegawai ASC;

		DROP TABLE IF EXISTS temp_pegawai;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pegawai 
		SELECT pgdw.row_key_pegawai, 
			pgdw.kode_pegawai
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN stg_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai AND pgdw.current_flag = 'Y'
		WHERE IFNULL(pgdw.nama_pegawai,'') <> IFNULL(pg.nama_pegawai,'')
			OR IFNULL(pgdw.no_tlp_pegawai,'') <> IFNULL(pg.no_tlp_pegawai,'')
			OR IFNULL(pgdw.jenis_kelamin,'') <> IFNULL(pg.jenis_kelamin,'')
			OR IFNULL(pgdw.alamat_pegawai,'') <> IFNULL(pg.alamat_pegawai,'')
			OR IFNULL(pgdw.nama_jabatan,'') <> IFNULL(pg.nama_jabatan,'')
			OR IFNULL(pgdw.nama_kota,'') <> IFNULL(pg.nama_kota,'')
			OR IFNULL(pgdw.nama_provinsi,'') <> IFNULL(pg.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_pegawai AS pgdw, 
			temp_pegawai
		SET pgdw.current_flag = 'N', 
			pgdw.valid_akhir = CURDATE()
		WHERE pgdw.row_key_pegawai = temp_pegawai.row_key_pegawai
			AND pgdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_pegawai
			(kode_pegawai, 
			nama_pegawai, 
			no_tlp_pegawai,
			jenis_kelamin,
			alamat_pegawai,
			nama_jabatan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pg.kode_pegawai, 
			pg.nama_pegawai, 
			pg.no_tlp_pegawai, 
			pg.jenis_kelamin, 
			pg.alamat_pegawai, 
			pg.nama_jabatan,
			pg.nama_kota,
			pg.nama_provinsi,
			pgdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN stg_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai
		WHERE pg.kode_pegawai IN (SELECT DISTINCT kode_pegawai FROM temp_pegawai)
		GROUP BY pg.kode_pegawai
		ORDER BY pg.kode_pegawai ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pegawai;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_pegawai
		SELECT pgdw.row_key_pegawai, 
			pgdw.kode_pegawai
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		LEFT JOIN stg_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai
		WHERE pg.kode_pegawai IS NULL
			AND pgdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_pegawai AS pgdw, 
			temp_pegawai
		SET pgdw.current_flag = 'N', 
			pgdw.valid_akhir = CURDATE()
		WHERE pgdw.row_key_pegawai = temp_pegawai.row_key_pegawai
			AND pgdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS stg_pegawai;
		DROP TABLE IF EXISTS temp_pegawai;
	END$$

DELIMITER ;