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
			j.nama_jabatan,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		RIGHT JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON IFNULL(pgdw.kode_pegawai, '-1') = IFNULL(pg.kode_pegawai, '-1') AND pgdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pgdw.kode_pegawai IS NULL
		GROUP BY pg.kode_pegawai
		ORDER BY pg.kode_pegawai ASC;

		DROP TABLE IF EXISTS temp_pegawai;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pegawai 
		SELECT pgdw.row_key_pegawai, 
			pgdw.kode_pegawai
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai AND pgdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(pgdw.nama_pegawai,'') <> IFNULL(pg.nama_pegawai,'')
			OR IFNULL(pgdw.no_tlp_pegawai,'') <> IFNULL(pg.no_tlp_pegawai,'')
			OR IFNULL(pgdw.jenis_kelamin,'') <> IFNULL(pg.jenis_kelamin,'')
			OR IFNULL(pgdw.alamat_pegawai,'') <> IFNULL(pg.alamat_pegawai,'')
			OR IFNULL(pgdw.nama_jabatan,'') <> IFNULL(j.nama_jabatan,'')
			OR IFNULL(pgdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(pgdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


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
			j.nama_jabatan,
			k.nama_kota,
			p.nama_provinsi,
			pgdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai
		JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
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
		LEFT JOIN db_penyewaan_kamera.tb_pegawai AS pg
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
		DROP TABLE IF EXISTS temp_pegawai;
	END$$

DELIMITER ;