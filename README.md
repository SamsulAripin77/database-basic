# Kurikulum SQL untuk SMK: Panduan Praktis PerpustakaanPanduan
ini dirancang untuk membantu Anda memahami dasar-dasar SQL (Structured Query Language) dengan pendekatan studi kasus Perpustakaan Sekolah. Kita akan fokus pada perintah DDL (Data Definition Language) untuk membangun dan mengubah struktur database, serta DML (Data Manipulation Language) untuk mengelola dan mengambil data.

## Bagian 1: Definisi Data (DDL)
DDL adalah perintah SQL yang digunakan untuk membuat, mengubah, dan menghapus objek-objek dalam database, seperti database itu sendiri dan tabel.
## 1.1. Membuat Database: CREATE DATABASE

```sql
-- Menghapus database 'perpustakaan_sekolah' jika sudah ada, untuk memulai dari awal
DROP DATABASE IF EXISTS perpustakaan_sekolah;

-- Membuat database baru bernama 'perpustakaan_sekolah'
CREATE DATABASE perpustakaan_sekolah;

-- Menggunakan database 'perpustakaan_sekolah' untuk operasi SQL selanjutnya
USE perpustakaan_sekolah;
```
### Penjelasan Efek & Fungsi:

  - DROP DATABASE IF EXISTS perpustakaan_sekolah;: Berfungsi sebagai "reset" yang aman. Ini menghapus database jika sudah ada, tanpa error jika belum ada, berguna untuk memulai latihan dari kondisi "bersih".

  - CREATE DATABASE perpustakaan_sekolah;: Menciptakan wadah utama, seperti membangun gedung baru, di mana semua data dan tabel perpustakaan Anda akan disimpan.

  - USE perpustakaan_sekolah;: Memilih database yang akan dioperasikan. Semua perintah SQL yang Anda jalankan setelah ini akan beroperasi di dalam perpustakaan_sekolah.

#### Cara Verifikasi:
```
SHOW DATABASES;
```

Anda akan melihat perpustakaan_sekolah dalam daftar database Anda, dan VS Code/terminal akan mengkonfirmasi bahwa Anda telah beralih ke database tersebut.

## 1.2. Membuat Tabel: CREATE TABLE

Tabel adalah struktur dasar untuk menyimpan data dalam baris dan kolom.
Tabel Buku

```
-- Membuat tabel 'Buku' untuk menyimpan informasi koleksi buku perpustakaan.
-- Kolom:
--   id_buku: Kunci utama unik, otomatis bertambah (INT AUTO_INCREMENT PRIMARY KEY)
--   judul: Nama buku, wajib diisi (VARCHAR(255) NOT NULL)
--   penulis: Nama penulis buku, wajib diisi (VARCHAR(255) NOT NULL)
--   tahun_terbit: Tahun buku diterbitkan, bisa kosong (INT)
--   stok: Jumlah buku yang tersedia, wajib diisi, default 1 (INT NOT NULL DEFAULT 1)
--   tanggal_ditambahkan: Waktu buku dicatat ke sistem, otomatis terisi (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
CREATE TABLE IF NOT EXISTS Buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    penulis VARCHAR(255) NOT NULL,
    tahun_terbit INT,
    stok INT NOT NULL DEFAULT 1,
    tanggal_ditambahkan TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

```

