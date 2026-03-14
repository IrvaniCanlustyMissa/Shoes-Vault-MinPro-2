# ShoesVault - Aplikasi Manajemen Koleksi Sepatu
![alt text](<Screenshot 2026-03-14 093800.png>)
## Deskripsi Aplikasi
ShoesVault adalah aplikasi mobile berbasis Flutter yang dikembangkan untuk membantu kolektor sepatu mengelola inventaris koleksi mereka secara digital. Aplikasi ini terintegrasi dengan Supabase sebagai *Backend-as-a-Service* (BaaS) untuk menyimpan data sepatu di Cloud secara aman dan real-time.

## Fitur Aplikasi
- **Manajemen Koleksi (CRUD):** Pengguna dapat menambah, melihat, mengubah, dan menghapus data sepatu koleksi.
- **Pencarian Real-time:** Fitur *Search Bar* yang memungkinkan pengguna mencari nama sepatu dengan cepat.
- **Tampilan Detail:** Halaman khusus untuk menampilkan informasi lengkap setiap sepatu.
- **Integrasi Cloud:** Data tersimpan di Supabase, memastikan koleksi dapat diakses dari mana saja.

## Widget yang Digunakan
Dalam membangun aplikasi ini, saya memanfaatkan beberapa komponen Flutter untuk menciptakan pengalaman pengguna yang intuitif:

* **`FutureBuilder`**: Mengelola status *loading*, *error*, dan pengambilan data dari database Supabase agar UI tetap responsif.
* **`ListView.builder`**: Menampilkan daftar koleksi sepatu secara efisien dengan performa yang optimal.
* **`Card`**: Memberikan struktur visual yang bersih dan modern untuk setiap item sepatu.
* **`TextField`**: Digunakan untuk input data pada form dan kolom pencarian.
* **`AlertDialog`**: Memberikan konfirmasi kepada pengguna sebelum melakukan aksi sensitif seperti menghapus data.
* **`Navigator`**: Menangani perpindahan antar halaman (Routing) antar layar aplikasi.


## Cara Menjalankan
1. Clone repository ini.
2. Jalankan `flutter pub get` untuk menginstall dependencies.
3. Konfigurasi `SupabaseService` dengan URL dan Key dari proyek Supabase kamu.
4. Jalankan `flutter run`.

## Demonstrasi
1. Menambah koleksi sepatu 
![alt text](<fitur tambah.png>)
Melakukan input data koleksi sepatu.

2. Hasil tambah koleksi
![alt text](<hasil tambah koleksi.png>)
Disini sudah ditambahkan data koleksi yang sebelumnya ditambahkan.

3. Detail koleksi
![alt text](<detail koleksi.png>)
Disini juga dapat melihat detail koleksi tertentu.

4. Edit koleksi
![alt text](<edit koleksi.png>)
Koleksi sepatu juga dapat dihapus, pada bagan data ukuran sepatu tidak dapat menginput angka, hanya huruf yang akan terbaca oleh sistem.

5. Pencarian koleksi
![alt text](<fitur pencarian.png>)
Dapat jga melakukan pencarian koleksi agar mudah mencari koleksi.