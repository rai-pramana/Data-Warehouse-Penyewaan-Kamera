DELIMITER $$

CREATE
    TRIGGER db_penyewaan_kamera.tg_sewa_rubah 
    AFTER UPDATE
    ON db_penyewaan_kamera.tb_detail_penyewaan
    FOR EACH ROW BEGIN
	DECLARE n_harga, o_harga INT DEFAULT 0;

	SELECT harga_sewa_alat INTO n_harga FROM tb_alat
	WHERE kode_alat = new.kode_alat;

	SELECT harga_sewa_alat INTO o_harga FROM tb_alat
	WHERE kode_alat = old.kode_alat;
	
	
	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat - new.jumlah_sewa
	WHERE kode_alat = new.kode_alat;

	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_sewa = total_sewa + new.jumlah_sewa,
	total_biaya_sewa = total_biaya_sewa + (new.jumlah_sewa * n_harga)
	WHERE kode_sewa = new.kode_sewa;


	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat + old.jumlah_sewa
	WHERE kode_alat = old.kode_alat;

	UPDATE db_penyewaan_kamera.tb_penyewaan
	SET total_sewa = total_sewa - old.jumlah_sewa,
	total_biaya_sewa = total_biaya_sewa - (old.jumlah_sewa * o_harga)
	WHERE kode_sewa = old.kode_sewa;
    END$$

DELIMITER ;