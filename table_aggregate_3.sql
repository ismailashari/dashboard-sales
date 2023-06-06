-- membuat tabel yang menampilkan transaksi setiap customer

create table pembelian_customer as(
select
	date_part('month', tanggal) as bulan,
	nama,
	count(nama) as berapa_kali,
	sum(jumlah_barang) as jumlah_barang
from monthly
group by 1,2
order by 1
)
