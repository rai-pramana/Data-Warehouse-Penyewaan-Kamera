CREATE DATABASE dwh_penyewaan_kamera

CREATE TABLE dimensi_waktu(
	row_key_waktu INT AUTO_INCREMENT NOT NULL,
	kode_waktu CHAR(5) NOT NULL,
	tahun YEAR,
	kuartal ENUM('1',
		'2',
		'3',
		'4'),
	bulan ENUM('Januari',
		'Februari',
		'Maret',
		'April',
		'Mei',
		'Juni',
		'Juli',     
		'Agustus',  
		'September',        
		'Oktober',  
		'November',        
		'Desember'),
	hari ENUM('Minggu',
		'Senin',
		'Selasa',
		'Rabu',
		'Kamis',
		'Jumat',
		'Sabtu'),
	tanggal DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_waktu),
	UNIQUE(row_key_waktu,
		kode_waktu),
	UNIQUE(tahun,
		kuartal,
		bulan,
		hari,
		tanggal)
);

CREATE TABLE dimensi_provinsi(
	row_key_provinsi INT AUTO_INCREMENT NOT NULL,
	kode_provinsi CHAR(5) NOT NULL,
	nama_provinsi VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_provinsi),
	UNIQUE(row_key_provinsi,
		kode_provinsi)
);

CREATE TABLE dimensi_kota(
	row_key_kota INT AUTO_INCREMENT NOT NULL,
	kode_kota CHAR(5) NOT NULL,
	nama_kota VARCHAR(30),
	nama_provinsi VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_kota),
	UNIQUE(row_key_kota,
		kode_kota)
);

CREATE TABLE dimensi_supplier(
	row_key_supplier INT AUTO_INCREMENT NOT NULL,
	kode_supplier CHAR(5) NOT NULL,
	nama_supplier VARCHAR(30),
	no_tlp_supplier VARCHAR(15),
	alamat_supplier VARCHAR(80),
	nama_kota VARCHAR(30),
	nama_provinsi VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_supplier),
	UNIQUE(row_key_supplier,
		kode_supplier)
);

CREATE TABLE dimensi_pelanggan(
	row_key_pelanggan INT AUTO_INCREMENT NOT NULL,
	kode_pelanggan CHAR(5) NOT NULL,
	nama_pelanggan VARCHAR(30),
	no_tlp_pelanggan VARCHAR(15),
	jenis_kelamin ENUM('L','P'),
	alamat_pelanggan VARCHAR(80),
	nama_kota VARCHAR(30),
	nama_provinsi VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_pelanggan),
	UNIQUE(row_key_pelanggan,
		kode_pelanggan)
);

CREATE TABLE dimensi_pegawai(
	row_key_pegawai INT AUTO_INCREMENT NOT NULL,
	kode_pegawai CHAR(5) NOT NULL,
	nama_pegawai VARCHAR(30),
	no_tlp_pegawai VARCHAR(15),
	jenis_kelamin ENUM('L','P'),
	alamat_pegawai VARCHAR(80),
	nama_jabatan VARCHAR(30),
	nama_kota VARCHAR(30),
	nama_provinsi VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_pegawai),
	UNIQUE(row_key_pegawai,
		kode_pegawai)
);

CREATE TABLE dimensi_alat(
	row_key_alat INT AUTO_INCREMENT NOT NULL,
	kode_alat CHAR(5) NOT NULL,
	nama_alat VARCHAR(50),
	harga_sewa_alat BIGINT,
	nama_merk VARCHAR(30),
	nama_jenis_alat VARCHAR(30),
	valid_awal DATE,
	valid_akhir DATE,
	current_flag ENUM('Y', 'N'),
	PRIMARY KEY(row_key_alat),
	UNIQUE(row_key_alat,
		kode_alat)
);

CREATE TABLE fakta_pemasokan(
	row_key_waktu INT NOT NULL,
	row_key_kota INT NOT NULL,
	row_key_provinsi INT NOT NULL,
	row_key_supplier INT NOT NULL,
	row_key_pegawai INT NOT NULL,
	row_key_alat INT NOT NULL,
	total_alat_pemasokan  BIGINT,
	total_biaya_pemasokan  BIGINT,
	FOREIGN KEY(row_key_waktu) REFERENCES dimensi_waktu(row_key_waktu),
	FOREIGN KEY(row_key_kota) REFERENCES dimensi_kota(row_key_kota),
	FOREIGN KEY(row_key_provinsi) REFERENCES dimensi_provinsi(row_key_provinsi),
	FOREIGN KEY(row_key_supplier) REFERENCES dimensi_supplier(row_key_supplier),
	FOREIGN KEY(row_key_pegawai) REFERENCES dimensi_pegawai(row_key_pegawai),
	FOREIGN KEY(row_key_alat) REFERENCES dimensi_alat(row_key_alat),
	UNIQUE(row_key_waktu,
		row_key_kota,
		row_key_provinsi,
		row_key_supplier,
		row_key_pegawai,
		row_key_alat)
);

CREATE TABLE fakta_penyewaan(
	row_key_waktu INT NOT NULL,
	row_key_kota INT NOT NULL,
	row_key_provinsi INT NOT NULL,
	row_key_pelanggan INT NOT NULL,
	row_key_pegawai INT NOT NULL,
	row_key_alat INT NOT NULL,
	total_alat_penyewaan BIGINT,
	total_biaya_penyewaan BIGINT,
	total_biaya_denda BIGINT,
	FOREIGN KEY(row_key_waktu) REFERENCES dimensi_waktu(row_key_waktu),
	FOREIGN KEY(row_key_kota) REFERENCES dimensi_kota(row_key_kota),
	FOREIGN KEY(row_key_provinsi) REFERENCES dimensi_provinsi(row_key_provinsi),
	FOREIGN KEY(row_key_pelanggan) REFERENCES dimensi_pelanggan(row_key_pelanggan),
	FOREIGN KEY(row_key_pegawai) REFERENCES dimensi_pegawai(row_key_pegawai),
	FOREIGN KEY(row_key_alat) REFERENCES dimensi_alat(row_key_alat),
	UNIQUE(row_key_waktu,
		row_key_kota,
		row_key_provinsi,
		row_key_pelanggan,
		row_key_pegawai,
		row_key_alat)
);