DELIMITER $$

CREATE
    TRIGGER db_penyewaan_kamera.tg_denda_rubah 
    AFTER UPDATE
    ON db_penyewaan_kamera.tb_denda
    FOR EACH ROW BEGIN
	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_biaya_sewa = total_biaya_sewa + (new.biaya_denda)
	WHERE kode_sewa = new.kode_sewa;

	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_biaya_sewa = total_biaya_sewa - (old.biaya_denda)
	WHERE kode_sewa = old.kode_sewa;
    END$$

DELIMITER ;