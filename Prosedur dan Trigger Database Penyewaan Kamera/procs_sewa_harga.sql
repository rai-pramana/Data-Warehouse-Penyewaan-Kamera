DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE db_penyewaan_kamera.procs_harga_barang()
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
	BEGIN
		UPDATE db_penyewaan_kamera.tb_detail_penyewaan AS sewd,
			db_penyewaan_kamera.tb_alat AS a
		SET sewd.harga_sewa = a.harga_sewa_alat
		WHERE sewd.kode_alat = a.kode_alat;
	END$$

DELIMITER ;