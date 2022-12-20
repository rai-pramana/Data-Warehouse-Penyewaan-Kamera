-- informasi:

-- dimensi_alat (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1. data alat
SELECT adw.`kode_alat`,
	adw.`nama_alat`,
	adw.`harga_sewa_alat`,
	adw.`nama_merk`,
	adw.`nama_jenis_alat`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa
FROM dwh_penyewaan_kamera.`dimensi_alat` AS adw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_alat` = adw.`row_key_alat`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_alat` = adw.`row_key_alat`
WHERE adw.`current_flag` = 'Y'
GROUP BY adw.`kode_alat`
;

-- 2. data merk 
SELECT adw.`nama_merk`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa
FROM dwh_penyewaan_kamera.`dimensi_alat` AS adw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_alat` = adw.`row_key_alat`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_alat` = adw.`row_key_alat`
GROUP BY adw.`nama_merk`
;

-- 3. data jenis_alat
SELECT adw.`nama_jenis_alat`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa
FROM dwh_penyewaan_kamera.`dimensi_alat` AS adw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_alat` = adw.`row_key_alat`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_alat` = adw.`row_key_alat`
GROUP BY adw.`nama_jenis_alat`
;


-- dimensi_kota (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1 data kota
SELECT kdw.`kode_kota`,
	kdw.`nama_kota`,
	kdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_kota` AS kdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_kota` = kdw.`row_key_kota`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_kota` = kdw.`row_key_kota`
GROUP BY kdw.`kode_kota`
;

-- 2 data provinsi kota
SELECT kdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_kota` AS kdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_kota` = kdw.`row_key_kota`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_kota` = kdw.`row_key_kota`
GROUP BY kdw.`nama_provinsi`
;


-- dimensi_pegawai (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1 data pegawai
SELECT pdw.`kode_pegawai`,
	pdw.`nama_pegawai`,
	pdw.`no_tlp_pegawai`,
	pdw.`jenis_kelamin`,
	pdw.`alamat_pegawai`,
	pdw.`nama_jabatan`,
	pdw.`nama_kota`,
	pdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pegawai` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_pegawai` = pdw.`row_key_pegawai`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pegawai` = pdw.`row_key_pegawai`
GROUP BY pdw.`kode_pegawai`
;

-- 2 data jenis kelamin
SELECT pdw.`jenis_kelamin`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pegawai` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_pegawai` = pdw.`row_key_pegawai`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pegawai` = pdw.`row_key_pegawai`
GROUP BY pdw.`jenis_kelamin`
;

-- 3 data jabatan
SELECT pdw.`nama_jabatan`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pegawai` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_pegawai` = pdw.`row_key_pegawai`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pegawai` = pdw.`row_key_pegawai`
GROUP BY pdw.`nama_jabatan`
;

-- 4 data kota
SELECT pdw.`nama_kota`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pegawai` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_pegawai` = pdw.`row_key_pegawai`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pegawai` = pdw.`row_key_pegawai`
GROUP BY pdw.`nama_kota`
;

-- 5 data provinsi
SELECT pdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pegawai` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_pegawai` = pdw.`row_key_pegawai`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pegawai` = pdw.`row_key_pegawai`
GROUP BY pdw.`nama_provinsi`
;


-- dimensi_pelanggan (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1 data pelanggan
SELECT pldw.`kode_pelanggan`,
	pldw.`nama_pelanggan`,
	pldw.`no_tlp_pelanggan`,
	pldw.`jenis_kelamin`,
	pldw.`alamat_pelanggan`,
	pldw.`nama_kota`,
	pldw.`nama_provinsi`,
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pelanggan` AS pldw
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pelanggan` = pldw.`row_key_pelanggan`
GROUP BY pldw.`kode_pelanggan`
;

-- 2 data jenis kelamin
SELECT pldw.`jenis_kelamin`,
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pelanggan` AS pldw
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pelanggan` = pldw.`row_key_pelanggan`
GROUP BY pldw.`jenis_kelamin`
;

-- 3 data kota
SELECT pldw.`nama_kota`,
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pelanggan` AS pldw
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pelanggan` = pldw.`row_key_pelanggan`
GROUP BY pldw.`nama_kota`
;

-- 4 data provinsi
SELECT pldw.`nama_provinsi`,
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_pelanggan` AS pldw
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_pelanggan` = pldw.`row_key_pelanggan`
GROUP BY pldw.`nama_provinsi`
;

-- dimensi_provinsi (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1 data provinsi
SELECT pdw.`kode_provinsi`,
	pdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok, 
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_provinsi` AS pdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_provinsi` = pdw.`row_key_provinsi`
LEFT JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_provinsi` = pdw.`row_key_provinsi`
GROUP BY pdw.`kode_provinsi`
;


-- dimensi_supplier (informasi total pasok dan sewa, dan total biaya pasok dan sewa)
-- 1 data supplier
SELECT spdw.`kode_supplier`,
	spdw.`nama_supplier`,
	spdw.`no_tlp_supplier`,
	spdw.`alamat_supplier`,
	spdw.`nama_kota`,
	spdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok
FROM dwh_penyewaan_kamera.`dimensi_supplier` AS spdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_supplier` = spdw.`row_key_supplier`
GROUP BY spdw.`kode_supplier`
;

-- 2 data kota
SELECT spdw.`nama_kota`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok
FROM dwh_penyewaan_kamera.`dimensi_supplier` AS spdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_supplier` = spdw.`row_key_supplier`
GROUP BY spdw.`nama_kota`
;

-- 3 data provinsi
SELECT spdw.`nama_provinsi`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok
FROM dwh_penyewaan_kamera.`dimensi_supplier` AS spdw
LEFT JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_supplier` = spdw.`row_key_supplier`
GROUP BY spdw.`nama_provinsi`
;


-- dimensi_waktu
-- 1 data waktu dan informasi pemasokan
SELECT wtdw.`kode_waktu`,
	wtdw.`tahun`,
	wtdw.`kuartal`,
	wtdw.`bulan`,
	wtdw.`hari`,
	wtdw.`tanggal`,
	SUM(pasd.`total_alat_pemasokan`) AS total_pasok, 
	SUM(pasd.`total_biaya_pemasokan`) AS total_biaya_pasok
FROM dwh_penyewaan_kamera.`dimensi_waktu` AS wtdw
INNER JOIN dwh_penyewaan_kamera.`fakta_pemasokan` AS pasd
	ON pasd.`row_key_waktu` = wtdw.`row_key_waktu`
GROUP BY wtdw.`kode_waktu`
;

-- 2 data waktu dan informasi penyewaan
SELECT wtdw.`kode_waktu`,
	wtdw.`tahun`,
	wtdw.`kuartal`,
	wtdw.`bulan`,
	wtdw.`hari`,
	wtdw.`tanggal`,
	SUM(sewd.`total_alat_penyewaan`) AS total_sewa, 
	SUM(sewd.`total_biaya_penyewaan`) AS total_biaya_sewa,
	SUM(sewd.`total_biaya_denda`) AS total_biaya_denda
FROM dwh_penyewaan_kamera.`dimensi_waktu` AS wtdw
INNER JOIN dwh_penyewaan_kamera.`fakta_penyewaan` AS sewd
	ON sewd.`row_key_waktu` = wtdw.`row_key_waktu`
GROUP BY wtdw.`kode_waktu`
;