### Penjelasan Efek & Fungsi Kolom:

  CREATE TABLE IF NOT EXISTS Buku (...): Berfungsi untuk membuat tabel baru bernama Buku. IF NOT EXISTS memastikan perintah ini aman dan tidak error jika tabel Buku sudah ada.

  #### Tipe Data Umum:
  - INT: Untuk angka bulat (misal: id_buku, stok, tahun_terbit).

  - VARCHAR(255): Untuk teks atau string dengan panjang maksimal 255 karakter (misal: judul, penulis).

  - DATE: Untuk tanggal (YYYY-MM-DD).

  - TIMESTAMP: Untuk tanggal dan waktu (YYYY-MM-DD HH:MM:SS). DEFAULT CURRENT_TIMESTAMP akan otomatis mengisi kolom ini dengan waktu saat ini saat baris dibuat, berguna untuk melacak kapan buku dicatat.

  - BOOLEAN (sering TINYINT(1) di MySQL): Untuk nilai benar (1) atau salah (0).

  - AUTO_INCREMENT: Otomatis mengisi nilai angka yang bertambah setiap kali ada baris baru, memastikan id_buku unik.

  - PRIMARY KEY: Kunci unik untuk setiap baris, memastikan id_buku unik dan mempercepat pencarian.

  - NOT NULL: Memastikan kolom wajib diisi dan tidak boleh kosong (misal: setiap buku harus punya judul).

  - NULLABLE: Kolom tanpa NOT NULL berarti boleh kosong (misal: tahun_terbit jika informasinya belum tersedia).
   
  #### Cara Verifikasi:
```
  DESC Buku;
```


