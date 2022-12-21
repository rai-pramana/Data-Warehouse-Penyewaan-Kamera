DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_fakta_pemasokan()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		INSERT INTO fakta_pemasokan
			(row_key_waktu,
			row_key_kota,
			row_key_provinsi,
			row_key_supplier,
			row_key_pegawai,
			row_key_alat,
			total_alat_pemasokan,
			total_biaya_pemasokan)
		SELECT wtdw.row_key_waktu, 
			kdw.row_key_kota, 
			pdw.row_key_provinsi, 
			spdw.row_key_supplier, 
			pgdw.row_key_pegawai, 
			adw.row_key_alat, 
			SUM(pasd.jumlah_pasok),
			SUM(pasd.harga_beli * pasd.jumlah_pasok)
		FROM db_penyewaan_kamera.tb_pemasokan AS pas
		INNER JOIN db_penyewaan_kamera.tb_detail_pemasokan AS pasd
			ON pasd.kode_pasok = pas.kode_pasok
		INNER JOIN db_penyewaan_kamera.tb_alat AS a
			ON a.kode_alat = pasd.kode_alat
		INNER JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON sp.kode_supplier = pas.kode_supplier
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		INNER JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pg.kode_pegawai = pas.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_waktu AS wtdw
			ON wtdw.tanggal = pas.tgl_pasok
		INNER JOIN dwh_penyewaan_kamera.dimensi_kota AS kdw
			ON kdw.kode_kota = k.kode_kota
		INNER JOIN dwh_penyewaan_kamera.dimensi_provinsi AS pdw
			ON pdw.kode_provinsi = p.kode_provinsi
		INNER JOIN dwh_penyewaan_kamera.dimensi_supplier AS spdw
			ON spdw.kode_supplier = sp.kode_supplier
		INNER JOIN dwh_penyewaan_kamera.dimensi_pegawai AS pgdw
			ON pgdw.kode_pegawai = pg.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_alat AS adw
			ON adw.kode_alat = a.kode_alat
		WHERE wtdw.current_flag = 'Y'
			AND kdw.current_flag = 'Y'
			AND pdw.current_flag = 'Y'
			AND spdw.current_flag = 'Y'
			AND pgdw.current_flag = 'Y'
			AND adw.current_flag = 'Y'
		GROUP BY pas.tgl_pasok, 
			k.kode_kota,
			p.kode_provinsi,
			pas.kode_supplier,
			pas.kode_pegawai,
			pasd.kode_alat
		ORDER BY pas.tgl_pasok, 
			k.kode_kota,
			p.kode_provinsi,
			pas.kode_supplier,
			pas.kode_pegawai,
			pasd.kode_alat
		ON DUPLICATE KEY 
			UPDATE fakta_pemasokan.row_key_waktu = fakta_pemasokan.row_key_waktu;
	END$$

DELIMITER ;