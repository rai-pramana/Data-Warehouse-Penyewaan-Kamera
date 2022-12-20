DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    TRIGGER db_penyewaan_kamera.tg_pasok AFTER INSERT
    ON db_penyewaan_kamera.tb_detail_pemasokan
    FOR EACH ROW BEGIN
	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat + new.jumlah_pasok
	WHERE kode_alat = new.kode_alat;

	UPDATE db_penyewaan_kamera.tb_pemasokan
	SET total_pasok = total_pasok + new.jumlah_pasok,
	total_biaya_pasok = total_biaya_pasok + (new.jumlah_pasok * new.harga_beli)
	WHERE kode_pasok = new.kode_pasok;
    END$$

DELIMITER ;