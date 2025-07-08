-- Tes SQL: Studi Kasus Toko Buku
-- Tujuan: Menguji pemahaman Anda tentang DDL dan DML dalam SQL.
-- Instruksi:
-- Jalankan skrip ini secara berurutan di lingkungan MySQL VS Code Anda.
-- Untuk setiap "Soal", tuliskan perintah SQL yang diminta.
-- Setelah menulis perintah, jalankan perintah Anda dan kemudian baca "Output yang diharapkan" untuk memverifikasi.

-- ====================================================================
-- BAGIAN 0: SETUP DATABASE DAN DATA AWAL (JALANKAN INI DAHULU)
-- ====================================================================

-- Hapus database jika sudah ada untuk memulai dari awal
DROP DATABASE IF EXISTS toko_buku;

-- Buat database baru
CREATE DATABASE toko_buku;

-- Gunakan database yang baru dibuat
USE toko_buku;

-- Buat tabel Buku (Produk)
CREATE TABLE IF NOT EXISTS Buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    penulis VARCHAR(255) NOT NULL,
    harga DECIMAL(10, 2) NOT NULL, -- Harga buku
    stok INT NOT NULL DEFAULT 0,    -- Stok buku tersedia
    tanggal_masuk TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Tanggal buku masuk inventaris
);

-- Buat tabel Pelanggan
CREATE TABLE IF NOT EXISTS Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- Email unik untuk setiap pelanggan
    tanggal_daftar TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Buat tabel TransaksiPenjualan
CREATE TABLE IF NOT EXISTS TransaksiPenjualan (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_buku INT NOT NULL,
    id_pelanggan INT NOT NULL,
    jumlah_beli INT NOT NULL,
    tanggal_transaksi DATE NOT NULL,
    total_harga DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_buku) REFERENCES Buku(id_buku),
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan)
);

-- Masukkan data awal ke tabel Buku
INSERT INTO Buku (judul, penulis, harga, stok) VALUES
('Petualangan Sherina', 'Riri Riza', 75000.00, 15),
('Laskar Pelangi', 'Andrea Hirata', 85000.00, 20),
('Ayah, Mengapa Aku Berbeda?', 'Tere Liye', 60000.00, 10),
('Harry Potter dan Batu Bertuah', 'J.K. Rowling', 120000.00, 25),
('Filosofi Kopi', 'Dee Lestari', 70000.00, 12),
('Bumi', 'Tere Liye', 90000.00, 18);

-- Masukkan data awal ke tabel Pelanggan
INSERT INTO Pelanggan (nama, email) VALUES
('Budi Santoso', 'budi.s@example.com'),
('Siti Aminah', 'siti.a@example.com'),
('Joko Susilo', 'joko.s@example.com'),
('Dewi Lestari', 'dewi.l@example.com'),
('Andi Pratama', 'andi.p@example.com'),
('Citra Kirana', 'citra.k@example.com');

-- Masukkan data awal ke tabel TransaksiPenjualan
INSERT INTO TransaksiPenjualan (id_buku, id_pelanggan, jumlah_beli, tanggal_transaksi, total_harga) VALUES
(1, 1, 1, '2024-07-01', 75000.00),  -- Budi beli Petualangan Sherina
(2, 2, 2, '2024-07-03', 170000.00), -- Siti beli 2 Laskar Pelangi
(1, 3, 1, '2024-07-05', 75000.00),  -- Joko beli Petualangan Sherina
(4, 1, 1, '2024-07-06', 120000.00), -- Budi beli Harry Potter
(5, 4, 1, '2024-07-07', 70000.00),  -- Dewi beli Filosofi Kopi
(2, 5, 1, '2024-07-08', 85000.00);  -- Andi beli Laskar Pelangi

-- ====================================================================
-- BAGIAN 1: SOAL DDL (DATA DEFINITION LANGUAGE)
-- ====================================================================

-- Soal 1.1: Menambahkan Kolom Baru
-- Goal: Tambahkan kolom 'rating_buku' dengan tipe DECIMAL(2,1) dan nilai default 0.0 ke tabel 'Buku'.
-- Ini akan menyimpan rating rata-rata buku.
-- Tulis perintah ALTER TABLE Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 1.1:
DESC Buku;
-- Output yang diharapkan: Kolom 'rating_buku' dengan tipe DECIMAL(2,1) dan Default 0.0 akan muncul di struktur tabel Buku.


-- Soal 1.2: Mengubah Tipe Data Kolom
-- Goal: Ubah kolom 'email' di tabel 'Pelanggan' menjadi VARCHAR(300) untuk mengakomodasi alamat email yang lebih panjang.
-- Tulis perintah ALTER TABLE Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 1.2:
DESC Pelanggan;
-- Output yang diharapkan: Tipe data kolom 'email' akan berubah menjadi VARCHAR(300).


