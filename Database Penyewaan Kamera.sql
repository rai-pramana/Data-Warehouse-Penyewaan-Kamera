-- Create

CREATE DATABASE db_penyewaan_kamera

CREATE TABLE tb_jabatan(
	kode_jabatan CHAR(3) NOT NULL,
	nama_jabatan VARCHAR(30),
	PRIMARY KEY(kode_jabatan)
);

CREATE TABLE tb_provinsi(
	kode_provinsi CHAR(3) NOT NULL,
	nama_provinsi VARCHAR(30),
	PRIMARY KEY(kode_provinsi)
);

CREATE TABLE tb_merk(
	kode_merk CHAR(3) NOT NULL,
	nama_merk VARCHAR(30),
	PRIMARY KEY(kode_merk)
);

CREATE TABLE tb_jenis_alat(
	kode_jenis_alat CHAR(3) NOT NULL,
	nama_jenis_alat VARCHAR(30),
	PRIMARY KEY(kode_jenis_alat)
);

CREATE TABLE tb_kota(
	kode_kota CHAR(3) NOT NULL,
	kode_provinsi CHAR(3) NOT NULL,
	nama_kota VARCHAR(30),
	PRIMARY KEY(kode_kota),
	FOREIGN KEY(kode_provinsi) REFERENCES tb_provinsi(kode_provinsi)
);

CREATE TABLE tb_supplier(
	kode_supplier CHAR(3) NOT NULL,
	kode_kota CHAR(3) NOT NULL,
	nama_supplier VARCHAR(30),
	no_tlp_supplier VARCHAR(15),
	alamat_supplier VARCHAR (80),
	PRIMARY KEY(kode_supplier),
	FOREIGN KEY(kode_kota) REFERENCES tb_kota(kode_kota)
);

CREATE TABLE tb_pelanggan(
	kode_pelanggan CHAR(3) NOT NULL,
	kode_kota CHAR(3) NOT NULL,
	nama_pelanggan VARCHAR(30),
	no_tlp_pelanggan VARCHAR(15),
	jenis_kelamin ENUM('L','P'),
	alamat_pelanggan VARCHAR (80),
	PRIMARY KEY(kode_pelanggan),
	FOREIGN KEY(kode_kota) REFERENCES tb_kota(kode_kota)
);

CREATE TABLE tb_pegawai(
	kode_pegawai CHAR(3) NOT NULL,
	kode_kota CHAR(3) NOT NULL,
	kode_jabatan CHAR(3) NOT NULL,
	nama_pegawai VARCHAR(30),
	no_tlp_pegawai VARCHAR(15),
	jenis_kelamin ENUM('L','P'),
	alamat_pegawai VARCHAR (80),
	PRIMARY KEY(kode_pegawai),
	FOREIGN KEY(kode_kota) REFERENCES tb_kota(kode_kota),
	FOREIGN KEY(kode_jabatan) REFERENCES tb_jabatan(kode_jabatan)
);

CREATE TABLE tb_pemasokan(
	kode_pasok CHAR(3) NOT NULL,
	kode_pegawai CHAR(3) NOT NULL,
	kode_supplier CHAR(3) NOT NULL,
	tgl_pasok DATE,
	total_pasok INT,
	total_biaya_pasok BIGINT,
	PRIMARY KEY(kode_pasok),
	FOREIGN KEY(kode_pegawai) REFERENCES tb_pegawai(kode_pegawai),
	FOREIGN KEY(kode_supplier) REFERENCES tb_supplier(kode_supplier)
);

CREATE TABLE tb_alat(
	kode_alat CHAR(3) NOT NULL,
	kode_merk CHAR(3) NOT NULL,
	kode_jenis_alat CHAR(3) NOT NULL,
	nama_alat VARCHAR(50),
	harga_sewa_alat BIGINT,
	stok_alat INT,
	PRIMARY KEY(kode_alat),
	FOREIGN KEY(kode_merk) REFERENCES tb_merk(kode_merk),
	FOREIGN KEY(kode_jenis_alat) REFERENCES tb_jenis_alat(kode_jenis_alat)
);

