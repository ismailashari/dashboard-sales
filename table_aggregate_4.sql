-- membuat tabel yang menampilkan jumlah revenue dan product sold dari masing-masing region

create table regional as(
select
	date_part('month', tanggal)as bulan,
	cabang_sales as region,
	sum(jumlah_barang) as jumlah_barang_reg,
	sum(harga*jumlah_barang) as revenue_reg
from monthly as m
group by 1,2
order by 1
)