-- Soal 1.3: Menambahkan Kolom Sementara (untuk dihapus nanti)
-- Goal: Tambahkan kolom 'catatan_admin' dengan tipe TEXT ke tabel 'TransaksiPenjualan'.
-- Tulis perintah ALTER TABLE Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 1.3:
DESC TransaksiPenjualan;
-- Output yang diharapkan: Kolom 'catatan_admin' dengan tipe TEXT akan muncul di struktur tabel TransaksiPenjualan.


-- Soal 1.4: Menghapus Kolom
-- Goal: Hapus kolom 'catatan_admin' yang baru saja Anda tambahkan dari tabel 'TransaksiPenjualan'.
-- Tulis perintah ALTER TABLE Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 1.4:
DESC TransaksiPenjualan;
-- Output yang diharapkan: Kolom 'catatan_admin' akan hilang dari struktur tabel TransaksiPenjualan.


-- ====================================================================
-- BAGIAN 2: SOAL DML (DATA MANIPULATION LANGUAGE)
-- ====================================================================

-- Soal 2.1: Memasukkan Data Baru
-- Goal: Masukkan satu buku baru ke tabel 'Buku':
-- Judul: 'Negeri 5 Menara', Penulis: 'Ahmad Fuadi', Harga: 80000.00, Stok: 10
-- Tulis perintah INSERT INTO Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 2.1:
-- Jalankan perintah Anda, lalu jalankan SELECT di bawah untuk melihat hasilnya.
SELECT * FROM Buku WHERE judul = 'Negeri 5 Menara';
-- Output yang diharapkan: Menampilkan satu baris data untuk buku 'Negeri 5 Menara' dengan informasi yang sesuai.


-- Soal 2.2: Memperbarui Data
-- Goal: Perbarui harga buku 'Laskar Pelangi' menjadi 95000.00 dan stoknya menjadi 22.
-- Tulis perintah UPDATE Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 2.2:
-- Jalankan perintah Anda, lalu jalankan SELECT di bawah untuk melihat hasilnya.
SELECT judul, harga, stok FROM Buku WHERE judul = 'Laskar Pelangi';
-- Output yang diharapkan: Menampilkan judul 'Laskar Pelangi' dengan harga 95000.00 dan stok 22.


-- Soal 2.3: Menghapus Data
-- Goal: Hapus semua transaksi penjualan yang terjadi sebelum tanggal '2024-07-05'.
-- Tulis perintah DELETE FROM Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Verifikasi Soal 2.3:
-- Jalankan perintah Anda, lalu jalankan SELECT di bawah untuk melihat hasilnya.
SELECT * FROM TransaksiPenjualan;
-- Output yang diharapkan: Menampilkan daftar transaksi penjualan tanpa transaksi dengan id_transaksi 1 dan 2.


-- ====================================================================
-- BAGIAN 3: SOAL QUERY DASAR DAN OPERATOR
-- ====================================================================

-- Soal 3.1: Mengambil Semua Data
-- Goal: Tampilkan semua kolom dan baris dari tabel 'Pelanggan'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua kolom dan baris dari tabel Pelanggan.


-- Soal 3.2: Mengambil Kolom Spesifik
-- Goal: Tampilkan hanya kolom 'judul' dan 'penulis' dari tabel 'Buku'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan hanya kolom judul dan penulis dari tabel Buku.


-- Soal 3.3: Filter Data dengan WHERE
-- Goal: Tampilkan judul dan harga buku yang memiliki harga di atas 100000.00.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan judul dan harga buku 'Harry Potter dan Batu Bertuah'.


-- Soal 3.4: Operator Logika AND
-- Goal: Tampilkan judul dan stok buku yang ditulis oleh 'Tere Liye' DAN memiliki stok kurang dari 15.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan judul 'Ayah, Mengapa Aku Berbeda?' dengan stok 10.


-- Soal 3.5: Operator Logika OR
-- Goal: Tampilkan nama pelanggan yang emailnya diakhiri dengan '@example.com' ATAU namanya mengandung 'Siti'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua pelanggan karena semua email diakhiri '@example.com', termasuk 'Siti Aminah'.


-- Soal 3.6: Operator Logika NOT
-- Goal: Tampilkan semua buku KECUALI yang harganya di bawah 70000.00.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua buku kecuali 'Ayah, Mengapa Aku Berbeda?'.


-- Soal 3.7: Operator IN
-- Goal: Tampilkan nama pelanggan yang id_pelanggan-nya ada di daftar (1, 3, 5).
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan nama 'Budi Santoso', 'Joko Susilo', dan 'Andi Pratama'.


-- Soal 3.8: Operator LIKE (Pencarian Bagian Awal)
-- Goal: Tampilkan judul buku yang diawali dengan huruf 'F'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan judul 'Filosofi Kopi'.


-- Soal 3.9: Operator LIKE (Pencarian Bagian Tengah/Akhir)
-- Goal: Tampilkan nama pelanggan yang namanya mengandung 'di'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan nama 'Budi Santoso' dan 'Andi Pratama'.