### Tabel Anggota
```
-- Membuat tabel 'Anggota' untuk menyimpan data siswa yang menjadi anggota perpustakaan.
-- Kolom:
--   id_anggota: Kunci utama unik, otomatis bertambah (INT AUTO_INCREMENT PRIMARY KEY)
--   nama: Nama lengkap anggota, wajib diisi (VARCHAR(255) NOT NULL)
--   kelas: Kelas anggota, wajib diisi (VARCHAR(50) NOT NULL)
--   tanggal_daftar: Waktu anggota mendaftar, otomatis terisi (TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
CREATE TABLE IF NOT EXISTS Anggota (
    id_anggota INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kelas VARCHAR(50) NOT NULL,
    tanggal_daftar TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Cara Verifikasi:
```
DESC Anggota;
```

### Tabel Peminjaman (dengan Relasi)
```
-- Membuat tabel 'Peminjaman' untuk mencatat transaksi peminjaman buku.
-- Kolom:
--   id_peminjaman: Kunci utama unik, otomatis bertambah (INT AUTO_INCREMENT PRIMARY KEY)
--   id_buku: ID buku yang dipinjam, wajib diisi (INT NOT NULL)
--   id_anggota: ID anggota yang meminjam, wajib diisi (INT NOT NULL)
--   tanggal_pinjam: Tanggal buku dipinjam, wajib diisi (DATE NOT NULL)
--   tanggal_kembali: Tanggal buku dikembalikan, bisa kosong jika belum kembali (DATE)
-- Relasi (FOREIGN KEY):
--   id_buku terhubung ke id_buku di tabel Buku
--   id_anggota terhubung ke id_anggota di tabel Anggota
CREATE TABLE IF NOT EXISTS Peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    id_buku INT NOT NULL,
    id_anggota INT NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    FOREIGN KEY (id_buku) REFERENCES Buku(id_buku),
    FOREIGN KEY (id_anggota) REFERENCES Anggota(id_anggota)
);
```

#### Penjelasan Efek & Fungsi Relasi (FOREIGN KEY):

- FOREIGN KEY (kolom_ini) REFERENCES TabelLain(kolom_tabel_lain): Berfungsi untuk membuat relasi antar tabel. Pada kasus ini, ini memastikan bahwa setiap id_buku yang dicatat di tabel Peminjaman harus benar-benar ada di tabel Buku, dan id_anggota harus ada di tabel Anggota. Tujuannya adalah menjaga konsistensi data; Anda tidak bisa mencatat peminjaman untuk buku atau anggota yang tidak terdaftar.

#### Cara Verifikasi:
```
DESC Peminjaman;
```
Anda akan melihat kolom id_buku dan id_anggota memiliki kunci MUL (multiple key), menandakan mereka adalah FOREIGN KEY.

## 1.3. Mengubah Struktur Tabel: ALTER TABLE
```
-- Menambahkan kolom 'penerbit' ke tabel Buku
ALTER TABLE Buku
ADD COLUMN penerbit VARCHAR(255);
```
#### Penjelasan Efek & Fungsi:

- ALTER TABLE Buku ADD COLUMN penerbit VARCHAR(255);: Berfungsi untuk menambahkan kolom baru bernama penerbit ke tabel Buku yang sudah ada. Ini berguna jika Anda perlu mencatat informasi tambahan untuk setiap buku tanpa membuat ulang tabel.

#### Cara Verifikasi:
```
DESC Buku;
```
Anda akan melihat penerbit muncul di daftar kolom.
```
-- Mengubah tipe data kolom 'tahun_terbit' di tabel Buku dari INT menjadi SMALLINT
ALTER TABLE Buku
MODIFY COLUMN tahun_terbit SMALLINT;
```
#### Penjelasan Efek & Fungsi:

- ALTER TABLE Buku MODIFY COLUMN tahun_terbit SMALLINT;: Berfungsi untuk mengubah tipe data kolom tahun_terbit dari INT menjadi SMALLINT. Ini bisa dilakukan untuk mengoptimalkan penggunaan memori jika rentang tahun tidak melebihi batas SMALLINT.

#### Cara Verifikasi:
```
DESC Buku;
```
Perhatikan kolom tahun_terbit akan menunjukkan tipe smallint.
```
-- Menghapus kolom 'penerbit' dari tabel Buku
ALTER TABLE Buku
DROP COLUMN penerbit;
```
#### Penjelasan Efek & Fungsi:

- ALTER TABLE Buku DROP COLUMN penerbit;: Berfungsi untuk menghapus kolom penerbit dari tabel Buku. Gunakan perintah ini dengan sangat hati-hati karena semua data yang ada di kolom tersebut akan hilang secara permanen.

#### Cara Verifikasi:
```
DESC Buku;
```
Kolom penerbit sudah tidak ada.

## Bagian 2: Manipulasi Data (DML)

DML adalah perintah SQL yang digunakan untuk memasukkan, mengubah, menghapus, dan mengambil data dari tabel.
### 2.1. Memasukkan Data: INSERT INTO
```
-- Memasukkan data buku ke tabel 'Buku'
INSERT INTO Buku (judul, penulis, tahun_terbit, stok) VALUES
('Petualangan Sherina', 'Riri Riza', 2000, 5),
('Laskar Pelangi', 'Andrea Hirata', 2005, 8),
('Ayah, Mengapa Aku Berbeda?', 'Tere Liye', 2010, 3),
('Harry Potter dan Batu Bertuah', 'J.K. Rowling', 1997, 10);
```
#### Penjelasan Efek & Fungsi:

- INSERT INTO Buku (...) VALUES (...): Berfungsi untuk menambahkan baris data baru ke dalam tabel Buku. Pada kasus ini, Anda mengisi data awal koleksi buku perpustakaan Anda.

#### Cara Verifikasi:
```
SELECT * FROM Buku;
```
```
-- Memasukkan data anggota ke tabel 'Anggota'
INSERT INTO Anggota (nama, kelas) VALUES
('Budi Santoso', 'VII A'),
('Siti Aminah', 'VIII B'),
('Joko Susilo', 'IX C'),
('Dewi Lestari', 'VII A');
```

#### Cara Verifikasi:
```
SELECT * FROM Anggota;
```

```
-- Memasukkan data peminjaman ke tabel 'Peminjaman'
INSERT INTO Peminjaman (id_buku, id_anggota, tanggal_pinjam, tanggal_kembali) VALUES
(1, 1, '2024-07-01', '2024-07-08'), -- Budi pinjam Petualangan Sherina, sudah kembali
(2, 2, '2024-07-03', NULL),         -- Siti pinjam Laskar Pelangi, belum kembali
(1, 3, '2024-07-05', NULL),         -- Joko pinjam Petualangan Sherina, belum kembali
(4, 1, '2024-07-06', NULL);         -- Budi pinjam Harry Potter, belum kembali
```
#### Cara Verifikasi:
```
SELECT * FROM Peminjaman;
```
### 2.2. Mengubah Data: UPDATE
```
-- Mengubah stok buku 'Laskar Pelangi' menjadi 7
UPDATE Buku
SET stok = 7
WHERE judul = 'Laskar Pelangi';
```

#### Penjelasan Efek & Fungsi:

- UPDATE Buku SET stok = 7 WHERE judul = 'Laskar Pelangi';: Berfungsi untuk mengubah data yang sudah ada di tabel. Pada kasus ini, Anda menyesuaikan jumlah stok buku 'Laskar Pelangi'. Klausa WHERE sangat penting untuk menentukan baris mana yang akan diubah; tanpa WHERE, semua baris di tabel Buku akan terpengaruh!

#### Cara Verifikasi:
```
SELECT judul, stok FROM Buku WHERE judul = 'Laskar Pelangi';
```

Anda akan melihat nilai stok untuk 'Laskar Pelangi' kini adalah 7.

```
-- Mengubah tanggal kembali peminjaman Siti Aminah (id_anggota 2, id_buku 2)
UPDATE Peminjaman
SET tanggal_kembali = '2024-07-10'
WHERE id_buku = 2 AND id_anggota = 2;
```
#### Cara Verifikasi:
```
SELECT * FROM Peminjaman WHERE id_buku = 2 AND id_anggota = 2;
```

Anda akan melihat kolom tanggal_kembali untuk peminjaman tersebut kini terisi 2024-07-10.
### 2.3. Menghapus Data: DELETE FROM
```
-- Menghapus buku 'Ayah, Mengapa Aku Berbeda?' dari tabel Buku
DELETE FROM Buku
WHERE judul = 'Ayah, Mengapa Aku Berbeda?';
```

#### Penjelasan Efek & Fungsi:

- DELETE FROM Buku WHERE judul = 'Ayah, Mengapa Aku Berbeda?';: Berfungsi untuk menghapus satu atau lebih baris dari tabel. Pada kasus ini, Anda menghapus data buku yang sudah tidak ada di koleksi. Klausa WHERE sangat krusial untuk menentukan baris mana yang akan dihapus; tanpa WHERE, semua data di tabel Buku akan terhapus!

#### Cara Verifikasi:
```
SELECT * FROM Buku;
```
Buku 'Ayah, Mengapa Aku Berbeda?' tidak akan muncul lagi dalam hasil.

```
-- Menghapus peminjaman yang sudah dikembalikan sebelum tanggal 5 Juli 2024
DELETE FROM Peminjaman
WHERE tanggal_kembali IS NOT NULL AND tanggal_kembali < '2024-07-05';
```
#### Cara Verifikasi:
```
SELECT * FROM Peminjaman;
```

Peminjaman yang sudah dikembalikan sebelum tanggal 5 Juli 2024 (misal, peminjaman id_peminjaman = 1) akan hilang dari daftar.
Bagian 3: Mengambil Data (Query Lanjutan)


### 3.1. Memilih Data: SELECT FROM WHERE
```
-- Mengambil semua kolom (*) dari tabel Buku
SELECT * FROM Buku;
```

#### Penjelasan Efek & Fungsi:

  - SELECT *: Berfungsi untuk mengambil semua kolom dari baris yang dipilih.

  - FROM Buku: Menentukan bahwa data akan diambil dari tabel Buku.

  - WHERE: Berfungsi untuk memfilter baris berdasarkan kondisi yang ditentukan.

```
-- Mengambil hanya kolom judul dan penulis dari tabel Buku
SELECT judul, penulis FROM Buku;
```
```
-- Mengambil nama anggota yang kelasnya 'VII A'
SELECT nama FROM Anggota WHERE kelas = 'VII A';
```

### 3.2. Operator Logika: AND, OR, NOT
```
-- Mencari buku yang ditulis oleh 'Andrea Hirata' DAN stoknya lebih dari 5
SELECT judul, penulis, stok FROM Buku WHERE penulis = 'Andrea Hirata' AND stok > 5;
```

#### Penjelasan Efek & Fungsi:

- AND: Berfungsi untuk menggabungkan dua atau lebih kondisi. Semua kondisi yang digabungkan dengan AND harus benar agar baris disertakan. Pada kasus ini, Anda mencari buku yang memenuhi kedua kriteria: penulisnya Andrea Hirata dan stoknya lebih dari 5.
```
-- Mencari anggota dari kelas 'VII A' ATAU 'VIII B'
SELECT nama, kelas FROM Anggota WHERE kelas = 'VII A' OR kelas = 'VIII B';
```
#### Penjelasan Efek & Fungsi:

- OR: Berfungsi untuk menggabungkan dua atau lebih kondisi. Setidaknya satu kondisi yang digabungkan dengan OR harus benar agar baris disertakan. Di sini, Anda mencari anggota yang bisa berasal dari kelas 'VII A' atau 'VIII B'.
```
-- Mencari semua buku KECUALI yang berjudul 'Petualangan Sherina'
SELECT judul FROM Buku WHERE NOT judul = 'Petualangan Sherina';
```
#### Penjelasan Efek & Fungsi:

- NOT: Berfungsi untuk membalikkan hasil kondisi. Misalnya, NOT judul = 'X' berarti Anda ingin semua baris di mana judulnya tidak sama dengan 'X'.

### 3.3. Operator Pencarian: IN, LIKE
```
-- Mencari anggota dari kelas 'VII A' atau 'IX C'
SELECT nama, kelas FROM Anggota WHERE kelas IN ('VII A', 'IX C');
```
#### Penjelasan Efek & Fungsi:

- IN ('nilai1', 'nilai2', ...): Berfungsi untuk memeriksa apakah nilai kolom cocok dengan salah satu nilai yang ada di dalam daftar yang diberikan. Ini lebih ringkas daripada menggunakan banyak kondisi OR.
```
-- Mencari buku yang judulnya mengandung kata 'Potter'
SELECT judul FROM Buku WHERE judul LIKE '%Potter%';
```
#### Penjelasan Efek & Fungsi:

- LIKE 'pola%': Berfungsi untuk mencari pola dalam data string.

- %: Mewakili nol atau lebih karakter (wildcard). Pada kasus ini, '%Potter%' akan menemukan judul buku yang memiliki kata "Potter" di mana saja (depan, tengah, atau akhir).

- _: Mewakili satu karakter tunggal (wildcard). Contoh: 'B_ku' akan menemukan "Buku", "Baku".

### 3.4. Memilih Data Unik: DISTINCT
```
-- Menampilkan daftar kelas yang unik dari tabel Anggota
SELECT DISTINCT kelas FROM Anggota;
```
#### Penjelasan Efek & Fungsi:

- DISTINCT: Berfungsi untuk mengembalikan hanya nilai-nilai unik dari kolom yang dipilih. Ini menghilangkan baris duplikasi dalam hasil. Pada kasus ini, Anda akan melihat daftar semua kelas yang terdaftar di perpustakaan, tanpa pengulangan.

### 3.5. Mengurutkan Hasil: ORDER BY
```
-- Mengurutkan buku berdasarkan judul secara abjad (A-Z)
SELECT judul, penulis FROM Buku ORDER BY judul ASC;
```
### Penjelasan Efek & Fungsi:

- ORDER BY: Berfungsi untuk mengurutkan hasil query berdasarkan satu atau lebih kolom.

- ASC: (Ascending) Mengurutkan dari nilai terkecil ke terbesar (A-Z untuk teks, angka terkecil ke terbesar). Ini adalah urutan default.

- DESC: (Descending) Mengurutkan dari nilai terbesar ke terkecil (Z-A untuk teks, angka terbesar ke terkecil).

### 3.6. Membatasi Hasil: LIMIT
```
-- Mengambil 2 buku pertama dari tabel Buku
SELECT judul, penulis FROM Buku LIMIT 2;
```
### Penjelasan Efek & Fungsi:

- LIMIT N: Berfungsi untuk membatasi jumlah baris yang dikembalikan oleh query menjadi N baris pertama. Ini sangat berguna untuk paginasi (misalnya, menampilkan 10 buku per halaman) atau hanya mengambil sampel data.

### 3.7. Fungsi Agregat: SUM, COUNT, AVG, MIN, MAX
```
-- Menghitung total stok semua buku di perpustakaan
SELECT SUM(stok) AS total_stok_buku FROM Buku;
```
#### Penjelasan Efek & Fungsi:

- SUM(kolom): Berfungsi untuk menghitung total nilai numerik dari sebuah kolom (misal: total stok buku).

- COUNT(kolom) / COUNT(*): Berfungsi untuk menghitung jumlah baris atau jumlah nilai non-NULL dalam sebuah kolom. Gunakan COUNT(*) untuk menghitung total baris.

- AVG(kolom): Berfungsi untuk menghitung rata-rata nilai numerik dari sebuah kolom.

- MIN(kolom): Berfungsi untuk menemukan nilai terkecil dalam sebuah kolom.

- MAX(kolom): Berfungsi untuk menemukan nilai terbesar dalam sebuah kolom.
- AS nama_alias: Berfungsi untuk memberikan nama sementara (alias) pada kolom hasil perhitungan agar lebih mudah dibaca (misal: total_stok_buku).

### 3.8. Mengelompokkan Data: GROUP BY dan HAVING
```
-- Menghitung jumlah anggota per kelas
SELECT kelas, COUNT(id_anggota) AS jumlah_anggota
FROM Anggota
GROUP BY kelas;
```
#### Penjelasan Efek & Fungsi:

- GROUP BY kelas: Berfungsi untuk mengelompokkan baris yang memiliki nilai yang sama di kolom kelas menjadi satu kelompok. Fungsi agregat (seperti COUNT()) kemudian akan diterapkan pada setiap kelompok. Pada kasus ini, Anda ingin tahu berapa banyak anggota di setiap kelas yang berbeda.
```
-- Menghitung jumlah anggota per kelas, tapi hanya untuk kelas yang memiliki lebih dari 1 anggota
SELECT kelas, COUNT(id_anggota) AS jumlah_anggota
FROM Anggota
GROUP BY kelas
HAVING COUNT(id_anggota) > 1;
```
#### Penjelasan Efek & Fungsi (Perbedaan HAVING vs. WHERE):

- HAVING COUNT(id_anggota) > 1: Berfungsi untuk memfilter kelompok yang dihasilkan oleh GROUP BY. Kondisi HAVING diterapkan setelah fungsi agregat dihitung pada setiap kelompok. Pada kasus ini, Anda hanya ingin melihat kelas-kelas yang memiliki lebih dari satu anggota.

- Perbedaan dengan WHERE: WHERE memfilter baris sebelum pengelompokan dan agregasi dilakukan. Sedangkan HAVING memfilter kelompok hasil setelah agregasi. Anda tidak bisa menggunakan fungsi agregat di klausa WHERE.

## Bagian 4: Menggabungkan Data (JOIN Queries)

JOIN berfungsi untuk menggabungkan baris dari dua atau lebih tabel berdasarkan kolom terkait. Ini sangat kuat untuk mendapatkan gambaran lengkap dari data yang tersebar di beberapa tabel.
### 4.1. INNER JOIN: Hanya Data yang Cocok
```
-- Menampilkan daftar peminjaman: siapa (nama anggota) meminjam buku apa (judul buku)
SELECT
    A.nama AS nama_anggota,
    B.judul AS judul_buku,
    P.tanggal_pinjam,
    P.tanggal_kembali