CREATE TABLE tb_penyewaan(
	kode_sewa CHAR(3) NOT NULL,
	kode_pegawai CHAR(3) NOT NULL,
	kode_pelanggan CHAR(3) NOT NULL,
	tgl_sewa DATE,
	tgl_jatuh_tempo DATE,
	total_sewa INT,
	total_biaya_sewa BIGINT,
	tgl_pengembalian DATE,
	status_sewa ENUM('Selesai','Belum Selesai'),
	PRIMARY KEY(kode_sewa),
	FOREIGN KEY(kode_pegawai) REFERENCES tb_pegawai(kode_pegawai),
	FOREIGN KEY(kode_pelanggan) REFERENCES tb_pelanggan(kode_pelanggan)
);

CREATE TABLE tb_detail_penyewaan(
	kode_sewa CHAR(3) NOT NULL,
	kode_alat CHAR(3) NOT NULL,
	jumlah_sewa INT,
	harga_sewa BIGINT,
	FOREIGN KEY(kode_sewa) REFERENCES tb_penyewaan(kode_sewa),
	FOREIGN KEY(kode_alat) REFERENCES tb_alat(kode_alat)
);

CREATE TABLE tb_detail_pemasokan(
	kode_pasok CHAR(3) NOT NULL,
	kode_alat CHAR(3) NOT NULL,
	jumlah_pasok INT,
	harga_beli BIGINT,
	FOREIGN KEY(kode_pasok) REFERENCES tb_pemasokan(kode_pasok),
	FOREIGN KEY(kode_alat) REFERENCES tb_alat(kode_alat)
);

CREATE TABLE tb_denda(
	kode_sewa CHAR(3) NOT NULL,
	kode_denda CHAR(3),
	biaya_denda BIGINT,
	keterangan_denda VARCHAR(100),
	PRIMARY KEY(kode_sewa),
	FOREIGN KEY(kode_sewa) REFERENCES tb_penyewaan(kode_sewa)
);


-- Insert

INSERT  INTO tb_jabatan(kode_jabatan,nama_jabatan) VALUES 
('B01','Manager'),
('B02','Kasir'),
('B03','Teknisi'),
('B04','IT Support'),
('B05','Operasional Staff'),
('B06','Supply Chain Staff'),
('B07','IT Senior'),
('B08','Security'),
('B09','Accounting Staff'),
('B10','Office Boy');

INSERT  INTO tb_provinsi(kode_provinsi,nama_provinsi) VALUES 
('N01','Bali'),
('N02','Jawa Timur'),
('N03','Jawa Tengah'),
('N04','Yogyakarta'),
('N05','Jawa Barat'),
('N06','Aceh'),
('N07','Kalimantan Timur'),
('N08','Kalimantan Barat');

INSERT  INTO tb_kota(kode_kota,kode_provinsi,nama_kota) VALUES 
('T01','N01','Denpasar'),
('T02','N01','Badung'),
('T03','N01','Tabanan'),
('T04','N01','Buleleng'),
('T05','N01','Bangli'),
('T06','N01','Gianyar'),
('T07','N01','Klungkung'),
('T08','N01','Denpasar'),
('T09','N02','Surabaya'),
('T10','N03','Klaten');

INSERT INTO tb_supplier(kode_supplier,kode_kota,nama_supplier,no_tlp_supplier,alamat_supplier) VALUES 
('S01','T01','PT. Wira Niaga Graha','0213924667','Denpasar'),
('S02','T01','PT. Panca Bakti Persada','061547370','Denpasar'),
('S03','T02','PT. Indah Anugrah Abadi','0215684735','Badung'),
('S04','T02','PT. Tiga Ombak','0217229045','Badung'),
('S05','T03','PT. Robina Anugerah Abadi','02145850647','Tabanan'),
('S06','T03','PT. Nindia Kasih Bersaudara','02175817966','Tabanan'),
('S07','T04','PT. Dwiguna Intijati','0217817290','Buleleng'),
('S08','T05','PT. Multi Indosaintifik','02145857848','Bangli'),
('S09','T06','PT. Indopack Nusantara','0217355092','Gianyar'),
('S10','T07','PT. Disindo Utama','0222034400','Klungkung');

