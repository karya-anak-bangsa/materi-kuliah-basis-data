# -------------------------------------------------------------
# query trigger (rekening & transaksi)
# -------------------------------------------------------------
delimiter //

-- hapus trigger lama jika ada agar tidak bentrok
drop trigger if exists trigger_rekening //
drop trigger if exists trigger_transaksi //

-- trigger untuk pembukaan rekening awal
create trigger trigger_rekening
after insert on tb_rekening
for each row
begin
    call procedure_rekening(new.nomor_rekening, new.setoran_awal, new.tanggal_buka);
end //

-- trigger untuk transaksi harian (setor/tarik)
create trigger trigger_transaksi
after insert on tb_transaksi
for each row
begin
    call procedure_transaksi(new.nomor_rekening, new.jenis_transaksi, new.nominal, new.tanggal_transaksi);
end //

delimiter ;