FROM Peminjaman AS P
INNER JOIN Anggota AS A ON P.id_anggota = A.id_anggota
INNER JOIN Buku AS B ON P.id_buku = B.id_buku;
```
#### Penjelasan Efek & Fungsi:

- INNER JOIN: Berfungsi untuk mengembalikan hanya baris-baris ketika ada kecocokan di kedua tabel yang digabungkan berdasarkan kondisi ON. Pada kasus ini, INNER JOIN digunakan untuk menggabungkan informasi peminjaman (Peminjaman), siapa yang meminjam (Anggota), dan buku apa yang dipinjam (Buku). Jika ada peminjaman yang id_buku atau id_anggota-nya tidak valid (tidak ada di tabel Buku atau Anggota), maka baris peminjaman tersebut tidak akan muncul.

### 4.2. LEFT JOIN: Semua dari Kiri, yang Cocok dari Kanan
```
-- Menampilkan semua anggota dan buku yang pernah mereka pinjam (jika ada)
SELECT
    A.nama AS nama_anggota,
    B.judul AS judul_buku,
    P.tanggal_pinjam
FROM Anggota AS A
LEFT JOIN Peminjaman AS P ON A.id_anggota = P.id_anggota
LEFT JOIN Buku AS B ON P.id_buku = B.id_buku;
```
#### Penjelasan Efek & Fungsi:

- LEFT JOIN (atau LEFT OUTER JOIN): Berfungsi untuk mengembalikan semua baris dari tabel "kiri" (tabel pertama setelah FROM, yaitu Anggota pada kasus ini), dan hanya baris yang cocok dari tabel "kanan". Jika tidak ada kecocokan di tabel kanan (misalnya, seorang anggota belum pernah meminjam buku), kolom dari tabel kanan akan berisi NULL. Pada kasus ini, LEFT JOIN digunakan agar Anda bisa melihat semua anggota perpustakaan, termasuk mereka yang belum pernah melakukan peminjaman.

### 4.3. RIGHT JOIN: Semua dari Kanan, yang Cocok dari Kiri
```
-- Menampilkan semua buku dan siapa saja yang meminjamnya (jika ada)
SELECT
    B.judul AS judul_buku,
    A.nama AS nama_anggota,
    P.tanggal_pinjam