INSERT  INTO tb_pegawai(kode_pegawai,kode_kota,kode_jabatan,nama_pegawai,no_tlp_pegawai,jenis_kelamin,alamat_pegawai) VALUES 
('P01','T01','B01','Selamet','081188997766','L','Denpasar'),
('P02','T02','B02','Budi Santo','081188997711','L','Badung'),
('P03','T06','B02','Wira','081188992222','L','Gianyar'),
('P04','T02','B03','Yudi','081188994433','L','Badung'),
('P05','T01','B05','Wahyu','081188667777','L','Denpasar'),
('P06','T06','B06','Mahesa','081188998888','L','Gianyar'),
('P07','T01','B06','Agung','081188990000','L','Denpasar'),
('P08','T01','B07','Sekar','081188123465','P','Denpasar'),
('P09','T03','B07','Putri','081188994478','P','Tabanan'),
('P10','T02','B09','Nonik','081188991100','P','Badung');

INSERT  INTO tb_pelanggan(kode_pelanggan,kode_kota,nama_pelanggan,no_tlp_pelanggan,jenis_kelamin,alamat_pelanggan) VALUES 
('K01','T01','Agung Wahyu','081188991111','L','Denpasar'),
('K02','T01','Ananda Pannadhika','081188992222','L','Denpasar'),
('K03','T06','Rai Pramana','081188993333','L','Gianyar'),
('K04','T06','Karcana Putra','081188994444','L','Gianyar'),
('K05','T02','Ade Wirajaya','081188665555','L','Badung'),
('K06','T02','Alex Bramartha','081188996666','L','Badung'),
('K07','T03','Krishna Mahardika','08118897777','L','Tabanan'),
('K08','T03','Dhemas Supriadi','081188128888','L','Tabanan'),
('K09','T07','Della Ariani','081188999999','P','Klungkung'),
('K10','T07','Nadia Maharani','081188990000','P','Klungkung');

INSERT  INTO tb_merk(kode_merk,nama_merk) VALUES 
('M01','Canon'),
('M02','Sony'),
('M03','FujiFilm'),
('M04','Panasonic'),
('M05','Olympus'),
('M06','Leica'),
('M07','GoPro'),
('M08','Pentax'),
('M09','Kodak'),
('M10','Ricoh');

INSERT  INTO tb_jenis_alat(kode_jenis_alat,nama_jenis_alat) VALUES 
('J01','Kamera DSLR'),
('J02','Kamera Mirrorless'),
('J03','Action Camera'),
('J04','360 degree Camera'),
('J05','Digital Cinema Camera'),
('J06','Webcam'),
('J07','Drone'),
('J08','Baterai'),
('J09','Stand'),
('J10','Lensa');

INSERT  INTO tb_alat(kode_alat,kode_merk,kode_jenis_alat,nama_alat,harga_sewa_alat,stok_alat) VALUES 
('A01','M01','J01','Canon EOS Rebel SL2',300000,0),
('A02','M01','J01','Canon EOS 90D',250000,0),
('A03','M01','J02','Canon M50 Mark  II',200000,0),
('A04','M02','J09','Tripod Sony Kaiser 234',50000,0),
('A05','M01','J10','Lensa Canon EF 100-400mm F/4,5-5,6l',100000,0),
('A06','M03','J02','FujiFilm X-S10 Mirrorless',250000,0),
('A07','M02','J02','Sony Alpha A6000',350000,0),
('A08','M07','J03','GoPro Hero 9',150000,0),
('A09','M06','J05','Leica M10 Black',400000,0),
('A10','M05','J05','Olympus OM-D E-M10 Mark III',500000,0);

