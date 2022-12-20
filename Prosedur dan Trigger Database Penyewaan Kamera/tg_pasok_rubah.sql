DELIMITER $$

CREATE
    TRIGGER db_penyewaan_kamera.tg_pasok_rubah 
    AFTER UPDATE
    ON db_penyewaan_kamera.tb_detail_pemasokan
    FOR EACH ROW BEGIN	
	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat + new.jumlah_pasok
	WHERE kode_alat = new.kode_alat;

	UPDATE db_penyewaan_kamera.tb_pemasokan
	SET total_pasok = total_pasok + new.jumlah_pasok,
	total_biaya_pasok = total_biaya_pasok + (new.jumlah_pasok * new.harga_beli)
	WHERE kode_pasok = new.kode_pasok;


	UPDATE 	db_penyewaan_kamera.tb_alat
	SET stok_alat = stok_alat - old.jumlah_pasok
	WHERE kode_alat = old.kode_alat;

	UPDATE db_penyewaan_kamera.tb_pemasokan
	SET total_pasok = total_pasok - old.jumlah_pasok,
	total_biaya_pasok = total_biaya_pasok - (old.jumlah_pasok * old.harga_beli)
	WHERE kode_pasok = old.kode_pasok;
    END$$

DELIMITER ;