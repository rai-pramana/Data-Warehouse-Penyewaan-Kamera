DELIMITER $$

CREATE
    TRIGGER db_penyewaan_kamera.tg_sewa_kembalikan
    BEFORE DELETE
    ON db_penyewaan_kamera.tb_detail_penyewaan
    FOR EACH ROW BEGIN
    DECLARE v_harga INT DEFAULT 0;
	SELECT harga_sewa_alat INTO v_harga FROM tb_alat
	WHERE kode_alat = old.kode_alat;

	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat + old.jumlah_sewa
	WHERE kode_alat = old.kode_alat;

	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_sewa = total_sewa - old.jumlah_sewa,
	total_biaya_sewa = total_biaya_sewa - (old.jumlah_sewa * v_harga)
	WHERE kode_sewa = old.kode_sewa;
    END$$

DELIMITER ;