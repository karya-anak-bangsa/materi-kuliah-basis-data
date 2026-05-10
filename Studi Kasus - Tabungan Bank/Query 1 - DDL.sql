-- query untuk membuat database bernama db_basis_data_tabungan
-- drop database db_basis_data_tabungan;
create database db_basis_data_tabungan;

-- menggunakan database db_basis_data_tabungan
use db_basis_data_tabungan;

# -------------------------------------------------------------
# query ddl
# -------------------------------------------------------------
-- drop table tb_nasabah;
-- drop table tb_rekening;
-- drop table tb_buku_tabungan;
-- drop table tb_transaksi;

-- query untuk membuat table nasabah
create table tb_nasabah(
	id_nasabah varchar(255) not null,
	nama_nasabah varchar(255) not null,
	gender enum('laki-laki', 'perempuan') not null,
	tempat_lahir varchar(255) not null,
	tanggal_lahir date not null,
	pendidikan varchar(255) not null,
	pekerjaan varchar(255) not null,
	penghasilan decimal(15,2) not null,
	status_nasabah varchar(255) not null,
	primary key (id_nasabah)
);

-- query untuk membuat table rekening
create table tb_rekening(
	nomor_rekening varchar(255) not null,
	id_nasabah varchar(255) not null,
	tanggal_buka datetime not null,
	tanggal_tutup datetime null,
	setoran_awal decimal(15,2) not null,
	saldo decimal(15,2) not null,
	status_rekening varchar(255) not null,
	primary key (nomor_rekening)
);

-- query untuk membuat table buku tabungan
create table tb_buku_tabungan(
	id_buku_tabungan int not null auto_increment,
	nomor_rekening varchar(255) not null,
	debit decimal(15,2) not null,
	kredit decimal(15,2) not null,
	saldo decimal(15,2) not null,
	tanggal datetime not null,
	primary key (id_buku_tabungan)
);

-- query untuk membuat table transaksi
create table tb_transaksi(
	id_transaksi varchar(255) not null,
	nomor_rekening varchar(255) not null,
	tanggal_transaksi datetime not null,
	jenis_transaksi enum('setor', 'tarik') not null,
	nominal decimal(15,2) not null,
	status_transaksi varchar(255) not null,
	primary key (id_transaksi)
);