INSERT  INTO tb_pemasokan(kode_pasok,kode_pegawai,kode_supplier,tgl_pasok,total_pasok,total_biaya_pasok) VALUES 
('D01','P06','S01','2021-01-10',0,0),
('D02','P07','S02','2021-01-15',0,0),
('D03','P06','S03','2021-01-20',0,0),
('D04','P07','S04','2021-01-25',0,0),
('D05','P06','S05','2021-01-30',0,0),
('D06','P07','S06','2021-02-05',0,0),
('D07','P06','S07','2021-02-10',0,0),
('D08','P07','S08','2021-03-10',0,0),
('D09','P06','S09','2021-03-20',0,0),
('D10','P06','S01','2021-03-30',0,0),
('D11','P06','S01','2021-04-10',0,0),
('D12','P07','S02','2021-04-15',0,0),
('D13','P06','S03','2021-04-20',0,0),
('D14','P07','S04','2021-04-25',0,0),
('D15','P06','S05','2021-04-30',0,0),
('D16','P07','S06','2021-05-05',0,0),
('D17','P06','S07','2021-05-10',0,0),
('D18','P07','S08','2021-05-10',0,0),
('D19','P06','S09','2021-05-20',0,0),
('D20','P06','S01','2021-06-10',0,0),
('D21','P07','S02','2021-06-15',0,0),
('D22','P06','S03','2021-06-20',0,0),
('D23','P07','S04','2021-06-25',0,0),
('D24','P06','S05','2021-06-30',0,0),
('D25','P07','S06','2021-07-05',0,0),
('D26','P06','S07','2021-07-10',0,0),
('D27','P07','S08','2021-07-10',0,0),
('D28','P06','S09','2021-07-20',0,0),
('D29','P06','S01','2021-08-10',0,0),
('D30','P07','S02','2021-08-15',0,0),
('D31','P06','S03','2021-08-20',0,0),
('D32','P07','S04','2021-08-25',0,0),
('D33','P06','S05','2021-08-30',0,0),
('D34','P07','S06','2021-09-05',0,0),
('D35','P06','S07','2021-09-10',0,0),
('D36','P07','S08','2021-09-10',0,0),
('D37','P06','S09','2021-09-20',0,0),
('D38','P06','S01','2021-10-10',0,0),
('D39','P07','S02','2021-10-15',0,0),
('D40','P06','S03','2021-10-20',0,0),
('D41','P07','S04','2021-10-25',0,0),
('D42','P06','S05','2021-10-30',0,0),
('D43','P07','S06','2021-11-05',0,0),
('D44','P06','S07','2021-11-10',0,0),
('D45','P07','S08','2021-11-10',0,0),
('D46','P06','S09','2021-11-20',0,0),
('D47','P06','S01','2021-12-10',0,0),
('D48','P07','S02','2021-12-15',0,0),
('D49','P06','S03','2021-12-20',0,0),
('D50','P07','S04','2021-12-25',0,0);

INSERT  INTO tb_detail_pemasokan(kode_pasok,kode_alat,jumlah_pasok,harga_beli) VALUES 
('D01','A01',5,7500000),
('D01','A02',5,20000000),
('D02','A01',5,7500000),
('D02','A02',15,20000000),
('D03','A03',5,15000000),
('D03','A04',5,1000000),
('D04','A04',5,1000000),
('D04','A05',15,29000000),
('D05','A05',15,29000000),
('D05','A06',5,22000000),
('D06','A06',10,22000000),
('D07','A07',10,8000000),
('D08','A08',40,7000000),
('D09','A09',10,30000000),
('D10','A10',20,10000000),
('D11','A01',5,7500000),
('D11','A02',5,20000000),
('D12','A01',5,7500000),
('D12','A02',15,20000000),
('D13','A03',5,15000000),
('D13','A04',5,1000000),
('D14','A04',5,1000000),
('D14','A05',15,29000000),
('D15','A05',15,29000000),
('D15','A06',5,22000000),
('D16','A06',10,22000000),
('D17','A07',10,8000000),
('D18','A08',40,7000000),
('D19','A09',10,30000000),
('D20','A10',20,10000000),
('D21','A01',5,7500000),
('D21','A02',5,20000000),
('D22','A01',5,7500000),
('D22','A02',15,20000000),
('D23','A03',5,15000000),
('D23','A04',5,1000000),
('D24','A04',5,1000000),
('D24','A05',15,29000000),
('D25','A05',15,29000000),
('D25','A06',5,22000000),
('D26','A06',10,22000000),
('D27','A07',10,8000000),
('D28','A08',40,7000000),
('D29','A09',10,30000000),
('D30','A10',20,10000000),
('D31','A01',5,7500000),
('D31','A02',5,20000000),
('D32','A01',5,7500000),
('D32','A02',15,20000000),
('D33','A03',5,15000000),
('D33','A04',5,1000000),
('D34','A04',5,1000000),
('D34','A05',15,29000000),
('D35','A05',15,29000000),
('D35','A06',5,22000000),
('D36','A06',10,22000000),
('D37','A07',10,8000000),
('D38','A08',40,7000000),
('D39','A09',10,30000000),
('D40','A10',20,10000000),
('D41','A01',5,7500000),
('D41','A02',5,20000000),
('D42','A01',5,7500000),
('D42','A02',15,20000000),
('D43','A03',5,15000000),
('D43','A04',5,1000000),
('D44','A04',5,1000000),
('D44','A05',15,29000000),
('D45','A05',15,29000000),
('D45','A06',5,22000000),
('D46','A06',10,22000000),
('D47','A07',10,8000000),
('D48','A08',40,7000000),
('D49','A09',10,30000000),
('D50','A10',20,10000000);

