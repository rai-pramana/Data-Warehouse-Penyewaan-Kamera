/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - dwh_penyewaan_kamera
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dwh_penyewaan_kamera` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `dwh_penyewaan_kamera`;

/*Table structure for table `dimensi_alat` */

DROP TABLE IF EXISTS `dimensi_alat`;

CREATE TABLE `dimensi_alat` (
  `row_key_alat` int(11) NOT NULL AUTO_INCREMENT,
  `kode_alat` char(5) NOT NULL,
  `nama_alat` varchar(50) DEFAULT NULL,
  `harga_sewa_alat` bigint(20) DEFAULT NULL,
  `nama_merk` varchar(30) DEFAULT NULL,
  `nama_jenis_alat` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_alat`),
  UNIQUE KEY `row_key_alat` (`row_key_alat`,`kode_alat`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_alat` */

insert  into `dimensi_alat`(`row_key_alat`,`kode_alat`,`nama_alat`,`harga_sewa_alat`,`nama_merk`,`nama_jenis_alat`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'A01','Canon EOS Rebel SL2',300000,'Canon','Kamera DSLR','2022-12-20','9999-12-31','Y'),
(2,'A02','Canon EOS 90D',250000,'Canon','Kamera DSLR','2022-12-20','9999-12-31','Y'),
(3,'A03','Canon M50 Mark  II',200000,'Canon','Kamera Mirrorless','2022-12-20','9999-12-31','Y'),
(4,'A04','Tripod Sony Kaiser 234',50000,'Sony','Stand','2022-12-20','9999-12-31','Y'),
(5,'A05','Lensa Canon EF 100-400mm F/4,5-5,6l',100000,'Canon','Lensa','2022-12-20','9999-12-31','Y'),
(6,'A06','FujiFilm X-S10 Mirrorless',250000,'FujiFilm','Kamera Mirrorless','2022-12-20','9999-12-31','Y'),
(7,'A07','Sony Alpha A6000',350000,'Sony','Kamera Mirrorless','2022-12-20','9999-12-31','Y'),
(8,'A08','GoPro Hero 9',150000,'GoPro','Action Camera','2022-12-20','9999-12-31','Y'),
(9,'A09','Leica M10 Black',400000,'Leica','Digital Cinema Camera','2022-12-20','9999-12-31','Y'),
(10,'A10','Olympus OM-D E-M10 Mark III',500000,'Olympus','Digital Cinema Camera','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_kota` */

DROP TABLE IF EXISTS `dimensi_kota`;

CREATE TABLE `dimensi_kota` (
  `row_key_kota` int(11) NOT NULL AUTO_INCREMENT,
  `kode_kota` char(5) NOT NULL,
  `nama_kota` varchar(30) DEFAULT NULL,
  `nama_provinsi` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_kota`),
  UNIQUE KEY `row_key_kota` (`row_key_kota`,`kode_kota`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_kota` */

insert  into `dimensi_kota`(`row_key_kota`,`kode_kota`,`nama_kota`,`nama_provinsi`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'T01','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(2,'T02','Badung','Bali','2022-12-20','9999-12-31','Y'),
(3,'T03','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(4,'T04','Buleleng','Bali','2022-12-20','9999-12-31','Y'),
(5,'T05','Bangli','Bali','2022-12-20','9999-12-31','Y'),
(6,'T06','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(7,'T07','Klungkung','Bali','2022-12-20','9999-12-31','Y'),
(8,'T08','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(9,'T09','Surabaya','Jawa Timur','2022-12-20','9999-12-31','Y'),
(10,'T10','Klaten','Jawa Tengah','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_pegawai` */

DROP TABLE IF EXISTS `dimensi_pegawai`;

CREATE TABLE `dimensi_pegawai` (
  `row_key_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `kode_pegawai` char(5) NOT NULL,
  `nama_pegawai` varchar(30) DEFAULT NULL,
  `no_tlp_pegawai` varchar(15) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `alamat_pegawai` varchar(80) DEFAULT NULL,
  `nama_jabatan` varchar(30) DEFAULT NULL,
  `nama_kota` varchar(30) DEFAULT NULL,
  `nama_provinsi` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_pegawai`),
  UNIQUE KEY `row_key_pegawai` (`row_key_pegawai`,`kode_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_pegawai` */

insert  into `dimensi_pegawai`(`row_key_pegawai`,`kode_pegawai`,`nama_pegawai`,`no_tlp_pegawai`,`jenis_kelamin`,`alamat_pegawai`,`nama_jabatan`,`nama_kota`,`nama_provinsi`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'P01','Selamet','081188997766','L','Denpasar','Manager','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(2,'P02','Budi Santo','081188997711','L','Badung','Kasir','Badung','Bali','2022-12-20','9999-12-31','Y'),
(3,'P03','Wira','081188992222','L','Gianyar','Kasir','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(4,'P04','Yudi','081188994433','L','Badung','Teknisi','Badung','Bali','2022-12-20','9999-12-31','Y'),
(5,'P05','Wahyu','081188667777','L','Denpasar','Operasional Staff','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(6,'P06','Mahesa','081188998888','L','Gianyar','Supply Chain Staff','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(7,'P07','Agung','081188990000','L','Denpasar','Supply Chain Staff','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(8,'P08','Sekar','081188123465','P','Denpasar','IT Senior','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(9,'P09','Putri','081188994478','P','Tabanan','IT Senior','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(10,'P10','Nonik','081188991100','P','Badung','Accounting Staff','Badung','Bali','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_pelanggan` */

DROP TABLE IF EXISTS `dimensi_pelanggan`;

CREATE TABLE `dimensi_pelanggan` (
  `row_key_pelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `kode_pelanggan` char(5) NOT NULL,
  `nama_pelanggan` varchar(30) DEFAULT NULL,
  `no_tlp_pelanggan` varchar(15) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `alamat_pelanggan` varchar(80) DEFAULT NULL,
  `nama_kota` varchar(30) DEFAULT NULL,
  `nama_provinsi` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_pelanggan`),
  UNIQUE KEY `row_key_pelanggan` (`row_key_pelanggan`,`kode_pelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_pelanggan` */

insert  into `dimensi_pelanggan`(`row_key_pelanggan`,`kode_pelanggan`,`nama_pelanggan`,`no_tlp_pelanggan`,`jenis_kelamin`,`alamat_pelanggan`,`nama_kota`,`nama_provinsi`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'K01','Agung Wahyu','081188991111','L','Denpasar','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(2,'K02','Ananda Pannadhika','081188992222','L','Denpasar','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(3,'K03','Rai Pramana','081188993333','L','Gianyar','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(4,'K04','Karcana Putra','081188994444','L','Gianyar','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(5,'K05','Ade Wirajaya','081188665555','L','Badung','Badung','Bali','2022-12-20','9999-12-31','Y'),
(6,'K06','Alex Bramartha','081188996666','L','Badung','Badung','Bali','2022-12-20','9999-12-31','Y'),
(7,'K07','Krishna Mahardika','08118897777','L','Tabanan','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(8,'K08','Dhemas Supriadi','081188128888','L','Tabanan','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(9,'K09','Della Ariani','081188999999','P','Klungkung','Klungkung','Bali','2022-12-20','9999-12-31','Y'),
(10,'K10','Nadia Maharani','081188990000','P','Klungkung','Klungkung','Bali','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_provinsi` */

DROP TABLE IF EXISTS `dimensi_provinsi`;

CREATE TABLE `dimensi_provinsi` (
  `row_key_provinsi` int(11) NOT NULL AUTO_INCREMENT,
  `kode_provinsi` char(5) NOT NULL,
  `nama_provinsi` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_provinsi`),
  UNIQUE KEY `row_key_provinsi` (`row_key_provinsi`,`kode_provinsi`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_provinsi` */

insert  into `dimensi_provinsi`(`row_key_provinsi`,`kode_provinsi`,`nama_provinsi`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'N01','Bali','2022-12-20','9999-12-31','Y'),
(2,'N02','Jawa Timur','2022-12-20','9999-12-31','Y'),
(3,'N03','Jawa Tengah','2022-12-20','9999-12-31','Y'),
(4,'N04','Yogyakarta','2022-12-20','9999-12-31','Y'),
(5,'N05','Jawa Barat','2022-12-20','9999-12-31','Y'),
(6,'N06','Aceh','2022-12-20','9999-12-31','Y'),
(7,'N07','Kalimantan Timur','2022-12-20','9999-12-31','Y'),
(8,'N08','Kalimantan Barat','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_supplier` */

DROP TABLE IF EXISTS `dimensi_supplier`;

CREATE TABLE `dimensi_supplier` (
  `row_key_supplier` int(11) NOT NULL AUTO_INCREMENT,
  `kode_supplier` char(5) NOT NULL,
  `nama_supplier` varchar(30) DEFAULT NULL,
  `no_tlp_supplier` varchar(15) DEFAULT NULL,
  `alamat_supplier` varchar(80) DEFAULT NULL,
  `nama_kota` varchar(30) DEFAULT NULL,
  `nama_provinsi` varchar(30) DEFAULT NULL,
  `valid_awal` date DEFAULT NULL,
  `valid_akhir` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_supplier`),
  UNIQUE KEY `row_key_supplier` (`row_key_supplier`,`kode_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_supplier` */

insert  into `dimensi_supplier`(`row_key_supplier`,`kode_supplier`,`nama_supplier`,`no_tlp_supplier`,`alamat_supplier`,`nama_kota`,`nama_provinsi`,`valid_awal`,`valid_akhir`,`current_flag`) values 
(1,'S01','PT. Wira Niaga Graha','0213924667','Denpasar','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(2,'S02','PT. Panca Bakti Persada','061547370','Denpasar','Denpasar','Bali','2022-12-20','9999-12-31','Y'),
(3,'S03','PT. Indah Anugrah Abadi','0215684735','Badung','Badung','Bali','2022-12-20','9999-12-31','Y'),
(4,'S04','PT. Tiga Ombak','0217229045','Badung','Badung','Bali','2022-12-20','9999-12-31','Y'),
(5,'S05','PT. Robina Anugerah Abadi','02145850647','Tabanan','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(6,'S06','PT. Nindia Kasih Bersaudara','02175817966','Tabanan','Tabanan','Bali','2022-12-20','9999-12-31','Y'),
(7,'S07','PT. Dwiguna Intijati','0217817290','Buleleng','Buleleng','Bali','2022-12-20','9999-12-31','Y'),
(8,'S08','PT. Multi Indosaintifik','02145857848','Bangli','Bangli','Bali','2022-12-20','9999-12-31','Y'),
(9,'S09','PT. Indopack Nusantara','0217355092','Gianyar','Gianyar','Bali','2022-12-20','9999-12-31','Y'),
(10,'S10','PT. Disindo Utama','0222034400','Klungkung','Klungkung','Bali','2022-12-20','9999-12-31','Y');

/*Table structure for table `dimensi_waktu` */

DROP TABLE IF EXISTS `dimensi_waktu`;

CREATE TABLE `dimensi_waktu` (
  `row_key_waktu` int(11) NOT NULL AUTO_INCREMENT,
  `kode_waktu` char(5) NOT NULL,
  `tahun` year(4) DEFAULT NULL,
  `kuartal` enum('1','2','3','4') DEFAULT NULL,
  `bulan` enum('Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember') DEFAULT NULL,
  `hari` enum('Minggu','Senin','Selasa','Rabu','Kamis','Jumat','Sabtu') DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `current_flag` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`row_key_waktu`),
  UNIQUE KEY `row_key_waktu` (`row_key_waktu`,`kode_waktu`),
  UNIQUE KEY `tahun` (`tahun`,`kuartal`,`bulan`,`hari`,`tanggal`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8mb4;

/*Data for the table `dimensi_waktu` */

insert  into `dimensi_waktu`(`row_key_waktu`,`kode_waktu`,`tahun`,`kuartal`,`bulan`,`hari`,`tanggal`,`current_flag`) values 
(1,'1',2021,'1','Januari','Jumat','2021-01-01','Y'),
(2,'2',2021,'1','Januari','Sabtu','2021-01-02','Y'),
(3,'3',2021,'1','Januari','Minggu','2021-01-03','Y'),
(4,'4',2021,'1','Januari','Senin','2021-01-04','Y'),
(5,'5',2021,'1','Januari','Selasa','2021-01-05','Y'),
(6,'6',2021,'1','Januari','Rabu','2021-01-06','Y'),
(7,'7',2021,'1','Januari','Kamis','2021-01-07','Y'),
(8,'8',2021,'1','Januari','Jumat','2021-01-08','Y'),
(9,'9',2021,'1','Januari','Sabtu','2021-01-09','Y'),
(10,'10',2021,'1','Januari','Minggu','2021-01-10','Y'),
(11,'11',2021,'1','Januari','Senin','2021-01-11','Y'),
(12,'12',2021,'1','Januari','Selasa','2021-01-12','Y'),
(13,'13',2021,'1','Januari','Rabu','2021-01-13','Y'),
(14,'14',2021,'1','Januari','Kamis','2021-01-14','Y'),
(15,'15',2021,'1','Januari','Jumat','2021-01-15','Y'),
(16,'16',2021,'1','Januari','Sabtu','2021-01-16','Y'),
(17,'17',2021,'1','Januari','Minggu','2021-01-17','Y'),
(18,'18',2021,'1','Januari','Senin','2021-01-18','Y'),
(19,'19',2021,'1','Januari','Selasa','2021-01-19','Y'),
(20,'20',2021,'1','Januari','Rabu','2021-01-20','Y'),
(21,'21',2021,'1','Januari','Kamis','2021-01-21','Y'),
(22,'22',2021,'1','Januari','Jumat','2021-01-22','Y'),
(23,'23',2021,'1','Januari','Sabtu','2021-01-23','Y'),
(24,'24',2021,'1','Januari','Minggu','2021-01-24','Y'),
(25,'25',2021,'1','Januari','Senin','2021-01-25','Y'),
(26,'26',2021,'1','Januari','Selasa','2021-01-26','Y'),
(27,'27',2021,'1','Januari','Rabu','2021-01-27','Y'),
(28,'28',2021,'1','Januari','Kamis','2021-01-28','Y'),
(29,'29',2021,'1','Januari','Jumat','2021-01-29','Y'),
(30,'30',2021,'1','Januari','Sabtu','2021-01-30','Y'),
(31,'31',2021,'1','Januari','Minggu','2021-01-31','Y'),
(32,'32',2021,'1','Februari','Senin','2021-02-01','Y'),
(33,'33',2021,'1','Februari','Selasa','2021-02-02','Y'),
(34,'34',2021,'1','Februari','Rabu','2021-02-03','Y'),
(35,'35',2021,'1','Februari','Kamis','2021-02-04','Y'),
(36,'36',2021,'1','Februari','Jumat','2021-02-05','Y'),
(37,'37',2021,'1','Februari','Sabtu','2021-02-06','Y'),
(38,'38',2021,'1','Februari','Minggu','2021-02-07','Y'),
(39,'39',2021,'1','Februari','Senin','2021-02-08','Y'),
(40,'40',2021,'1','Februari','Selasa','2021-02-09','Y'),
(41,'41',2021,'1','Februari','Rabu','2021-02-10','Y'),
(42,'42',2021,'1','Februari','Kamis','2021-02-11','Y'),
(43,'43',2021,'1','Februari','Jumat','2021-02-12','Y'),
(44,'44',2021,'1','Februari','Sabtu','2021-02-13','Y'),
(45,'45',2021,'1','Februari','Minggu','2021-02-14','Y'),
(46,'46',2021,'1','Februari','Senin','2021-02-15','Y'),
(47,'47',2021,'1','Februari','Selasa','2021-02-16','Y'),
(48,'48',2021,'1','Februari','Rabu','2021-02-17','Y'),
(49,'49',2021,'1','Februari','Kamis','2021-02-18','Y'),
(50,'50',2021,'1','Februari','Jumat','2021-02-19','Y'),
(51,'51',2021,'1','Februari','Sabtu','2021-02-20','Y'),
(52,'52',2021,'1','Februari','Minggu','2021-02-21','Y'),
(53,'53',2021,'1','Februari','Senin','2021-02-22','Y'),
(54,'54',2021,'1','Februari','Selasa','2021-02-23','Y'),
(55,'55',2021,'1','Februari','Rabu','2021-02-24','Y'),
(56,'56',2021,'1','Februari','Kamis','2021-02-25','Y'),
(57,'57',2021,'1','Februari','Jumat','2021-02-26','Y'),
(58,'58',2021,'1','Februari','Sabtu','2021-02-27','Y'),
(59,'59',2021,'1','Februari','Minggu','2021-02-28','Y'),
(60,'60',2021,'1','Maret','Senin','2021-03-01','Y'),
(61,'61',2021,'1','Maret','Selasa','2021-03-02','Y'),
(62,'62',2021,'1','Maret','Rabu','2021-03-03','Y'),
(63,'63',2021,'1','Maret','Kamis','2021-03-04','Y'),
(64,'64',2021,'1','Maret','Jumat','2021-03-05','Y'),
(65,'65',2021,'1','Maret','Sabtu','2021-03-06','Y'),
(66,'66',2021,'1','Maret','Minggu','2021-03-07','Y'),
(67,'67',2021,'1','Maret','Senin','2021-03-08','Y'),
(68,'68',2021,'1','Maret','Selasa','2021-03-09','Y'),
(69,'69',2021,'1','Maret','Rabu','2021-03-10','Y'),
(70,'70',2021,'1','Maret','Kamis','2021-03-11','Y'),
(71,'71',2021,'1','Maret','Jumat','2021-03-12','Y'),
(72,'72',2021,'1','Maret','Sabtu','2021-03-13','Y'),
(73,'73',2021,'1','Maret','Minggu','2021-03-14','Y'),
(74,'74',2021,'1','Maret','Senin','2021-03-15','Y'),
(75,'75',2021,'1','Maret','Selasa','2021-03-16','Y'),
(76,'76',2021,'1','Maret','Rabu','2021-03-17','Y'),
(77,'77',2021,'1','Maret','Kamis','2021-03-18','Y'),
(78,'78',2021,'1','Maret','Jumat','2021-03-19','Y'),
(79,'79',2021,'1','Maret','Sabtu','2021-03-20','Y'),
(80,'80',2021,'1','Maret','Minggu','2021-03-21','Y'),
(81,'81',2021,'1','Maret','Senin','2021-03-22','Y'),
(82,'82',2021,'1','Maret','Selasa','2021-03-23','Y'),
(83,'83',2021,'1','Maret','Rabu','2021-03-24','Y'),
(84,'84',2021,'1','Maret','Kamis','2021-03-25','Y'),
(85,'85',2021,'1','Maret','Jumat','2021-03-26','Y'),
(86,'86',2021,'1','Maret','Sabtu','2021-03-27','Y'),
(87,'87',2021,'1','Maret','Minggu','2021-03-28','Y'),
(88,'88',2021,'1','Maret','Senin','2021-03-29','Y'),
(89,'89',2021,'1','Maret','Selasa','2021-03-30','Y'),
(90,'90',2021,'1','Maret','Rabu','2021-03-31','Y'),
(91,'91',2021,'2','April','Kamis','2021-04-01','Y'),
(92,'92',2021,'2','April','Jumat','2021-04-02','Y'),
(93,'93',2021,'2','April','Sabtu','2021-04-03','Y'),
(94,'94',2021,'2','April','Minggu','2021-04-04','Y'),
(95,'95',2021,'2','April','Senin','2021-04-05','Y'),
(96,'96',2021,'2','April','Selasa','2021-04-06','Y'),
(97,'97',2021,'2','April','Rabu','2021-04-07','Y'),
(98,'98',2021,'2','April','Kamis','2021-04-08','Y'),
(99,'99',2021,'2','April','Jumat','2021-04-09','Y'),
(100,'100',2021,'2','April','Sabtu','2021-04-10','Y'),
(101,'101',2021,'2','April','Minggu','2021-04-11','Y'),
(102,'102',2021,'2','April','Senin','2021-04-12','Y'),
(103,'103',2021,'2','April','Selasa','2021-04-13','Y'),
(104,'104',2021,'2','April','Rabu','2021-04-14','Y'),
(105,'105',2021,'2','April','Kamis','2021-04-15','Y'),
(106,'106',2021,'2','April','Jumat','2021-04-16','Y'),
(107,'107',2021,'2','April','Sabtu','2021-04-17','Y'),
(108,'108',2021,'2','April','Minggu','2021-04-18','Y'),
(109,'109',2021,'2','April','Senin','2021-04-19','Y'),
(110,'110',2021,'2','April','Selasa','2021-04-20','Y'),
(111,'111',2021,'2','April','Rabu','2021-04-21','Y'),
(112,'112',2021,'2','April','Kamis','2021-04-22','Y'),
(113,'113',2021,'2','April','Jumat','2021-04-23','Y'),
(114,'114',2021,'2','April','Sabtu','2021-04-24','Y'),
(115,'115',2021,'2','April','Minggu','2021-04-25','Y'),
(116,'116',2021,'2','April','Senin','2021-04-26','Y'),
(117,'117',2021,'2','April','Selasa','2021-04-27','Y'),
(118,'118',2021,'2','April','Rabu','2021-04-28','Y'),
(119,'119',2021,'2','April','Kamis','2021-04-29','Y'),
(120,'120',2021,'2','April','Jumat','2021-04-30','Y'),
(121,'121',2021,'2','Mei','Sabtu','2021-05-01','Y'),
(122,'122',2021,'2','Mei','Minggu','2021-05-02','Y'),
(123,'123',2021,'2','Mei','Senin','2021-05-03','Y'),
(124,'124',2021,'2','Mei','Selasa','2021-05-04','Y'),
(125,'125',2021,'2','Mei','Rabu','2021-05-05','Y'),
(126,'126',2021,'2','Mei','Kamis','2021-05-06','Y'),
(127,'127',2021,'2','Mei','Jumat','2021-05-07','Y'),
(128,'128',2021,'2','Mei','Sabtu','2021-05-08','Y'),
(129,'129',2021,'2','Mei','Minggu','2021-05-09','Y'),
(130,'130',2021,'2','Mei','Senin','2021-05-10','Y'),
(131,'131',2021,'2','Mei','Selasa','2021-05-11','Y'),
(132,'132',2021,'2','Mei','Rabu','2021-05-12','Y'),
(133,'133',2021,'2','Mei','Kamis','2021-05-13','Y'),
(134,'134',2021,'2','Mei','Jumat','2021-05-14','Y'),
(135,'135',2021,'2','Mei','Sabtu','2021-05-15','Y'),
(136,'136',2021,'2','Mei','Minggu','2021-05-16','Y'),
(137,'137',2021,'2','Mei','Senin','2021-05-17','Y'),
(138,'138',2021,'2','Mei','Selasa','2021-05-18','Y'),
(139,'139',2021,'2','Mei','Rabu','2021-05-19','Y'),
(140,'140',2021,'2','Mei','Kamis','2021-05-20','Y'),
(141,'141',2021,'2','Mei','Jumat','2021-05-21','Y'),
(142,'142',2021,'2','Mei','Sabtu','2021-05-22','Y'),
(143,'143',2021,'2','Mei','Minggu','2021-05-23','Y'),
(144,'144',2021,'2','Mei','Senin','2021-05-24','Y'),
(145,'145',2021,'2','Mei','Selasa','2021-05-25','Y'),
(146,'146',2021,'2','Mei','Rabu','2021-05-26','Y'),
(147,'147',2021,'2','Mei','Kamis','2021-05-27','Y'),
(148,'148',2021,'2','Mei','Jumat','2021-05-28','Y'),
(149,'149',2021,'2','Mei','Sabtu','2021-05-29','Y'),
(150,'150',2021,'2','Mei','Minggu','2021-05-30','Y'),
(151,'151',2021,'2','Mei','Senin','2021-05-31','Y'),
(152,'152',2021,'2','Juni','Selasa','2021-06-01','Y'),
(153,'153',2021,'2','Juni','Rabu','2021-06-02','Y'),
(154,'154',2021,'2','Juni','Kamis','2021-06-03','Y'),
(155,'155',2021,'2','Juni','Jumat','2021-06-04','Y'),
(156,'156',2021,'2','Juni','Sabtu','2021-06-05','Y'),
(157,'157',2021,'2','Juni','Minggu','2021-06-06','Y'),
(158,'158',2021,'2','Juni','Senin','2021-06-07','Y'),
(159,'159',2021,'2','Juni','Selasa','2021-06-08','Y'),
(160,'160',2021,'2','Juni','Rabu','2021-06-09','Y'),
(161,'161',2021,'2','Juni','Kamis','2021-06-10','Y'),
(162,'162',2021,'2','Juni','Jumat','2021-06-11','Y'),
(163,'163',2021,'2','Juni','Sabtu','2021-06-12','Y'),
(164,'164',2021,'2','Juni','Minggu','2021-06-13','Y'),
(165,'165',2021,'2','Juni','Senin','2021-06-14','Y'),
(166,'166',2021,'2','Juni','Selasa','2021-06-15','Y'),
(167,'167',2021,'2','Juni','Rabu','2021-06-16','Y'),
(168,'168',2021,'2','Juni','Kamis','2021-06-17','Y'),
(169,'169',2021,'2','Juni','Jumat','2021-06-18','Y'),
(170,'170',2021,'2','Juni','Sabtu','2021-06-19','Y'),
(171,'171',2021,'2','Juni','Minggu','2021-06-20','Y'),
(172,'172',2021,'2','Juni','Senin','2021-06-21','Y'),
(173,'173',2021,'2','Juni','Selasa','2021-06-22','Y'),
(174,'174',2021,'2','Juni','Rabu','2021-06-23','Y'),
(175,'175',2021,'2','Juni','Kamis','2021-06-24','Y'),
(176,'176',2021,'2','Juni','Jumat','2021-06-25','Y'),
(177,'177',2021,'2','Juni','Sabtu','2021-06-26','Y'),
(178,'178',2021,'2','Juni','Minggu','2021-06-27','Y'),
(179,'179',2021,'2','Juni','Senin','2021-06-28','Y'),
(180,'180',2021,'2','Juni','Selasa','2021-06-29','Y'),
(181,'181',2021,'2','Juni','Rabu','2021-06-30','Y'),
(182,'182',2021,'3','Juli','Kamis','2021-07-01','Y'),
(183,'183',2021,'3','Juli','Jumat','2021-07-02','Y'),
(184,'184',2021,'3','Juli','Sabtu','2021-07-03','Y'),
(185,'185',2021,'3','Juli','Minggu','2021-07-04','Y'),
(186,'186',2021,'3','Juli','Senin','2021-07-05','Y'),
(187,'187',2021,'3','Juli','Selasa','2021-07-06','Y'),
(188,'188',2021,'3','Juli','Rabu','2021-07-07','Y'),
(189,'189',2021,'3','Juli','Kamis','2021-07-08','Y'),
(190,'190',2021,'3','Juli','Jumat','2021-07-09','Y'),
(191,'191',2021,'3','Juli','Sabtu','2021-07-10','Y'),
(192,'192',2021,'3','Juli','Minggu','2021-07-11','Y'),
(193,'193',2021,'3','Juli','Senin','2021-07-12','Y'),
(194,'194',2021,'3','Juli','Selasa','2021-07-13','Y'),
(195,'195',2021,'3','Juli','Rabu','2021-07-14','Y'),
(196,'196',2021,'3','Juli','Kamis','2021-07-15','Y'),
(197,'197',2021,'3','Juli','Jumat','2021-07-16','Y'),
(198,'198',2021,'3','Juli','Sabtu','2021-07-17','Y'),
(199,'199',2021,'3','Juli','Minggu','2021-07-18','Y'),
(200,'200',2021,'3','Juli','Senin','2021-07-19','Y'),
(201,'201',2021,'3','Juli','Selasa','2021-07-20','Y'),
(202,'202',2021,'3','Juli','Rabu','2021-07-21','Y'),
(203,'203',2021,'3','Juli','Kamis','2021-07-22','Y'),
(204,'204',2021,'3','Juli','Jumat','2021-07-23','Y'),
(205,'205',2021,'3','Juli','Sabtu','2021-07-24','Y'),
(206,'206',2021,'3','Juli','Minggu','2021-07-25','Y'),
(207,'207',2021,'3','Juli','Senin','2021-07-26','Y'),
(208,'208',2021,'3','Juli','Selasa','2021-07-27','Y'),
(209,'209',2021,'3','Juli','Rabu','2021-07-28','Y'),
(210,'210',2021,'3','Juli','Kamis','2021-07-29','Y'),
(211,'211',2021,'3','Juli','Jumat','2021-07-30','Y'),
(212,'212',2021,'3','Juli','Sabtu','2021-07-31','Y'),
(213,'213',2021,'3','Agustus','Minggu','2021-08-01','Y'),
(214,'214',2021,'3','Agustus','Senin','2021-08-02','Y'),
(215,'215',2021,'3','Agustus','Selasa','2021-08-03','Y'),
(216,'216',2021,'3','Agustus','Rabu','2021-08-04','Y'),
(217,'217',2021,'3','Agustus','Kamis','2021-08-05','Y'),
(218,'218',2021,'3','Agustus','Jumat','2021-08-06','Y'),
(219,'219',2021,'3','Agustus','Sabtu','2021-08-07','Y'),
(220,'220',2021,'3','Agustus','Minggu','2021-08-08','Y'),
(221,'221',2021,'3','Agustus','Senin','2021-08-09','Y'),
(222,'222',2021,'3','Agustus','Selasa','2021-08-10','Y'),
(223,'223',2021,'3','Agustus','Rabu','2021-08-11','Y'),
(224,'224',2021,'3','Agustus','Kamis','2021-08-12','Y'),
(225,'225',2021,'3','Agustus','Jumat','2021-08-13','Y'),
(226,'226',2021,'3','Agustus','Sabtu','2021-08-14','Y'),
(227,'227',2021,'3','Agustus','Minggu','2021-08-15','Y'),
(228,'228',2021,'3','Agustus','Senin','2021-08-16','Y'),
(229,'229',2021,'3','Agustus','Selasa','2021-08-17','Y'),
(230,'230',2021,'3','Agustus','Rabu','2021-08-18','Y'),
(231,'231',2021,'3','Agustus','Kamis','2021-08-19','Y'),
(232,'232',2021,'3','Agustus','Jumat','2021-08-20','Y'),
(233,'233',2021,'3','Agustus','Sabtu','2021-08-21','Y'),
(234,'234',2021,'3','Agustus','Minggu','2021-08-22','Y'),
(235,'235',2021,'3','Agustus','Senin','2021-08-23','Y'),
(236,'236',2021,'3','Agustus','Selasa','2021-08-24','Y'),
(237,'237',2021,'3','Agustus','Rabu','2021-08-25','Y'),
(238,'238',2021,'3','Agustus','Kamis','2021-08-26','Y'),
(239,'239',2021,'3','Agustus','Jumat','2021-08-27','Y'),
(240,'240',2021,'3','Agustus','Sabtu','2021-08-28','Y'),
(241,'241',2021,'3','Agustus','Minggu','2021-08-29','Y'),
(242,'242',2021,'3','Agustus','Senin','2021-08-30','Y'),
(243,'243',2021,'3','Agustus','Selasa','2021-08-31','Y'),
(244,'244',2021,'3','September','Rabu','2021-09-01','Y'),
(245,'245',2021,'3','September','Kamis','2021-09-02','Y'),
(246,'246',2021,'3','September','Jumat','2021-09-03','Y'),
(247,'247',2021,'3','September','Sabtu','2021-09-04','Y'),
(248,'248',2021,'3','September','Minggu','2021-09-05','Y'),
(249,'249',2021,'3','September','Senin','2021-09-06','Y'),
(250,'250',2021,'3','September','Selasa','2021-09-07','Y'),
(251,'251',2021,'3','September','Rabu','2021-09-08','Y'),
(252,'252',2021,'3','September','Kamis','2021-09-09','Y'),
(253,'253',2021,'3','September','Jumat','2021-09-10','Y'),
(254,'254',2021,'3','September','Sabtu','2021-09-11','Y'),
(255,'255',2021,'3','September','Minggu','2021-09-12','Y'),
(256,'256',2021,'3','September','Senin','2021-09-13','Y'),
(257,'257',2021,'3','September','Selasa','2021-09-14','Y'),
(258,'258',2021,'3','September','Rabu','2021-09-15','Y'),
(259,'259',2021,'3','September','Kamis','2021-09-16','Y'),
(260,'260',2021,'3','September','Jumat','2021-09-17','Y'),
(261,'261',2021,'3','September','Sabtu','2021-09-18','Y'),
(262,'262',2021,'3','September','Minggu','2021-09-19','Y'),
(263,'263',2021,'3','September','Senin','2021-09-20','Y'),
(264,'264',2021,'3','September','Selasa','2021-09-21','Y'),
(265,'265',2021,'3','September','Rabu','2021-09-22','Y'),
(266,'266',2021,'3','September','Kamis','2021-09-23','Y'),
(267,'267',2021,'3','September','Jumat','2021-09-24','Y'),
(268,'268',2021,'3','September','Sabtu','2021-09-25','Y'),
(269,'269',2021,'3','September','Minggu','2021-09-26','Y'),
(270,'270',2021,'3','September','Senin','2021-09-27','Y'),
(271,'271',2021,'3','September','Selasa','2021-09-28','Y'),
(272,'272',2021,'3','September','Rabu','2021-09-29','Y'),
(273,'273',2021,'3','September','Kamis','2021-09-30','Y'),
(274,'274',2021,'4','Oktober','Jumat','2021-10-01','Y'),
(275,'275',2021,'4','Oktober','Sabtu','2021-10-02','Y'),
(276,'276',2021,'4','Oktober','Minggu','2021-10-03','Y'),
(277,'277',2021,'4','Oktober','Senin','2021-10-04','Y'),
(278,'278',2021,'4','Oktober','Selasa','2021-10-05','Y'),
(279,'279',2021,'4','Oktober','Rabu','2021-10-06','Y'),
(280,'280',2021,'4','Oktober','Kamis','2021-10-07','Y'),
(281,'281',2021,'4','Oktober','Jumat','2021-10-08','Y'),
(282,'282',2021,'4','Oktober','Sabtu','2021-10-09','Y'),
(283,'283',2021,'4','Oktober','Minggu','2021-10-10','Y'),
(284,'284',2021,'4','Oktober','Senin','2021-10-11','Y'),
(285,'285',2021,'4','Oktober','Selasa','2021-10-12','Y'),
(286,'286',2021,'4','Oktober','Rabu','2021-10-13','Y'),
(287,'287',2021,'4','Oktober','Kamis','2021-10-14','Y'),
(288,'288',2021,'4','Oktober','Jumat','2021-10-15','Y'),
(289,'289',2021,'4','Oktober','Sabtu','2021-10-16','Y'),
(290,'290',2021,'4','Oktober','Minggu','2021-10-17','Y'),
(291,'291',2021,'4','Oktober','Senin','2021-10-18','Y'),
(292,'292',2021,'4','Oktober','Selasa','2021-10-19','Y'),
(293,'293',2021,'4','Oktober','Rabu','2021-10-20','Y'),
(294,'294',2021,'4','Oktober','Kamis','2021-10-21','Y'),
(295,'295',2021,'4','Oktober','Jumat','2021-10-22','Y'),
(296,'296',2021,'4','Oktober','Sabtu','2021-10-23','Y'),
(297,'297',2021,'4','Oktober','Minggu','2021-10-24','Y'),
(298,'298',2021,'4','Oktober','Senin','2021-10-25','Y'),
(299,'299',2021,'4','Oktober','Selasa','2021-10-26','Y'),
(300,'300',2021,'4','Oktober','Rabu','2021-10-27','Y'),
(301,'301',2021,'4','Oktober','Kamis','2021-10-28','Y'),
(302,'302',2021,'4','Oktober','Jumat','2021-10-29','Y'),
(303,'303',2021,'4','Oktober','Sabtu','2021-10-30','Y'),
(304,'304',2021,'4','Oktober','Minggu','2021-10-31','Y'),
(305,'305',2021,'4','November','Senin','2021-11-01','Y'),
(306,'306',2021,'4','November','Selasa','2021-11-02','Y'),
(307,'307',2021,'4','November','Rabu','2021-11-03','Y'),
(308,'308',2021,'4','November','Kamis','2021-11-04','Y'),
(309,'309',2021,'4','November','Jumat','2021-11-05','Y'),
(310,'310',2021,'4','November','Sabtu','2021-11-06','Y'),
(311,'311',2021,'4','November','Minggu','2021-11-07','Y'),
(312,'312',2021,'4','November','Senin','2021-11-08','Y'),
(313,'313',2021,'4','November','Selasa','2021-11-09','Y'),
(314,'314',2021,'4','November','Rabu','2021-11-10','Y'),
(315,'315',2021,'4','November','Kamis','2021-11-11','Y'),
(316,'316',2021,'4','November','Jumat','2021-11-12','Y'),
(317,'317',2021,'4','November','Sabtu','2021-11-13','Y'),
(318,'318',2021,'4','November','Minggu','2021-11-14','Y'),
(319,'319',2021,'4','November','Senin','2021-11-15','Y'),
(320,'320',2021,'4','November','Selasa','2021-11-16','Y'),
(321,'321',2021,'4','November','Rabu','2021-11-17','Y'),
(322,'322',2021,'4','November','Kamis','2021-11-18','Y'),
(323,'323',2021,'4','November','Jumat','2021-11-19','Y'),
(324,'324',2021,'4','November','Sabtu','2021-11-20','Y'),
(325,'325',2021,'4','November','Minggu','2021-11-21','Y'),
(326,'326',2021,'4','November','Senin','2021-11-22','Y'),
(327,'327',2021,'4','November','Selasa','2021-11-23','Y'),
(328,'328',2021,'4','November','Rabu','2021-11-24','Y'),
(329,'329',2021,'4','November','Kamis','2021-11-25','Y'),
(330,'330',2021,'4','November','Jumat','2021-11-26','Y'),
(331,'331',2021,'4','November','Sabtu','2021-11-27','Y'),
(332,'332',2021,'4','November','Minggu','2021-11-28','Y'),
(333,'333',2021,'4','November','Senin','2021-11-29','Y'),
(334,'334',2021,'4','November','Selasa','2021-11-30','Y'),
(335,'335',2021,'4','Desember','Rabu','2021-12-01','Y'),
(336,'336',2021,'4','Desember','Kamis','2021-12-02','Y'),
(337,'337',2021,'4','Desember','Jumat','2021-12-03','Y'),
(338,'338',2021,'4','Desember','Sabtu','2021-12-04','Y'),
(339,'339',2021,'4','Desember','Minggu','2021-12-05','Y'),
(340,'340',2021,'4','Desember','Senin','2021-12-06','Y'),
(341,'341',2021,'4','Desember','Selasa','2021-12-07','Y'),
(342,'342',2021,'4','Desember','Rabu','2021-12-08','Y'),
(343,'343',2021,'4','Desember','Kamis','2021-12-09','Y'),
(344,'344',2021,'4','Desember','Jumat','2021-12-10','Y'),
(345,'345',2021,'4','Desember','Sabtu','2021-12-11','Y'),
(346,'346',2021,'4','Desember','Minggu','2021-12-12','Y'),
(347,'347',2021,'4','Desember','Senin','2021-12-13','Y'),
(348,'348',2021,'4','Desember','Selasa','2021-12-14','Y'),
(349,'349',2021,'4','Desember','Rabu','2021-12-15','Y'),
(350,'350',2021,'4','Desember','Kamis','2021-12-16','Y'),
(351,'351',2021,'4','Desember','Jumat','2021-12-17','Y'),
(352,'352',2021,'4','Desember','Sabtu','2021-12-18','Y'),
(353,'353',2021,'4','Desember','Minggu','2021-12-19','Y'),
(354,'354',2021,'4','Desember','Senin','2021-12-20','Y'),
(355,'355',2021,'4','Desember','Selasa','2021-12-21','Y'),
(356,'356',2021,'4','Desember','Rabu','2021-12-22','Y'),
(357,'357',2021,'4','Desember','Kamis','2021-12-23','Y'),
(358,'358',2021,'4','Desember','Jumat','2021-12-24','Y'),
(359,'359',2021,'4','Desember','Sabtu','2021-12-25','Y'),
(360,'360',2021,'4','Desember','Minggu','2021-12-26','Y'),
(361,'361',2021,'4','Desember','Senin','2021-12-27','Y'),
(362,'362',2021,'4','Desember','Selasa','2021-12-28','Y'),
(363,'363',2021,'4','Desember','Rabu','2021-12-29','Y'),
(364,'364',2021,'4','Desember','Kamis','2021-12-30','Y'),
(365,'365',2021,'4','Desember','Jumat','2021-12-31','Y');

/*Table structure for table `fakta_pemasokan` */

DROP TABLE IF EXISTS `fakta_pemasokan`;

CREATE TABLE `fakta_pemasokan` (
  `row_key_waktu` int(11) NOT NULL,
  `row_key_kota` int(11) NOT NULL,
  `row_key_provinsi` int(11) NOT NULL,
  `row_key_supplier` int(11) NOT NULL,
  `row_key_pegawai` int(11) NOT NULL,
  `row_key_alat` int(11) NOT NULL,
  `total_alat_pemasokan` bigint(20) DEFAULT NULL,
  `total_biaya_pemasokan` bigint(20) DEFAULT NULL,
  UNIQUE KEY `row_key_waktu` (`row_key_waktu`,`row_key_kota`,`row_key_provinsi`,`row_key_supplier`,`row_key_pegawai`,`row_key_alat`),
  KEY `row_key_kota` (`row_key_kota`),
  KEY `row_key_provinsi` (`row_key_provinsi`),
  KEY `row_key_supplier` (`row_key_supplier`),
  KEY `row_key_pegawai` (`row_key_pegawai`),
  KEY `row_key_alat` (`row_key_alat`),
  CONSTRAINT `fakta_pemasokan_ibfk_1` FOREIGN KEY (`row_key_waktu`) REFERENCES `dimensi_waktu` (`row_key_waktu`),
  CONSTRAINT `fakta_pemasokan_ibfk_2` FOREIGN KEY (`row_key_kota`) REFERENCES `dimensi_kota` (`row_key_kota`),
  CONSTRAINT `fakta_pemasokan_ibfk_3` FOREIGN KEY (`row_key_provinsi`) REFERENCES `dimensi_provinsi` (`row_key_provinsi`),
  CONSTRAINT `fakta_pemasokan_ibfk_4` FOREIGN KEY (`row_key_supplier`) REFERENCES `dimensi_supplier` (`row_key_supplier`),
  CONSTRAINT `fakta_pemasokan_ibfk_5` FOREIGN KEY (`row_key_pegawai`) REFERENCES `dimensi_pegawai` (`row_key_pegawai`),
  CONSTRAINT `fakta_pemasokan_ibfk_6` FOREIGN KEY (`row_key_alat`) REFERENCES `dimensi_alat` (`row_key_alat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fakta_pemasokan` */

insert  into `fakta_pemasokan`(`row_key_waktu`,`row_key_kota`,`row_key_provinsi`,`row_key_supplier`,`row_key_pegawai`,`row_key_alat`,`total_alat_pemasokan`,`total_biaya_pemasokan`) values 
(10,1,1,1,6,1,5,37500000),
(10,1,1,1,6,2,5,100000000),
(15,1,1,2,7,1,5,37500000),
(15,1,1,2,7,2,15,300000000),
(20,2,1,3,6,3,5,75000000),
(20,2,1,3,6,4,5,5000000),
(25,2,1,4,7,4,5,5000000),
(25,2,1,4,7,5,15,435000000),
(30,3,1,5,6,5,15,435000000),
(30,3,1,5,6,6,5,110000000),
(36,3,1,6,7,6,10,220000000),
(41,4,1,7,6,7,10,80000000),
(69,5,1,8,7,8,40,280000000),
(79,6,1,9,6,9,10,300000000),
(89,1,1,1,6,10,20,200000000),
(100,1,1,1,6,1,5,37500000),
(100,1,1,1,6,2,5,100000000),
(105,1,1,2,7,1,5,37500000),
(105,1,1,2,7,2,15,300000000),
(110,2,1,3,6,3,5,75000000),
(110,2,1,3,6,4,5,5000000),
(115,2,1,4,7,4,5,5000000),
(115,2,1,4,7,5,15,435000000),
(120,3,1,5,6,5,15,435000000),
(120,3,1,5,6,6,5,110000000),
(125,3,1,6,7,6,10,220000000),
(130,4,1,7,6,7,10,80000000),
(130,5,1,8,7,8,40,280000000),
(140,6,1,9,6,9,10,300000000),
(161,1,1,1,6,10,20,200000000),
(166,1,1,2,7,1,5,37500000),
(166,1,1,2,7,2,5,100000000),
(171,2,1,3,6,1,5,37500000),
(171,2,1,3,6,2,15,300000000),
(176,2,1,4,7,3,5,75000000),
(176,2,1,4,7,4,5,5000000),
(181,3,1,5,6,4,5,5000000),
(181,3,1,5,6,5,15,435000000),
(186,3,1,6,7,5,15,435000000),
(186,3,1,6,7,6,5,110000000),
(191,4,1,7,6,6,10,220000000),
(191,5,1,8,7,7,10,80000000),
(201,6,1,9,6,8,40,280000000),
(222,1,1,1,6,9,10,300000000),
(227,1,1,2,7,10,20,200000000),
(232,2,1,3,6,1,5,37500000),
(232,2,1,3,6,2,5,100000000),
(237,2,1,4,7,1,5,37500000),
(237,2,1,4,7,2,15,300000000),
(242,3,1,5,6,3,5,75000000),
(242,3,1,5,6,4,5,5000000),
(248,3,1,6,7,4,5,5000000),
(248,3,1,6,7,5,15,435000000),
(253,4,1,7,6,5,15,435000000),
(253,4,1,7,6,6,5,110000000),
(253,5,1,8,7,6,10,220000000),
(263,6,1,9,6,7,10,80000000),
(283,1,1,1,6,8,40,280000000),
(288,1,1,2,7,9,10,300000000),
(293,2,1,3,6,10,20,200000000),
(298,2,1,4,7,1,5,37500000),
(298,2,1,4,7,2,5,100000000),
(303,3,1,5,6,1,5,37500000),
(303,3,1,5,6,2,15,300000000),
(309,3,1,6,7,3,5,75000000),
(309,3,1,6,7,4,5,5000000),
(314,4,1,7,6,4,5,5000000),
(314,4,1,7,6,5,15,435000000),
(314,5,1,8,7,5,15,435000000),
(314,5,1,8,7,6,5,110000000),
(324,6,1,9,6,6,10,220000000),
(344,1,1,1,6,7,10,80000000),
(349,1,1,2,7,8,40,280000000),
(354,2,1,3,6,9,10,300000000),
(359,2,1,4,7,10,20,200000000);

/*Table structure for table `fakta_penyewaan` */

DROP TABLE IF EXISTS `fakta_penyewaan`;

CREATE TABLE `fakta_penyewaan` (
  `row_key_waktu` int(11) NOT NULL,
  `row_key_kota` int(11) NOT NULL,
  `row_key_provinsi` int(11) NOT NULL,
  `row_key_pelanggan` int(11) NOT NULL,
  `row_key_pegawai` int(11) NOT NULL,
  `row_key_alat` int(11) NOT NULL,
  `total_alat_penyewaan` bigint(20) DEFAULT NULL,
  `total_biaya_penyewaan` bigint(20) DEFAULT NULL,
  `total_biaya_denda` bigint(20) DEFAULT NULL,
  UNIQUE KEY `row_key_waktu` (`row_key_waktu`,`row_key_kota`,`row_key_provinsi`,`row_key_pelanggan`,`row_key_pegawai`,`row_key_alat`),
  KEY `row_key_kota` (`row_key_kota`),
  KEY `row_key_provinsi` (`row_key_provinsi`),
  KEY `row_key_pelanggan` (`row_key_pelanggan`),
  KEY `row_key_pegawai` (`row_key_pegawai`),
  KEY `row_key_alat` (`row_key_alat`),
  CONSTRAINT `fakta_penyewaan_ibfk_1` FOREIGN KEY (`row_key_waktu`) REFERENCES `dimensi_waktu` (`row_key_waktu`),
  CONSTRAINT `fakta_penyewaan_ibfk_2` FOREIGN KEY (`row_key_kota`) REFERENCES `dimensi_kota` (`row_key_kota`),
  CONSTRAINT `fakta_penyewaan_ibfk_3` FOREIGN KEY (`row_key_provinsi`) REFERENCES `dimensi_provinsi` (`row_key_provinsi`),
  CONSTRAINT `fakta_penyewaan_ibfk_4` FOREIGN KEY (`row_key_pelanggan`) REFERENCES `dimensi_pelanggan` (`row_key_pelanggan`),
  CONSTRAINT `fakta_penyewaan_ibfk_5` FOREIGN KEY (`row_key_pegawai`) REFERENCES `dimensi_pegawai` (`row_key_pegawai`),
  CONSTRAINT `fakta_penyewaan_ibfk_6` FOREIGN KEY (`row_key_alat`) REFERENCES `dimensi_alat` (`row_key_alat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fakta_penyewaan` */

insert  into `fakta_penyewaan`(`row_key_waktu`,`row_key_kota`,`row_key_provinsi`,`row_key_pelanggan`,`row_key_pegawai`,`row_key_alat`,`total_alat_penyewaan`,`total_biaya_penyewaan`,`total_biaya_denda`) values 
(121,1,1,1,2,1,2,600000,1000000),
(121,1,1,1,2,2,2,500000,1000000),
(125,1,1,2,3,2,3,750000,NULL),
(125,1,1,2,3,3,2,400000,NULL),
(128,6,1,3,2,3,3,600000,50000),
(128,6,1,3,2,4,1,50000,50000),
(130,6,1,4,3,4,3,150000,50000),
(130,6,1,4,3,5,3,300000,50000),
(132,2,1,5,2,5,1,100000,1000000),
(138,2,1,6,3,6,5,1250000,NULL),
(138,2,1,6,3,7,5,1750000,NULL),
(145,3,1,7,2,7,8,2800000,NULL),
(152,3,1,8,3,8,5,750000,NULL),
(163,7,1,9,2,9,1,400000,50000),
(163,7,1,10,3,10,2,1000000,50000),
(164,1,1,1,2,1,2,600000,50000),
(164,1,1,2,3,2,1,250000,50000),
(165,2,1,5,2,5,4,400000,50000),
(165,6,1,3,2,3,5,1000000,50000),
(165,6,1,4,3,4,2,100000,50000),
(166,2,1,6,3,6,8,2000000,50000),
(166,3,1,7,2,7,5,1750000,NULL),
(166,3,1,8,3,8,2,300000,NULL),
(166,3,1,8,3,9,2,800000,NULL),
(166,3,1,8,3,10,2,1000000,NULL),
(182,1,1,1,2,1,2,600000,NULL),
(182,1,1,1,2,2,2,500000,NULL),
(186,1,1,2,3,2,3,750000,NULL),
(186,1,1,2,3,3,2,400000,NULL),
(189,6,1,3,2,3,3,600000,NULL),
(189,6,1,3,2,4,1,50000,NULL),
(191,6,1,4,3,4,3,150000,NULL),
(191,6,1,4,3,5,3,300000,NULL),
(193,2,1,5,2,5,1,100000,NULL),
(199,2,1,6,3,6,5,1250000,NULL),
(199,2,1,6,3,7,5,1750000,NULL),
(206,3,1,7,2,7,8,2800000,NULL),
(213,3,1,8,3,8,5,750000,NULL),
(224,7,1,9,2,9,1,400000,NULL),
(224,7,1,10,3,10,2,1000000,NULL),
(225,1,1,1,2,1,2,600000,NULL),
(225,1,1,2,3,2,1,250000,NULL),
(226,2,1,5,2,5,4,400000,NULL),
(226,6,1,3,2,3,5,1000000,NULL),
(226,6,1,4,3,4,2,100000,NULL),
(227,2,1,6,3,6,8,2000000,NULL),
(227,3,1,7,2,7,5,1750000,NULL),
(227,3,1,8,3,8,2,300000,NULL),
(227,3,1,8,3,9,2,800000,NULL),
(227,3,1,8,3,10,2,1000000,NULL),
(256,1,1,1,2,1,2,600000,NULL),
(256,1,1,2,3,2,1,250000,NULL),
(257,2,1,5,2,5,4,400000,NULL),
(257,6,1,3,2,3,5,1000000,NULL),
(257,6,1,4,3,4,2,100000,NULL),
(258,2,1,6,3,6,8,2000000,NULL),
(258,3,1,7,2,7,5,1750000,NULL),
(258,3,1,8,3,8,2,300000,NULL),
(258,3,1,8,3,9,2,800000,NULL),
(258,3,1,8,3,10,2,1000000,NULL);

/* Procedure structure for procedure `procs_dimensi_alat` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_alat` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_alat`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_alat 
			(kode_alat, 
			nama_alat, 
			harga_sewa_alat, 
			nama_merk, 
			nama_jenis_alat, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			a.kode_alat, 
			a.nama_alat, 
			a.harga_sewa_alat, 
			m.nama_merk, 
			ja.nama_jenis_alat,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		RIGHT JOIN db_penyewaan_kamera.tb_alat AS a
			ON IFNULL(adw.kode_alat, '-1') = IFNULL(a.kode_alat, '-1') AND adw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		INNER JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE adw.kode_alat IS NULL
		GROUP BY a.kode_alat
		ORDER BY a.kode_alat ASC;

		DROP TABLE IF EXISTS temp_alat;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_alat
		SELECT adw.row_key_alat, 
			adw.kode_alat
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat AND adw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE IFNULL(adw.nama_alat,'') <> IFNULL(a.nama_alat,'')
			OR IFNULL(adw.harga_sewa_alat,0) <> IFNULL(a.harga_sewa_alat,0)
			OR IFNULL(adw.nama_merk,'') <> IFNULL(m.nama_merk,'')
			OR IFNULL(adw.nama_jenis_alat,'') <> IFNULL(ja.nama_jenis_alat,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_alat AS adw, 
			temp_alat
		SET adw.current_flag = 'N', 
			adw.valid_akhir = CURDATE()
		WHERE adw.row_key_alat = temp_alat.row_key_alat
			AND adw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_alat
			(kode_alat, 
			nama_alat, 
			harga_sewa_alat, 
			nama_merk, 
			nama_jenis_alat, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			a.kode_alat, 
			a.nama_alat, 
			a.harga_sewa_alat, 
			m.nama_merk, 
			ja.nama_jenis_alat,
			adw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat
		JOIN db_penyewaan_kamera.tb_merk AS m
			ON m.kode_merk = a.kode_merk
		JOIN db_penyewaan_kamera.tb_jenis_alat AS ja
			ON ja.kode_jenis_alat = a.kode_jenis_alat
		WHERE a.kode_alat IN (SELECT DISTINCT kode_alat FROM temp_alat)
		GROUP BY a.kode_alat
		ORDER BY a.kode_alat ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_alat;
		
		
		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_alat
		SELECT adw.row_key_alat, 
			adw.kode_alat
		FROM dwh_penyewaan_kamera.dimensi_alat AS adw 
		LEFT JOIN db_penyewaan_kamera.tb_alat AS a
			ON adw.kode_alat = a.kode_alat
		WHERE a.kode_alat IS NULL
			AND adw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_alat AS adw, 
			temp_alat
		SET adw.current_flag = 'N', 
			adw.valid_akhir = CURDATE()
		WHERE adw.row_key_alat = temp_alat.row_key_alat
			AND adw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_alat;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_kota` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_kota` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_kota`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_kota
			(kode_kota, 
			nama_kota, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			k.kode_kota, 
			k.nama_kota, 
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		RIGHT JOIN db_penyewaan_kamera.tb_kota AS k
			ON IFNULL(kdw.kode_kota, '-1') = IFNULL(k.kode_kota, '-1') AND kdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE kdw.kode_kota IS NULL
		GROUP BY k.kode_kota
		ORDER BY k.kode_kota ASC;

		DROP TABLE IF EXISTS temp_kota;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_kota 
		SELECT kdw.row_key_kota, 
			kdw.kode_kota
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota AND kdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(kdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(kdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_kota AS kdw, 
			temp_kota
		SET kdw.current_flag = 'N', 
			kdw.valid_akhir = CURDATE()
		WHERE kdw.row_key_kota = temp_kota.row_key_kota
			AND kdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_kota
			(kode_kota, 
			nama_kota, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			k.kode_kota, 
			k.nama_kota, 
			p.nama_provinsi,
			kdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE k.kode_kota IN (SELECT DISTINCT kode_kota FROM temp_kota)
		GROUP BY k.kode_kota
		ORDER BY k.kode_kota ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_kota;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_kota
		SELECT kdw.row_key_kota, 
			kdw.kode_kota
		FROM dwh_penyewaan_kamera.dimensi_kota AS kdw 
		LEFT JOIN db_penyewaan_kamera.tb_kota AS k
			ON kdw.kode_kota = k.kode_kota
		WHERE k.kode_kota IS NULL
			AND kdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_kota AS kdw, 
			temp_kota
		SET kdw.current_flag = 'N', 
			kdw.valid_akhir = CURDATE()
		WHERE kdw.row_key_kota = temp_kota.row_key_kota
			AND kdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_kota;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_pegawai` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_pegawai` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_pegawai`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_pegawai
			(kode_pegawai, 
			nama_pegawai, 
			no_tlp_pegawai,
			jenis_kelamin,
			alamat_pegawai,
			nama_jabatan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pg.kode_pegawai, 
			pg.nama_pegawai, 
			pg.no_tlp_pegawai, 
			pg.jenis_kelamin, 
			pg.alamat_pegawai,
			j.nama_jabatan,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		RIGHT JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON IFNULL(pgdw.kode_pegawai, '-1') = IFNULL(pg.kode_pegawai, '-1') AND pgdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pgdw.kode_pegawai IS NULL
		GROUP BY pg.kode_pegawai
		ORDER BY pg.kode_pegawai ASC;

		DROP TABLE IF EXISTS temp_pegawai;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pegawai 
		SELECT pgdw.row_key_pegawai, 
			pgdw.kode_pegawai
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai AND pgdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(pgdw.nama_pegawai,'') <> IFNULL(pg.nama_pegawai,'')
			OR IFNULL(pgdw.no_tlp_pegawai,'') <> IFNULL(pg.no_tlp_pegawai,'')
			OR IFNULL(pgdw.jenis_kelamin,'') <> IFNULL(pg.jenis_kelamin,'')
			OR IFNULL(pgdw.alamat_pegawai,'') <> IFNULL(pg.alamat_pegawai,'')
			OR IFNULL(pgdw.nama_jabatan,'') <> IFNULL(j.nama_jabatan,'')
			OR IFNULL(pgdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(pgdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_pegawai AS pgdw, 
			temp_pegawai
		SET pgdw.current_flag = 'N', 
			pgdw.valid_akhir = CURDATE()
		WHERE pgdw.row_key_pegawai = temp_pegawai.row_key_pegawai
			AND pgdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_pegawai
			(kode_pegawai, 
			nama_pegawai, 
			no_tlp_pegawai,
			jenis_kelamin,
			alamat_pegawai,
			nama_jabatan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pg.kode_pegawai, 
			pg.nama_pegawai, 
			pg.no_tlp_pegawai, 
			pg.jenis_kelamin, 
			pg.alamat_pegawai,
			j.nama_jabatan,
			k.nama_kota,
			p.nama_provinsi,
			pgdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai
		JOIN db_penyewaan_kamera.tb_jabatan AS j
			ON j.kode_jabatan = pg.kode_jabatan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pg.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pg.kode_pegawai IN (SELECT DISTINCT kode_pegawai FROM temp_pegawai)
		GROUP BY pg.kode_pegawai
		ORDER BY pg.kode_pegawai ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pegawai;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_pegawai
		SELECT pgdw.row_key_pegawai, 
			pgdw.kode_pegawai
		FROM dwh_penyewaan_kamera.dimensi_pegawai AS pgdw 
		LEFT JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pgdw.kode_pegawai = pg.kode_pegawai
		WHERE pg.kode_pegawai IS NULL
			AND pgdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_pegawai AS pgdw, 
			temp_pegawai
		SET pgdw.current_flag = 'N', 
			pgdw.valid_akhir = CURDATE()
		WHERE pgdw.row_key_pegawai = temp_pegawai.row_key_pegawai
			AND pgdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pegawai;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_pelanggan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_pelanggan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_pelanggan`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_pelanggan
			(kode_pelanggan, 
			nama_pelanggan, 
			no_tlp_pelanggan,
			jenis_kelamin,
			alamat_pelanggan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pl.kode_pelanggan, 
			pl.nama_pelanggan, 
			pl.no_tlp_pelanggan, 
			pl.jenis_kelamin, 
			pl.alamat_pelanggan,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		RIGHT JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON IFNULL(pldw.kode_pelanggan, '-1') = IFNULL(pl.kode_pelanggan, '-1') AND pldw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pldw.kode_pelanggan IS NULL
		GROUP BY pl.kode_pelanggan
		ORDER BY pl.kode_pelanggan ASC;

		DROP TABLE IF EXISTS temp_pelanggan;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_pelanggan 
		SELECT pldw.row_key_pelanggan, 
			pldw.kode_pelanggan
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan AND pldw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(pldw.nama_pelanggan,'') <> IFNULL(pl.nama_pelanggan,'')
			OR IFNULL(pldw.no_tlp_pelanggan,'') <> IFNULL(pl.no_tlp_pelanggan,'')
			OR IFNULL(pldw.jenis_kelamin,'') <> IFNULL(pl.jenis_kelamin,'')
			OR IFNULL(pldw.alamat_pelanggan,'') <> IFNULL(pl.alamat_pelanggan,'')
			OR IFNULL(pldw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(pldw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_pelanggan AS pldw, 
			temp_pelanggan
		SET pldw.current_flag = 'N', 
			pldw.valid_akhir = CURDATE()
		WHERE pldw.row_key_pelanggan = temp_pelanggan.row_key_pelanggan
			AND pldw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_pelanggan
			(kode_pelanggan, 
			nama_pelanggan, 
			no_tlp_pelanggan,
			jenis_kelamin,
			alamat_pelanggan,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			pl.kode_pelanggan, 
			pl.nama_pelanggan, 
			pl.no_tlp_pelanggan, 
			pl.jenis_kelamin, 
			pl.alamat_pelanggan,
			k.nama_kota,
			p.nama_provinsi,
			pldw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE pl.kode_pelanggan IN (SELECT DISTINCT kode_pelanggan FROM temp_pelanggan)
		GROUP BY pl.kode_pelanggan
		ORDER BY pl.kode_pelanggan ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pelanggan;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_pelanggan
		SELECT pldw.row_key_pelanggan, 
			pldw.kode_pelanggan
		FROM dwh_penyewaan_kamera.dimensi_pelanggan AS pldw 
		LEFT JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		WHERE pl.kode_pelanggan IS NULL
			AND pldw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_pelanggan AS pldw, 
			temp_pelanggan
		SET pldw.current_flag = 'N', 
			pldw.valid_akhir = CURDATE()
		WHERE pldw.row_key_pelanggan = temp_pelanggan.row_key_pelanggan
			AND pldw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_pelanggan;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_provinsi` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_provinsi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_provinsi`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_provinsi
			(kode_provinsi, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			p.kode_provinsi, 
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		RIGHT JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON IFNULL(pdw.kode_provinsi, '-1') = IFNULL(p.kode_provinsi, '-1') AND pdw.current_flag = 'Y'
		WHERE pdw.kode_provinsi IS NULL
		GROUP BY p.kode_provinsi
		ORDER BY p.kode_provinsi ASC;

		DROP TABLE IF EXISTS temp_provinsi;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_provinsi 
		SELECT pdw.row_key_provinsi, 
			pdw.kode_provinsi
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi AND pdw.current_flag = 'Y'
		WHERE IFNULL(pdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');

		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_provinsi AS pdw, 
			temp_provinsi
		SET pdw.current_flag = 'N', 
			pdw.valid_akhir = CURDATE()
		WHERE pdw.row_key_provinsi = temp_provinsi.row_key_provinsi
			AND pdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_provinsi
			(kode_provinsi, 
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT 
			p.kode_provinsi, 
			p.nama_provinsi, 
			pdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi
		WHERE p.kode_provinsi IN (SELECT DISTINCT kode_provinsi FROM temp_provinsi)
		GROUP BY p.kode_provinsi
		ORDER BY p.kode_provinsi ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_provinsi;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_provinsi
		SELECT pdw.row_key_provinsi, 
			pdw.kode_provinsi
		FROM dwh_penyewaan_kamera.dimensi_provinsi AS pdw 
		LEFT JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON pdw.kode_provinsi = p.kode_provinsi
		WHERE p.kode_provinsi IS NULL
			AND pdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_provinsi AS pdw, 
			temp_provinsi
		SET pdw.current_flag = 'N', 
			pdw.valid_akhir = CURDATE()
		WHERE pdw.row_key_provinsi = temp_provinsi.row_key_provinsi
			AND pdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_provinsi;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_supplier` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_supplier` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_supplier`()
BEGIN
		-- memasukkan data baru (kode baru) ke dalam tabel dimensional
		INSERT INTO dimensi_supplier
			(kode_supplier, 
			nama_supplier, 
			no_tlp_supplier,
			alamat_supplier,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			sp.kode_supplier, 
			sp.nama_supplier, 
			sp.no_tlp_supplier, 
			sp.alamat_supplier,
			k.nama_kota,
			p.nama_provinsi,
			CURDATE(), 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		RIGHT JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON IFNULL(spdw.kode_supplier, '-1') = IFNULL(sp.kode_supplier, '-1') AND spdw.current_flag = 'Y'
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE spdw.kode_supplier IS NULL
		GROUP BY sp.kode_supplier
		ORDER BY sp.kode_supplier ASC;

		DROP TABLE IF EXISTS temp_supplier;

		-- membuat tabel temp untuk mencatat data yang mengalami perubahan
		CREATE TEMPORARY TABLE temp_supplier 
		SELECT spdw.row_key_supplier, 
			spdw.kode_supplier
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier AND spdw.current_flag = 'Y'
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE IFNULL(spdw.nama_supplier,'') <> IFNULL(sp.nama_supplier,'')
			OR IFNULL(spdw.no_tlp_supplier,'') <> IFNULL(sp.no_tlp_supplier,'')
			OR IFNULL(spdw.alamat_supplier,'') <> IFNULL(sp.alamat_supplier,'')
			OR IFNULL(spdw.nama_kota,'') <> IFNULL(k.nama_kota,'')
			OR IFNULL(spdw.nama_provinsi,'') <> IFNULL(p.nama_provinsi,'');


		-- memperbaharui tabel dimensi yang berubah (di-update pada db)
		UPDATE dimensi_supplier AS spdw, 
			temp_supplier
		SET spdw.current_flag = 'N', 
			spdw.valid_akhir = CURDATE()
		WHERE spdw.row_key_supplier = temp_supplier.row_key_supplier
			AND spdw.current_flag = 'Y';
		 
		 
		-- insert data yang berubah ke dalam tabel_dimensi (buat baris baru)
		INSERT INTO dimensi_supplier
			(kode_supplier, 
			nama_supplier, 
			no_tlp_supplier,
			alamat_supplier,
			nama_kota,
			nama_provinsi, 
			valid_awal, 
			valid_akhir, 
			current_flag)
		SELECT
			sp.kode_supplier, 
			sp.nama_supplier, 
			sp.no_tlp_supplier, 
			sp.alamat_supplier,
			k.nama_kota,
			p.nama_provinsi,
			spdw.valid_akhir, 
			'9999-12-31', 
			'Y'
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier
		JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		WHERE sp.kode_supplier IN (SELECT DISTINCT kode_supplier FROM temp_supplier)
		GROUP BY sp.kode_supplier
		ORDER BY sp.kode_supplier ASC;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_supplier;

		-- membuat tabel temp untuk mencatat data yang dihapus pada db
		CREATE TEMPORARY TABLE temp_supplier
		SELECT spdw.row_key_supplier, 
			spdw.kode_supplier
		FROM dwh_penyewaan_kamera.dimensi_supplier AS spdw 
		LEFT JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON spdw.kode_supplier = sp.kode_supplier
		WHERE sp.kode_supplier IS NULL
			AND spdw.current_flag = 'Y';


		-- memperbaharui tabel dimensi yang berubah (dihapus pada db)
		UPDATE dimensi_supplier AS spdw, 
			temp_supplier
		SET spdw.current_flag = 'N', 
			spdw.valid_akhir = CURDATE()
		WHERE spdw.row_key_supplier = temp_supplier.row_key_supplier
			AND spdw.current_flag = 'Y';
			
		
		-- drop tabel temp
		DROP TABLE IF EXISTS temp_supplier;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_dimensi_waktu_pertgl` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_dimensi_waktu_pertgl` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_dimensi_waktu_pertgl`(IN tgl_awal DATE, IN tgl_akhir DATE)
BEGIN
		SET @counterLoop := 1;
		SET @endCounterLoop := DATEDIFF(tgl_akhir, tgl_awal)+1;
		SET @tglawal = tgl_awal;
		SET @tahunAwal = YEAR(tgl_awal);
		SET @tahunAkhir = YEAR(tgl_akhir);

		DROP TABLE IF EXISTS temp_waktu;

		-- membuat tabel temp untuk memproduksi data waktu
		CREATE TEMPORARY TABLE temp_waktu(kode_waktu INT, tanggal DATE);

		-- loop untuk memproduksi data waktu sebanyak parameter tanggal
		read_loop: LOOP
			IF @counterLoop > @endCounterLoop THEN
				LEAVE read_loop;
			ELSE
				INSERT INTO temp_waktu(kode_waktu, tanggal) 
				VALUES (@counterLoop, 
					@tglawal + INTERVAL (@counterLoop-1) DAY);
				SET  @counterLoop := @counterLoop + 1;
			END IF;
		END LOOP;
		
		
		-- memperbaharui data waktu yang lama jika menginputkan tanggal yang baru
		UPDATE dimensi_waktu AS wtdw, 
			temp_waktu
		SET wtdw.current_flag = 'N'
		WHERE wtdw.current_flag = 'Y' 
			AND temp_waktu.tanggal <> wtdw.tanggal;


		-- memperbaharui data waktu yang lama jika menginputkan tanggal yang lama
		UPDATE dimensi_waktu AS wtdw, 
			temp_waktu
		SET wtdw.current_flag = 'Y'
		WHERE wtdw.current_flag = 'N' 
			AND temp_waktu.tanggal = wtdw.tanggal;


		-- memasukkan data waktu baru ke dalam tabel dimensional
		INSERT INTO dimensi_waktu
			(kode_waktu,
			tahun,
			kuartal,
			bulan,
			hari,
			tanggal,
			current_flag)
		SELECT temp_waktu.kode_waktu,
			DATE_FORMAT(tanggal, "%Y"),
			QUARTER(tanggal),
			CASE MONTH(tanggal)
				WHEN 1 THEN 'Januari'
				WHEN 2 THEN 'Februari'
				WHEN 3 THEN 'Maret'
				WHEN 4 THEN 'April'
				WHEN 5 THEN 'Mei'
				WHEN 6 THEN 'Juni'
				WHEN 7 THEN 'Juli'      
				WHEN 8 THEN 'Agustus'  
				WHEN 9 THEN 'September'        
				WHEN 10 THEN 'Oktober'  
				WHEN 11 THEN 'November'        
				WHEN 12 THEN 'Desember'        
			END,
			CASE DAYOFWEEK(tanggal)
				WHEN 1 THEN 'Minggu'
				WHEN 2 THEN 'Senin'
				WHEN 3 THEN 'Selasa'
				WHEN 4 THEN 'Rabu'
				WHEN 5 THEN 'Kamis'
				WHEN 6 THEN 'Jumat'
				WHEN 7 THEN 'Sabtu'
			END,
			temp_waktu.tanggal,
			'Y'
		FROM temp_waktu
		ON DUPLICATE KEY 
			UPDATE dimensi_waktu.kode_waktu = dimensi_waktu.kode_waktu;


		-- drop tabel temp
		DROP TABLE IF EXISTS temp_waktu;	
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_fakta_pemasokan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_fakta_pemasokan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_fakta_pemasokan`()
BEGIN
		INSERT INTO fakta_pemasokan
			(row_key_waktu,
			row_key_kota,
			row_key_provinsi,
			row_key_supplier,
			row_key_pegawai,
			row_key_alat,
			total_alat_pemasokan,
			total_biaya_pemasokan)
		SELECT wtdw.row_key_waktu, 
			kdw.row_key_kota, 
			pdw.row_key_provinsi, 
			spdw.row_key_supplier, 
			pgdw.row_key_pegawai, 
			adw.row_key_alat, 
			SUM(pasd.jumlah_pasok),
			SUM(pasd.harga_beli * pasd.jumlah_pasok)
		FROM db_penyewaan_kamera.tb_pemasokan AS pas
		INNER JOIN db_penyewaan_kamera.tb_detail_pemasokan AS pasd
			ON pasd.kode_pasok = pas.kode_pasok
		INNER JOIN db_penyewaan_kamera.tb_alat AS a
			ON a.kode_alat = pasd.kode_alat
		INNER JOIN db_penyewaan_kamera.tb_supplier AS sp
			ON sp.kode_supplier = pas.kode_supplier
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = sp.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		INNER JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pg.kode_pegawai = pas.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_waktu AS wtdw
			ON wtdw.tanggal = pas.tgl_pasok
		INNER JOIN dwh_penyewaan_kamera.dimensi_kota AS kdw
			ON kdw.kode_kota = k.kode_kota
		INNER JOIN dwh_penyewaan_kamera.dimensi_provinsi AS pdw
			ON pdw.kode_provinsi = p.kode_provinsi
		INNER JOIN dwh_penyewaan_kamera.dimensi_supplier AS spdw
			ON spdw.kode_supplier = sp.kode_supplier
		INNER JOIN dwh_penyewaan_kamera.dimensi_pegawai AS pgdw
			ON pgdw.kode_pegawai = pg.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_alat AS adw
			ON adw.kode_alat = a.kode_alat
		WHERE wtdw.current_flag = 'Y'
			AND kdw.current_flag = 'Y'
			AND pdw.current_flag = 'Y'
			AND spdw.current_flag = 'Y'
			AND pgdw.current_flag = 'Y'
			AND adw.current_flag = 'Y'
		GROUP BY pas.tgl_pasok, 
			k.kode_kota,
			p.kode_provinsi,
			pas.kode_supplier,
			pas.kode_pegawai,
			pasd.kode_alat
		ORDER BY pas.tgl_pasok, 
			k.kode_kota,
			p.kode_provinsi,
			pas.kode_supplier,
			pas.kode_pegawai,
			pasd.kode_alat
		ON DUPLICATE KEY 
			UPDATE fakta_pemasokan.row_key_waktu = fakta_pemasokan.row_key_waktu;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `procs_fakta_penyewaan` */

/*!50003 DROP PROCEDURE IF EXISTS  `procs_fakta_penyewaan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procs_fakta_penyewaan`()
BEGIN
		INSERT INTO fakta_penyewaan
			(row_key_waktu,
			row_key_kota,
			row_key_provinsi,
			row_key_pelanggan,
			row_key_pegawai,
			row_key_alat,
			total_alat_penyewaan,
			total_biaya_penyewaan,
			total_biaya_denda)
		SELECT wtdw.row_key_waktu, 
			kdw.row_key_kota, 
			pdw.row_key_provinsi, 
			pldw.row_key_pelanggan, 
			pgdw.row_key_pegawai, 
			adw.row_key_alat, 
			SUM(sewd.jumlah_sewa),
			SUM(sewd.harga_sewa * sewd.jumlah_sewa),
			SUM(d.biaya_denda)
		FROM db_penyewaan_kamera.tb_penyewaan AS sew
		INNER JOIN db_penyewaan_kamera.tb_detail_penyewaan AS sewd
			ON sewd.kode_sewa = sew.kode_sewa
		INNER JOIN db_penyewaan_kamera.tb_alat AS a
			ON a.kode_alat = sewd.kode_alat
		LEFT JOIN db_penyewaan_kamera.tb_denda AS d
			ON d.kode_sewa = sew.kode_sewa
		INNER JOIN db_penyewaan_kamera.tb_pelanggan AS pl
			ON pl.kode_pelanggan = sew.kode_pelanggan
		INNER JOIN db_penyewaan_kamera.tb_kota AS k
			ON k.kode_kota = pl.kode_kota
		INNER JOIN db_penyewaan_kamera.tb_provinsi AS p
			ON p.kode_provinsi = k.kode_provinsi
		INNER JOIN db_penyewaan_kamera.tb_pegawai AS pg
			ON pg.kode_pegawai = sew.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_waktu AS wtdw
			ON wtdw.tanggal = sew.tgl_sewa
		INNER JOIN dwh_penyewaan_kamera.dimensi_kota AS kdw
			ON kdw.kode_kota = k.kode_kota
		INNER JOIN dwh_penyewaan_kamera.dimensi_provinsi AS pdw
			ON pdw.kode_provinsi = p.kode_provinsi
		INNER JOIN dwh_penyewaan_kamera.dimensi_pelanggan AS pldw
			ON pldw.kode_pelanggan = pl.kode_pelanggan
		INNER JOIN dwh_penyewaan_kamera.dimensi_pegawai AS pgdw
			ON pgdw.kode_pegawai = pg.kode_pegawai
		INNER JOIN dwh_penyewaan_kamera.dimensi_alat AS adw
			ON adw.kode_alat = a.kode_alat
		WHERE wtdw.current_flag = 'Y'
			AND kdw.current_flag = 'Y'
			AND pdw.current_flag = 'Y'
			AND pldw.current_flag = 'Y'
			AND pgdw.current_flag = 'Y'
			AND adw.current_flag = 'Y'
		GROUP BY sew.tgl_sewa, 
			k.kode_kota,
			p.kode_provinsi,
			sew.kode_pelanggan,
			sew.kode_pegawai,
			sewd.kode_alat
		ORDER BY sew.tgl_sewa, 
			k.kode_kota,
			p.kode_provinsi,
			sew.kode_pelanggan,
			sew.kode_pegawai,
			sewd.kode_alat
		ON DUPLICATE KEY 
			UPDATE fakta_penyewaan.row_key_waktu = fakta_penyewaan.row_key_waktu;
	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
