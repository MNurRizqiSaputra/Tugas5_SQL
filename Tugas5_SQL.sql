Buat fungsi inputPelanggan(), setelah itu panggil fungsinya

DELIMITER $$
CREATE PROCEDURE inputPelanggan(
 kode varchar(10),nama varchar(45), jk char(1), tmp_lahir VARCHAR(30), tgl_lahir date, email varchar(45),kartu_id int(11)
)
 BEGIN
INSERT INTO pelanggan (
kode,nama,jk,tmp_lahir,tgl_lahir,email,kartu_id) VALUES (kode,nama,jk,tmp_lahir,tgl_lahir,email,kartu_id
);
 END $$
DELIMITER ;
CALL inputPelanggan(
 'C011','Rizqi Saputra','L','Jakarta','2001-04-15','putra@gmail.com',1
);

==================================================
Buat fungsi showPelanggan(), setelah itu panggil fungsinya

DELIMITER $$
CREATE PROCEDURE showPelanggan()
 BEGIN
SELECT * FROM pelanggan;
 END $$
DELIMITER ;
CALL showPelanggan();

==================================================
Buat fungsi inputProduk(), setelah itu panggil fungsinya

DELIMITER $$
CREATE PROCEDURE inputProduk(
kode varchar(10),nama varchar(45), harga_beli double, harga_jual double, stok int(11), min_stok int(11), jenis_produk_id int(11)
)
BEGIN
INSERT INTO produk (
kode, nama,harga_beli,harga_jual,stok,min_stok,jenis_produk_id)VALUES(kode,nama,harga_beli,harga_jual,stok,min_stok,jenis_produk_id
);
END $$
DELIMITER ;
CALL inputProduk(
'SB01','Sofa Bed',3000000,4000000,5,3,2
);

==================================================
Buat fungsi showProduk(), setelah itu panggil fungsinya

DELIMITER $$
CREATE  PROCEDURE showProduk()
 BEGIN
SELECT * FROM produk;
 END $$
DELIMITER ;
CALL showProduk();

==================================================
Buat fungsi totalPesanan(), setelah itu panggil fungsinya

DELIMITER $$
CREATE  PROCEDURE totalPesanan()
BEGIN
SELECT pelanggan.id, pelanggan.kode,pelanggan.nama_pelanggan,SUM(pesanan_items.qty) as total_item,pesanan.total FROM pelanggan
RIGHT JOIN pesanan ON pesanan.pelanggan_id = pelanggan.id
LEFT JOIN pesanan_items ON pesanan_items.pesanan_id = pesanan.id
GROUP BY pesanan.id;
END $$
DELIMITER ;
CALL totalPesanan();

==================================================
Tampilkan seluruh pesanan dari semua pelanggan

DELIMITER $$
CREATE PROCEDURE showSemuaPesanan()
BEGIN
SELECT pesanan.id, pesanan.tanggal, pesanan.total, pelanggan.nama FROM pesanan
JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id;
END $$
DELIMITER ;
CALL showSemuaPesanan();

==================================================
Buatkan query panjang di atas menjadi sebuah view baru: pesanan_produk_vw (menggunakan join dari table pesanan,pelanggan dan produk)

CREATE VIEW pesanan_produk_vw AS
SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS pelanggan_kode, pelanggan.nama, produk.kode AS produk_kode, produk.nama AS nama_produk, pesanan_items.qty, produk.harga_jual, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
FROM pesanan
 JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
JOIN produk ON pesanan_items.produk_id = produk.id
GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;
SELECT * FROM pesanan_produk_vw;




