DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE dwh_penyewaan_kamera.procs_dimensi_waktu_pertgl(IN tgl_awal DATE, IN tgl_akhir DATE)
    /*LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
    | SQL SECURITY { DEFINER | INVOKER }
    | COMMENT 'string'*/
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
	END$$

DELIMITER ;