INSERT  INTO tb_penyewaan(kode_sewa,kode_pegawai,kode_pelanggan,tgl_sewa,tgl_jatuh_tempo,total_sewa,
                          total_biaya_sewa,tgl_pengembalian,status_sewa) VALUES 
('R01','P02','K01','2021-05-01','2021-05-10',0,0,'2021-05-09','Selesai'),
('R02','P03','K02','2021-05-05','2021-05-15',0,0,'2021-05-14','Selesai'),
('R03','P02','K03','2021-05-08','2021-05-18',0,0,'2021-05-19','Selesai'),
('R04','P03','K04','2021-05-10','2021-05-20',0,0,'2021-05-21','Selesai'),
('R05','P02','K05','2021-05-12','2021-05-22',0,0,'2021-05-21','Selesai'),
('R06','P03','K06','2021-05-18','2021-05-28',0,0,'2021-05-27','Selesai'),
('R07','P02','K07','2021-05-25','2021-06-05',0,0,'2021-06-03','Selesai'),
('R08','P03','K08','2021-06-01','2021-06-10',0,0,'2021-06-09','Selesai'),
('R09','P02','K09','2021-06-12','2021-06-22',0,0,'2021-06-23','Selesai'),
('R10','P03','K10','2021-06-12','2021-06-23',0,0,'2021-06-24','Selesai'),
('R11','P02','K01','2021-06-13','2021-06-23',0,0,'2021-06-24','Selesai'),
('R12','P03','K02','2021-06-13','2021-06-23',0,0,'2021-06-24','Selesai'),
('R13','P02','K03','2021-06-14','2021-06-24',0,0,'2021-06-25','Selesai'),
('R14','P03','K04','2021-06-14','2021-06-24',0,0,'2021-06-25','Selesai'),
('R15','P02','K05','2021-06-14','2021-06-24',0,0,'2021-06-25','Selesai'),
('R16','P03','K06','2021-06-15','2021-06-25',0,0,'2021-06-26','Selesai'),
('R17','P02','K07','2021-06-15','2021-06-28',0,0,'2021-06-26','Selesai'),
('R18','P03','K08','2021-06-15','2021-06-28',0,0,'2021-06-26','Selesai'),
('R19','P03','K08','2021-06-15','2021-06-28',0,0,'2021-06-28','Selesai'),
('R20','P03','K08','2021-06-15','2021-06-28',0,0,'2021-06-28','Selesai'),
('R21','P02','K01','2021-07-01','2021-07-10',0,0,'2021-07-09','Selesai'),
('R22','P03','K02','2021-07-05','2021-07-15',0,0,'2021-07-14','Selesai'),
('R23','P02','K03','2021-07-08','2021-07-19',0,0,'2021-07-19','Selesai'),
('R24','P03','K04','2021-07-10','2021-07-26',0,0,'2021-07-21','Selesai'),
('R25','P02','K05','2021-07-12','2021-07-22',0,0,'2021-07-21','Selesai'),
('R26','P03','K06','2021-07-18','2021-07-28',0,0,'2021-07-27','Selesai'),
('R27','P02','K07','2021-07-25','2021-08-05',0,0,'2021-08-03','Selesai'),
('R28','P03','K08','2021-08-01','2021-08-15',0,0,'2021-08-09','Selesai'),
('R29','P02','K09','2021-08-12','2021-08-25',0,0,'2021-08-23','Selesai'),
('R30','P03','K10','2021-08-12','2021-08-28',0,0,'2021-08-24','Selesai'),
('R31','P02','K01','2021-08-13','2021-08-28',0,0,'2021-08-24','Selesai'),
('R32','P03','K02','2021-08-13','2021-08-28',0,0,'2021-08-24','Selesai'),
('R33','P02','K03','2021-08-14','2021-08-28',0,0,'2021-08-25','Selesai'),
('R34','P03','K04','2021-08-14','2021-08-28',0,0,'2021-08-25','Selesai'),
('R35','P02','K05','2021-08-14','2021-08-28',0,0,'2021-08-25','Selesai'),
('R36','P03','K06','2021-08-15','2021-08-28',0,0,'2021-08-26','Selesai'),
('R37','P02','K07','2021-08-15','2021-08-28',0,0,'2021-08-26','Selesai'),
('R38','P03','K08','2021-08-15','2021-08-28',0,0,'2021-08-26','Selesai'),
('R39','P03','K08','2021-08-15','2021-08-28',0,0,'2021-08-28','Selesai'),
('R40','P03','K08','2021-08-15','2021-08-28',0,0,'2021-08-28','Selesai'),
('R41','P02','K01','2021-09-13','2021-09-26',0,0,'2021-09-24','Selesai'),
('R42','P03','K02','2021-09-13','2021-09-26',0,0,'2021-09-24','Selesai'),
('R43','P02','K03','2021-09-14','2021-09-26',0,0,'2021-09-25','Selesai'),
('R44','P03','K04','2021-09-14','2021-09-26',0,0,'2021-09-25','Selesai'),
('R45','P02','K05','2021-09-14','2021-09-27',0,0,'2021-09-25','Selesai'),
('R46','P03','K06','2021-09-15','2021-09-27',0,0,'2021-09-26','Selesai'),
('R47','P02','K07','2021-09-15','2021-09-27',0,0,'2021-09-26','Selesai'),
('R48','P03','K08','2021-09-15','2021-09-28',0,0,'2021-09-26','Selesai'),
('R49','P03','K08','2021-09-15','2021-09-28',0,0,'2021-09-28','Selesai'),
('R50','P03','K08','2021-09-15','2021-09-28',0,0,'2021-09-28','Selesai')
;

