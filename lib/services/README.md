# ShoesVault - Aplikasi Manajemen Koleksi Sepatu

## Deskripsi Aplikasi
ShoesVault adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna mengelola inventaris koleksi sepatu secara digital.

## Fitur Aplikasi
- **CRUD:** Menambah, menampilkan, mengedit, dan menghapus data sepatu.
- **Pencarian Real-time:** Memfilter daftar sepatu berdasarkan nama secara instan.
- **Detail Informasi:** Menampilkan detail spesifikasi sepatu pada halaman terpisah.
- **Validasi Data:** Memastikan data yang dimasukkan ke database sesuai.

## Widget yang Digunakan
- `Scaffold`: Kerangka utama halaman.
- `FutureBuilder`: Menangani pengambilan data asinkron dari Supabase.
- `ListView.builder`: Menampilkan daftar koleksi sepatu secara dinamis.
- `Card`: Wadah untuk setiap item sepatu agar terlihat rapi.
- `TextField`: Digunakan pada Search Bar dan Form Input.
- `FloatingActionButton`: Tombol navigasi cepat untuk menambah data baru.
- `AlertDialog`: Dialog konfirmasi untuk menghapus data.