FROM Buku AS B
RIGHT JOIN Peminjaman AS P ON B.id_buku = P.id_buku
RIGHT JOIN Anggota AS A ON P.id_anggota = A.id_anggota;
```
#### Penjelasan Efek & Fungsi:

- RIGHT JOIN (atau RIGHT OUTER JOIN): Berfungsi untuk mengembalikan semua baris dari tabel "kanan" (tabel kedua setelah JOIN), dan hanya baris yang cocok dari tabel "kiri". Jika tidak ada kecocokan di tabel kiri, kolom dari tabel kiri akan berisi NULL. Ini adalah kebalikan dari LEFT JOIN. Pada kasus ini, RIGHT JOIN digunakan agar Anda bisa melihat semua buku yang pernah terlibat dalam peminjaman, bahkan jika data buku tersebut mungkin tidak lengkap atau ada buku yang tidak terdaftar di awal.

### 4.4. SELF JOIN: Menggabungkan Tabel dengan Dirinya Sendiri
```
-- Mencari pasangan buku yang ditulis oleh penulis yang sama
SELECT
    B1.judul AS judul_buku_1,
    B1.penulis,
    B2.judul AS judul_buku_2
FROM Buku AS B1
INNER JOIN Buku AS B2 ON B1.penulis = B2.penulis
WHERE B1.id_buku < B2.id_buku;
```
#### Penjelasan Efek & Fungsi:

- SELF JOIN: Berfungsi untuk menggabungkan sebuah tabel dengan dirinya sendiri. Ini berguna ketika Anda perlu membandingkan baris dalam tabel yang sama. Pada kasus ini, SELF JOIN digunakan untuk menemukan pasangan buku yang ditulis oleh penulis yang sama di perpustakaan Anda. Kita menggunakan alias (B1, B2) untuk memperlakukan tabel Buku seolah-olah ada dua salinan terpisah.

- WHERE B1.id_buku < B2.id_buku: Kondisi ini berfungsi untuk menghindari hasil duplikat (misal: menampilkan "Buku A, Buku B" dan juga "Buku B, Buku A") dan juga untuk mencegah perbandingan baris dengan dirinya sendiri.
