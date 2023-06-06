-- membuat tabel yang berisi informasi pendapatan total masing-masing bulan

with
total_revenue_per_month as (
select 
	date_part('month', tanggal) as bulan,
	sum(harga*jumlah_barang) as total_revenue,
	sum(jumlah_barang) as total_product
from monthly
group by 1
order by 1
),

-- membuat tabel yang berisi nama barang yang memberikan pendapatan total tertinggi untuk masing-masing bulan

top_product_by_revenue_per_month as (
select
	bulan,
	barang_terbanyak,
	revenue
from (
select
	date_part('month', tanggal) as bulan,
	nama_barang as barang_terbanyak,
	sum(harga*jumlah_barang) as revenue,
	row_number() over (partition by
				 	date_part('month', tanggal)
				 order by
				 	sum(harga) desc) as rk
	from monthly
	group by 1,2
) as sq
where rk = 1
),

-- membuat tabel yang menampilkan customer yang paling banyak melakukan pembelian berdasarkan nama customer

top_customer_order as (
select
	bulan,
	cust_terbanyak,
	jumlah_order
from (
	select 
		date_part('month', tanggal) as bulan,
		nama as cust_terbanyak,
		count(2) as jumlah_order,
		row_number() over (partition by
						date_part('month', tanggal)
					 order by
						count(nama) desc) as rk
	from monthly
	group by 1,2
) c
where rk = 1
),


-- menggabungkan keseluruhan tabel diatas menjadi satu tabel
create table penjualan_bulanan as(
select
	a.bulan,
	a.total_revenue as month_total_revenue,
	a.total_product as month_total_product_sold,
	b.barang_terbanyak as top_product_by_revenue,
	b.revenue as product_revenue,
	c.cust_terbanyak as top_customer,
	c.jumlah_order as customer_repeat_order
from total_revenue_per_month as a
join top_product_by_revenue_per_month as b
	on a.bulan = b.bulan
join top_customer_order as c
	on a.bulan = c.bulan
)