INSERT  INTO tb_detail_penyewaan(kode_sewa,kode_alat,jumlah_sewa,harga_sewa) VALUES 
('R01','A01',2,0),
('R01','A02',2,0),
('R02','A02',3,0),
('R02','A03',2,0),
('R03','A03',3,0),
('R03','A04',1,0),
('R04','A04',3,0),
('R04','A05',3,0),
('R05','A05',1,0),
('R06','A06',5,0),
('R06','A07',5,0),
('R07','A07',8,0),
('R08','A08',5,0),
('R09','A09',1,0),
('R10','A10',2,0),
('R11','A01',2,0),
('R12','A02',1,0),
('R13','A03',5,0),
('R14','A04',2,0),
('R15','A05',4,0),
('R16','A06',8,0),
('R17','A07',5,0),
('R18','A08',2,0),
('R19','A09',2,0),
('R20','A10',2,0),
('R21','A01',2,0),
('R21','A02',2,0),
('R22','A02',3,0),
('R22','A03',2,0),
('R23','A03',3,0),
('R23','A04',1,0),
('R24','A04',3,0),
('R24','A05',3,0),
('R25','A05',1,0),
('R26','A06',5,0),
('R26','A07',5,0),
('R27','A07',8,0),
('R28','A08',5,0),
('R29','A09',1,0),
('R30','A10',2,0),
('R31','A01',2,0),
('R32','A02',1,0),
('R33','A03',5,0),
('R34','A04',2,0),
('R35','A05',4,0),
('R36','A06',8,0),
('R37','A07',5,0),
('R38','A08',2,0),
('R39','A09',2,0),
('R40','A10',2,0),
('R41','A01',2,0),
('R42','A02',1,0),
('R43','A03',5,0),
('R44','A04',2,0),
('R45','A05',4,0),
('R46','A06',8,0),
('R47','A07',5,0),
('R48','A08',2,0),
('R49','A09',2,0),
('R50','A10',2,0);

CALL procs_harga_barang(); -- untuk update otomatis harga barang, hapus dulu tg_sewa_rubah

INSERT  INTO tb_denda(kode_sewa,kode_denda,biaya_denda,keterangan_denda) VALUES 
('R01','L01',1000000,'Pengembalian tidak lengkap'),
('R03','L02',50000,'Terlambat pengembalian'),
('R04','L03',50000,'Terlambat pengembalian'),
('R05','L04',1000000,'Pengembalian tidak lengkap'),
('R09','L05',50000,'Terlambat pengembalian'),
('R10','L06',50000,'Terlambat pengembalian'),
('R11','L07',50000,'Terlambat pengembalian'),
('R12','L08',50000,'Terlambat pengembalian'),
('R13','L09',50000,'Terlambat pengembalian'),
('R14','L10',50000,'Terlambat pengembalian'),
('R15','L11',50000,'Terlambat pengembalian'),
('R16','L12',50000,'Terlambat pengembalian');
