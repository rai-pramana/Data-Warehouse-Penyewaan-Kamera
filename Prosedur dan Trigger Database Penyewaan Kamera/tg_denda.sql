DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    TRIGGER db_penyewaan_kamera.tg_denda AFTER INSERT
    ON db_penyewaan_kamera.tb_denda
    FOR EACH ROW BEGIN	
	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_biaya_sewa = total_biaya_sewa + (new.biaya_denda)
	WHERE kode_sewa = new.kode_sewa;
    END$$

DELIMITER ;