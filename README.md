# Dashboard Sales

## Introduction
In this project, I make a dashboard sales of some product from Kimia Farma in transaction range of January - June 2022. The tools that I used to query in SQL is PostgreSQL, and for visualizing the data I used Google Looker Studio.

## Datamart
Datamart contains base table and aggregate tables that I got the data from 6 raw data tables or it's called Data Warehouse, which are `penjualan` table, `pelanggan` table, `barang` table, `penjualan_ds` table, `pelanggan_ds` table, and `barang_ds` table.

### Base Table
- Before I join all of the tables into a base table, firstly I join `penjualan` and `penjualan_ds` table using Union to get all of the data combined. Then I join `pelanggan` and `pelanggan_ds` table using Join, also in `barang` and `barang_ds` table using Join.
- Now I got 3 tables, for base table I will take some columns from each tables that has relation each others.
- For the columns from `penjualan` table I take:
  1. 'id_invoice' -> id transaction
  2. 'tanggal' -> transaction date
  3. 'id_customer' -> customer id
  4. 'jumlah_barang' -> amount of items purchased by customers
  5. 'harga' -> price of each items
- For the columns from `pelanggan` table I take:
  1. 'nama' -> the name of the customers
  2. 'cabang_sales' -> the branch of the customer present in region/city
- For the columns from `barang` table I take:
  1. 'nama_barang' -> the name of the items/products

### Aggregate Table
- There are 4 types of aggregation I made, aggregate by months, aggregate by items/products, aggregate by customers, and aggregate by regions.
- I still included 'month' column for each aggregation table, because I want to present it by month in the final dashboard.
- The 4 aggregate tables are:
  1. Combined table that contains total revenue each months, total product sold each months, top product by revenue each months and top customer order each months.
  2. Total revenue and product sold each items/products name.
  3. Total transaction and product purchased each customers.
  4. Total revenue and product sold each regions.

Here is a screenschot of my dashboard using Google Looker Studio
![alt_text](dashboard_ss.png)

For the final dashboard you can see it [here](https://lookerstudio.google.com/reporting/f962dff8-920a-4c45-a3c8-d32dabb302fc)
