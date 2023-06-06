-- mengubah nilai harga pada tabel penjualan
update penjualan
set harga =
 	case
 		when id_barang = 'BRG0001' then 96000
 		when id_barang = 'BRG0002' then 112000
 		when id_barang = 'BRG0003' then 17000
 		when id_barang = 'BRG0004' then 24500
 		when id_barang = 'BRG0005' then 47000
 		when id_barang = 'BRG0006' then 39000
 		when id_barang = 'BRG0007' then 64700
 		when id_barang = 'BRG0008' then 9800
 		when id_barang = 'BRG0009' then 31000
 		when id_barang = 'BRG0010' then 21000
 		else 0
 	end;

-- membuat tabel baru dari gabungan penjualan dan penjualan_ds
create table penjualan_new as
select 
 	id_distributor,
 	id_cabang,
 	id_invoice,
 	tanggal,
 	id_customer,
 	id_barang,
 	jumlah_barang,
 	unit,
 	harga,
 	mata_uang,
 	brand_id,
 	lini
from penjualan

union 
select
	null,
 	null,
 	id_invoice,
 	tanggal,
 	id_customer,
 	id_barang,
 	jumlah_barang,
 	unit,
 	harga,
 	mata_uang,
 	null,
 	null
 from penjualan_ds;
 
--  membuat table baru dari gabungan pelanggan dan pelanggan_ds
create table pelanggan_new as (
select 
	po.id_customer,
	po.level,
	po.nama,
	po.id_cabang_sales,
	po.cabang_sales,
	po.id_group,
	po."group"
from pelanggan as po
join pelanggan_ds as pd
	on po.id_customer = pd.id_customer
);

-- membuat tabel baru dari gabungan barang dan barang_ds
create table barang_new as (
select 
	b.kode_barang,
	b.sektor,
	b.nama_barang,
	b.tipe,
	b.nama_tipe,
	b.kode_lini,
	b.lini,
	b.kemasan,
	bd.harga,
	bd.kode_brand,
	bd.brand
from barang as b
join barang_ds as bd
	on b.kode_barang = bd.kode_barang
);

-- membuat tabel base (monthly) dari gabungan 3 tabel diatas
create table monthly as(
select
	j.id_invoice,
	j.tanggal,
	j.id_customer,
	p.nama,
	j.jumlah_barang,
	b.nama_barang,
	j.harga,
	p.cabang_sales
from
	penjualan_new as j
join pelanggan_new as p
	on j.id_customer = p.id_customer
join barang_new as b
	on j.id_barang = b.kode_barang
)