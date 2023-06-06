-- membuat tabel yang menampilkan penjualan masing-masing produk (total penjualan dan revenue)

create table penjualan_produk as(
select
	date_part('month', tanggal) as bulan,
	nama_barang,
	sum(jumlah_barang) as jumlah,
	sum(harga*jumlah_barang) as revenue
from monthly
group by 1,2
order by 1
)