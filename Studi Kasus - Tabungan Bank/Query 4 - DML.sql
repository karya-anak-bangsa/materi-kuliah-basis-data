# -------------------------------------------------------------
# query dml
# -------------------------------------------------------------

use db_basis_data_tabungan;

truncate table tb_nasabah;
truncate table tb_rekening;
truncate table tb_buku_tabungan;
truncate table tb_transaksi;

select * from tb_nasabah;
select * from tb_rekening;
select * from tb_buku_tabungan;
select * from tb_transaksi;

-- cek hasil akhir
select * from tb_rekening where nomor_rekening = 'rk-004';
select * from tb_buku_tabungan where nomor_rekening = 'rk-004' order by tanggal desc;

insert into tb_nasabah (id_nasabah, nama_nasabah, gender, tempat_lahir, tanggal_lahir, pendidikan, pekerjaan, penghasilan, status_nasabah)
	values
	('ns-001','ahmad bilal maulana', 'laki-laki', 'jakarta', '1995-01-01', 's1', 'pelajar / mahasiswa', '500000', 'aktif'),
	('ns-002','farhan ilman eve', 'laki-laki', 'bandung', '1995-12-30', 's1', 'pelajar / mahasiswa', '500000', 'aktif'),
	('ns-003','iim karimah', 'perempuan', 'bandung', '1997-06-26', 's2', 'pegawai swasta', '5600000', 'aktif'),
	('ns-004','nur habibah', 'perempuan', 'surabaya', '1991-01-01', 's1', 'ibu rumah tangga', '0', 'aktif'),
	('ns-005','muhammad iqbal', 'laki-laki', 'jakarta', '1995-12-12', 's1', 'ibu rumah tangga', '0', 'aktif');

insert into tb_rekening (nomor_rekening, id_nasabah, tanggal_buka, tanggal_tutup, setoran_awal, saldo, status_rekening)
	values
	('rk-001','ns-001','2024-01-01',null,'100000','100000','aktif'),
	('rk-002','ns-002','2025-01-01',null,'100000','100000','aktif'),
	('rk-003','ns-003','2025-01-01',null,'150000','150000','aktif'),
	('rk-004','ns-003','2025-02-02',null,'500000','500000','aktif');

insert into tb_transaksi (id_transaksi, nomor_rekening, tanggal_transaksi, jenis_transaksi, nominal, status_transaksi)
	values ('tr-001', 'rk-004', now(), 'setor', 200000, 'berhasil');

insert into tb_transaksi (id_transaksi, nomor_rekening, tanggal_transaksi, jenis_transaksi, nominal, status_transaksi)
	values ('tr-002', 'rk-004', now(), 'setor', 100000, 'berhasil');

insert into tb_transaksi (id_transaksi, nomor_rekening, tanggal_transaksi, jenis_transaksi, nominal, status_transaksi)
	values ('tr-003', 'rk-004', now(), 'tarik', 50000, 'berhasil');


# -------------------------------------------------------------
# query join
# -------------------------------------------------------------
select 
    n.nama_nasabah, 
    r.nomor_rekening, 
    t.tanggal_transaksi, 
    t.jenis_transaksi, 
    t.nominal, 
    r.saldo as saldo_akhir_rekening
from tb_nasabah n
join tb_rekening r on n.id_nasabah = r.id_nasabah
join tb_transaksi t on r.nomor_rekening = t.nomor_rekening;


create view v_laporan_mutasi as
select 
    t.tanggal_transaksi,
    n.nama_nasabah,
    t.nomor_rekening,
    t.jenis_transaksi,
    t.nominal,
    t.status_transaksi
from tb_transaksi t
join tb_rekening r on t.nomor_rekening = r.nomor_rekening
join tb_nasabah n on r.id_nasabah = n.id_nasabah;



create view v_ringkasan_saldo as
select 
    n.id_nasabah,
    n.nama_nasabah,
    r.nomor_rekening,
    r.saldo,
    r.status_rekening
from tb_nasabah n
join tb_rekening r on n.id_nasabah = r.id_nasabah;


-- melihat semua mutasi nasabah
select * from v_laporan_mutasi;

-- melihat saldo semua nasabah
select * from v_ringkasan_saldo;

-- mencari saldo nasabah tertentu (misal: ahmad bilal maulana)
select * from v_ringkasan_saldo where nama_nasabah like '%ahmad%';