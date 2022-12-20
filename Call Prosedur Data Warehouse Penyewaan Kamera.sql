-- insert dimensi_alat
CALL dwh_penyewaan_kamera.procs_dimensi_alat();

-- insert dimensi_kota
CALL dwh_penyewaan_kamera.procs_dimensi_kota();

-- insert dimensi_pegawai
CALL dwh_penyewaan_kamera.procs_dimensi_pegawai();

-- insert dimensi_pelanggan
CALL dwh_penyewaan_kamera.procs_dimensi_pelanggan();

-- insert dimensi_supplier
CALL dwh_penyewaan_kamera.procs_dimensi_supplier();

-- insert dimensi_provinsi
CALL dwh_penyewaan_kamera.procs_dimensi_provinsi();

-- insert dimensi_waktu
CALL dwh_penyewaan_kamera.procs_dimensi_waktu_pertgl('2021-01-01', '2021-12-31'); -- (tgl_awal, tgl_akhir) 
										  -- tgl_akhir tidak boleh melewati tgl terakhir pada suatu bulan (contoh salah 202X-01-38)

-- insert fakta_pemasokan
CALL dwh_penyewaan_kamera.procs_fakta_pemasokan();

-- insert fakta_penyewaan
CALL dwh_penyewaan_kamera.procs_fakta_penyewaan();