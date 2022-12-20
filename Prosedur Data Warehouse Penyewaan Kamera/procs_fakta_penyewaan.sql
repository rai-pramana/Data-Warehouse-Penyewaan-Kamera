DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_fakta_penyewaan()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		INSERT INTO fakta_penyewaan
			(row_key_waktu,
			row_key_kota,
			row_key_provinsi,
			row_key_pelanggan,
			row_key_pegawai,
			row_key_alat,
			total_alat_penyewaan,
			total_biaya_penyewaan,
			total_biaya_denda)
		SELECT wtdw.row_key_waktu, 
			kdw.row_key_kota, 
			pdw.row_key_provinsi, 
			pldw.row_key_pelanggan, 
			pgdw.row_key_pegawai, 
			adw.row_key_alat, 
			SUM(sewd.jumlah_sewa),
			SUM(sewd.harga_sewa * sewd.jumlah_sewa),
			SUM(d.biaya_denda)
		FROM db_penyewaan_kamera.tb_penyewaan AS sew
		INNER JOIN db_penyewaan_kamera.tb_detail_penyewaan AS sewd
			ON sewd.kode_sewa = sew.kode_sewa
		INNER JOIN db_penyewaan_kamera.tb_alat AS a
			ON a.kode_alat = sewd.kode_alat
		LEFT JOIN db_penyewaan_kamera.tb_denda AS d
			ON d.kode_sewa = sew.kode_sewa
		INNER JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pl.kode_pelanggan = sew.kode_pelanggan
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		INNER JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pg.kode_pegawai = sew.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_waktu AS wtdw
			ON wtdw.tanggal = sew.tgl_sewa
		INNER JOIN dwh_penyewaan_kamera.dimensi_kota AS kdw
			ON kdw.kode_kota = k.kode_kota
		INNER JOIN dwh_penyewaan_kamera.dimensi_provinsi AS pdw
			ON pdw.kode_provinsi = p.kode_provinsi
		INNER JOIN dwh_penyewaan_kamera.dimensi_pelanggan AS pldw
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		INNER JOIN dwh_penyewaan_kamera.dimensi_pegawai AS pgdw
			ON pgdw.kode_pegawai = pg.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_alat AS adw
			ON adw.kode_alat = a.kode_alat
		WHERE wtdw.current_flag = 'Y'
			AND kdw.current_flag = 'Y'
			AND pdw.current_flag = 'Y'
			AND pldw.current_flag = 'Y'
			AND pgdw.current_flag = 'Y'
			AND adw.current_flag = 'Y'
		GROUP BY sew.tgl_sewa, 
			k.kode_kota,
			p.kode_provinsi,
			sew.kode_pelanggan,
			sew.kode_pegawai,
			sewd.kode_alat
		ORDER BY sew.tgl_sewa, 
			k.kode_kota,
			p.kode_provinsi,
			sew.kode_pelanggan,
			sew.kode_pegawai,
			sewd.kode_alat
		ON DUPLICATE KEY 
			UPDATE fakta_penyewaan.row_key_waktu = fakta_penyewaan.row_key_waktu;
	END$$

DELIMITER ;