-- Soal 3.10: Mengambil Data Unik (DISTINCT)
-- Goal: Tampilkan daftar unik semua penulis yang ada di tabel 'Buku'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan daftar penulis unik seperti 'Riri Riza', 'Andrea Hirata', 'Tere Liye', 'J.K. Rowling', 'Dee Lestari', 'Ahmad Fuadi'.


-- Soal 3.11: Mengurutkan Hasil (ORDER BY ASC)
-- Goal: Tampilkan semua buku, diurutkan berdasarkan judul secara abjad (A-Z).
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua buku diurutkan berdasarkan judul dari A ke Z.


-- Soal 3.12: Mengurutkan Hasil (ORDER BY DESC)
-- Goal: Tampilkan semua buku, diurutkan berdasarkan harga dari yang termahal ke termurah.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua buku diurutkan dari harga tertinggi ke terendah.


-- Soal 3.13: Membatasi Hasil (LIMIT)
-- Goal: Tampilkan 2 buku termahal dari daftar buku.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan 2 buku dengan harga tertinggi.


-- ====================================================================
-- BAGIAN 4: SOAL FUNGSI AGREGAT DAN GROUPING
-- ====================================================================

-- Soal 4.1: Fungsi Agregat SUM
-- Goal: Hitung total stok dari semua buku di toko.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan satu nilai total stok dari semua buku.


-- Soal 4.2: Fungsi Agregat COUNT
-- Goal: Hitung total jumlah buku yang ada di tabel 'Buku'.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan satu nilai total jumlah buku.


-- Soal 4.3: Fungsi Agregat AVG
-- Goal: Hitung rata-rata harga buku yang ada.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan satu nilai rata-rata harga buku.


-- Soal 4.4: Fungsi Agregat MIN
-- Goal: Temukan harga buku termurah.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan satu nilai harga buku termurah.


-- Soal 4.5: Fungsi Agregat MAX
-- Goal: Temukan harga buku termahal.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan satu nilai harga buku termahal.


-- Soal 4.6: Mengelompokkan Data (GROUP BY)
-- Goal: Hitung berapa banyak buku yang ditulis oleh setiap penulis.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan daftar penulis dan jumlah buku yang mereka tulis.


-- Soal 4.7: Memfilter Kelompok (HAVING)
-- Goal: Hitung total penjualan (jumlah_beli) per buku, tetapi hanya tampilkan buku yang total penjualannya lebih dari 1 unit.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan judul buku 'Laskar Pelangi' dengan total penjualan 3 (karena 1 dari Siti, 1 dari Andi, 1 dari Joko).


-- ====================================================================
-- BAGIAN 5: SOAL JOIN QUERIES
-- ====================================================================

-- Soal 5.1: INNER JOIN
-- Goal: Tampilkan daftar transaksi penjualan yang lengkap, termasuk nama pelanggan dan judul buku yang dibeli.
-- Hanya tampilkan transaksi yang datanya cocok di semua tabel (pelanggan dan buku).
-- Kolom yang ditampilkan: nama_pelanggan, judul_buku, jumlah_beli, tanggal_transaksi, total_harga.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan daftar semua transaksi penjualan dengan detail pelanggan dan buku.


-- Soal 5.2: LEFT JOIN
-- Goal: Tampilkan semua pelanggan toko dan buku yang pernah mereka beli (jika ada).
-- Jika seorang pelanggan belum pernah membeli buku, kolom buku akan menampilkan NULL.
-- Kolom yang ditampilkan: nama_pelanggan, judul_buku, tanggal_transaksi.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua pelanggan. Pelanggan yang belum pernah bertransaksi (misal: Citra Kirana) akan memiliki kolom judul_buku dan tanggal_transaksi sebagai NULL.


-- Soal 5.3: RIGHT JOIN
-- Goal: Tampilkan semua buku yang ada di inventaris toko dan siapa saja yang pernah membelinya (jika ada).
-- Jika sebuah buku belum pernah dibeli, kolom pelanggan akan menampilkan NULL.
-- Kolom yang ditampilkan: judul_buku, nama_pelanggan, tanggal_transaksi.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]


-- Output yang diharapkan: Menampilkan semua buku yang telah terjual. Buku 'Negeri 5 Menara' (jika belum terjual) akan muncul dengan nama_pelanggan dan tanggal_transaksi sebagai NULL.


-- Soal 5.4: SELF JOIN
-- Goal: Temukan pasangan buku yang ditulis oleh penulis yang sama.
-- Tampilkan judul kedua buku dan nama penulisnya. Pastikan tidak ada duplikasi pasangan (misal: A-B dan B-A).
-- Kolom yang ditampilkan: judul_buku_1, penulis, judul_buku_2.
-- Tulis perintah SELECT Anda di bawah ini:

-- [Tulis perintah SQL Anda di sini]

-- Output yang diharapkan: Menampilkan pasangan buku 'Ayah, Mengapa Aku Berbeda?' dan 'Bumi' dengan penulis 'Tere Liye'.


-- ====================================================================
-- AKHIR TES
-- ====================================================================

