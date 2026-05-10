# -------------------------------------------------------------
# query procedure (rekening & transaksi)
# -------------------------------------------------------------

delimiter //

-- hapus procedure lama jika ada agar tidak bentrok
drop procedure if exists procedure_rekening //
drop procedure if exists procedure_transaksi //

-- procedure 1: untuk menangani pembukaan rekening awal
create procedure procedure_rekening(
	in p_nomor_rekening varchar(255),
	in p_setoran decimal(15,2),
	in p_tanggal datetime
)
begin
	insert into tb_buku_tabungan (nomor_rekening, debit, kredit, saldo, tanggal) 
		values (p_nomor_rekening, 0, p_setoran, p_setoran, p_tanggal);
end //

-- procedure 2: untuk menangani transaksi setor dan tarik
create procedure procedure_transaksi(
    in p_nomor_rekening varchar(255),
    in p_jenis_transaksi enum('setor', 'tarik'),
    in p_nominal decimal(15,2),
    in p_tanggal datetime
)
begin
    declare v_saldo_lama decimal(15,2);
    declare v_saldo_baru decimal(15,2);

    -- mengambil saldo terakhir dari rekening terkait
    select saldo into v_saldo_lama 
    from tb_rekening 
    where nomor_rekening = p_nomor_rekening;

    -- logika perhitungan saldo dan pengisian buku tabungan
    if p_jenis_transaksi = 'setor' then
        set v_saldo_baru = v_saldo_lama + p_nominal;
        
        update tb_rekening set saldo = v_saldo_baru where nomor_rekening = p_nomor_rekening;
        
        insert into tb_buku_tabungan (nomor_rekening, debit, kredit, saldo, tanggal)
        values (p_nomor_rekening, 0, p_nominal, v_saldo_baru, p_tanggal);
        
    elseif p_jenis_transaksi = 'tarik' then
        set v_saldo_baru = v_saldo_lama - p_nominal;
        
        update tb_rekening set saldo = v_saldo_baru where nomor_rekening = p_nomor_rekening;
        
        insert into tb_buku_tabungan (nomor_rekening, debit, kredit, saldo, tanggal)
        values (p_nomor_rekening, p_nominal, 0, v_saldo_baru, p_tanggal);
    end if;
end //

delimiter ;