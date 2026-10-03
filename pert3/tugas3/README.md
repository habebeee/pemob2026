# tugas3

Tugas Pertemuan 3: aplikasi Daftar Belanja.

Laporan lengkap ada di [readme pertemuan 3](../readme.md).

State ada di `BelanjaModel` (`ChangeNotifier`) dan dibagikan dengan Provider. Halaman daftar memakai `context.watch()`, halaman tambah memakai `context.read()` setelah form lolos validasi.

```bash
flutter run
```

File utama: `lib/main.dart`.

Validasi form:

- Nama kosong menampilkan `Nama barang wajib diisi`.
- Jumlah kosong menampilkan `Jumlah wajib diisi`.
- Jumlah bukan angka, nol, atau negatif menampilkan `Jumlah harus angka lebih dari 0`.
- Kategori kosong menampilkan `Kategori wajib dipilih`.

AppBar menampilkan `Belum Dibeli` sesuai jumlah barang yang belum dicentang. Kategori yang tersedia: Makanan, Minuman, dan Lainnya.
