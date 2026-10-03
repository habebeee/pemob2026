# Praktikum Flutter Fundamental — Pertemuan 3

> **Mata Kuliah: Pemmob**
> **Praktikum:** Flutter Fundamental  
> **Pertemuan:** 3  
**Nama: Habiburrahman Ikwan**     
**NIM:** 20240801149 
> **Prodi:** Teknik Informatika  

---

## 1. Gambaran Praktikum

Pada pertemuan ketiga, saya mempelajari cara menerima input dari pengguna dan mengelola data yang berubah selama aplikasi berjalan. Materi dimulai dari `TextField`, `TextEditingController`, `Form`, validasi input, dropdown, checkbox, dan `setState`.

Setelah memahami state sederhana, pembahasan dilanjutkan dengan `ChangeNotifier` dan `Provider`. Konsep tersebut kemudian digunakan untuk membuat aplikasi **Daftar Tugas** dan dikembangkan menjadi **Daftar Belanja**.

Menurut pemahaman saya, inti dari materi ini adalah hubungan antara **input, state, dan tampilan**. Data yang dimasukkan pengguna perlu diproses dan disimpan sebagai state, lalu perubahan state tersebut harus dapat tercermin pada tampilan aplikasi.

---

## 2. Tujuan Pembelajaran

Beberapa hal yang saya pelajari pada praktikum ini:

- menerima input dari pengguna;
- membaca input menggunakan controller;
- membuat form dan validasi;
- memahami penggunaan `setState`;
- menggunakan `ChangeNotifier`;
- menggunakan `Provider`;
- membedakan `context.watch()` dan `context.read()`;
- melakukan navigasi antar halaman;
- membuat fitur tambah, ubah status, dan hapus data.

---

## 3. Input Dasar dengan TextField

Percobaan pertama menggunakan `TextField`.

```dart
final _controller = TextEditingController();
```

Controller digunakan untuk mengambil teks yang dimasukkan pengguna.

```dart
TextField(
  controller: _controller,
  decoration: const InputDecoration(
    labelText: 'Nama',
    border: OutlineInputBorder(),
  ),
)
```

Isi input dapat diambil menggunakan:

```dart
_controller.text
```

Kemudian hasilnya digunakan untuk mengubah nilai `_salam`:

```dart
setState(() => _salam = 'Halo, ${_controller.text}!');
```

Dari sini saya memahami bahwa `setState()` digunakan ketika nilai state pada sebuah `StatefulWidget` berubah dan tampilan perlu diperbarui.

Controller juga dibersihkan pada `dispose()`:

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## 4. Form dan Validasi

Setelah input dasar, praktik dilanjutkan dengan `Form`.

```dart
final _formKey = GlobalKey<FormState>();
```

Key tersebut dipasang pada:

```dart
Form(
  key: _formKey,
  child: ...
)
```

Input form menggunakan `TextFormField`.

Contohnya:

```dart
TextFormField(
  controller: _nama,
  decoration: const InputDecoration(
    labelText: 'Nama lengkap',
    border: OutlineInputBorder(),
  ),
  validator: (v) =>
      (v == null || v.trim().isEmpty)
          ? 'Nama wajib diisi'
          : null,
)
```

Validasi dijalankan menggunakan:

```dart
_formKey.currentState!.validate()
```

Jika data tidak memenuhi aturan, pesan validasi akan muncul pada form.

---

## 5. Dropdown dan Checkbox

Pada form pendaftaran digunakan `DropdownButtonFormField` untuk memilih jurusan.

Pilihan yang tersedia:

- Teknik Informatika
- Sistem Informasi
- Teknik Mesin

Nilainya disimpan pada:

```dart
String? _jurusan;
```

Kemudian diperbarui melalui `setState()`.

Selain itu digunakan `CheckboxListTile` untuk persetujuan pengguna. Nilainya disimpan pada:

```dart
bool _setuju = false;
```

Tombol daftar hanya aktif apabila checkbox sudah dipilih.

Hal ini menunjukkan bahwa state dapat digunakan tidak hanya untuk menampilkan data, tetapi juga untuk menentukan perilaku sebuah widget.

---

# 6. Memahami ChangeNotifier

Setelah memahami `setState`, praktik masuk ke state management menggunakan `ChangeNotifier`.

Contoh data tugas:

```dart
class Tugas {
  String judul;
  bool selesai;

  Tugas(this.judul, {this.selesai = false});
}
```

Kemudian data dikelola oleh:

```dart
class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];
}
```

Model memiliki beberapa method:

```dart
void tambah(String judul)
void toggle(int index)
void hapus(int index)
```

Setelah data berubah, dipanggil:

```dart
notifyListeners();
```

Contohnya:

```dart
void tambah(String judul) {
  _items.add(Tugas(judul));
  notifyListeners();
}
```

`notifyListeners()` digunakan untuk memberi tahu widget yang sedang mendengarkan model bahwa state telah berubah.

---

# 7. Provider

Model kemudian diberikan kepada aplikasi menggunakan:

```dart
ChangeNotifierProvider(
  create: (_) => TugasModel(),
  child: const MyApp(),
)
```

Dengan cara ini, `TugasModel` dapat digunakan oleh widget yang berada di bawah Provider.

Pada halaman daftar digunakan:

```dart
final model = context.watch<TugasModel>();
```

Sedangkan ketika hanya ingin menjalankan aksi digunakan:

```dart
context.read<TugasModel>().hapus(index);
```

Perbedaannya dapat dipahami seperti ini:

| Method | Kegunaan |
|---|---|
| `context.watch()` | Mengambil state dan mengikuti perubahan |
| `context.read()` | Mengambil state untuk menjalankan aksi |

---

# 8. Implementasi Daftar Tugas

Data tugas ditampilkan dengan:

```dart
ListView.builder(
  itemCount: model.items.length,
  itemBuilder: (context, i) {
    ...
  },
)
```

Setiap tugas mempunyai checkbox.

```dart
Checkbox(
  value: t.selesai,
  onChanged: (_) =>
      context.read<TugasModel>().toggle(i),
)
```

Jika tugas sudah selesai, judulnya diberi garis coret:

```dart
decoration: t.selesai
    ? TextDecoration.lineThrough
    : null,
```

Tugas juga dapat dihapus melalui:

```dart
context.read<TugasModel>().hapus(i);
```

---

# 9. Halaman Tambah Tugas

Untuk menambahkan tugas dibuat halaman baru.

Navigasi dilakukan menggunakan:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const TambahPage(),
  ),
);
```

Input tugas disimpan menggunakan `TextEditingController`.

Sebelum ditambahkan, input diperiksa:

```dart
final judul = _controller.text.trim();

if (judul.isEmpty) return;
```

Kemudian data dikirim ke model:

```dart
context.read<TugasModel>().tambah(judul);
```

Setelah berhasil, halaman ditutup:

```dart
Navigator.pop(context);
```

---

# 10. Perkembangan Latihan 1–4

## Latihan 1 — Validasi

Input judul dibuat menggunakan `Form` dan validator.

```dart
validator: (v) {
  if (v == null || v.trim().length < 3) {
    return 'Judul minimal 3 karakter';
  }
  return null;
}
```

Jadi tugas dengan judul kurang dari tiga karakter tidak dapat disimpan.

## Latihan 2 — Hapus Tugas Selesai

Ditambahkan fungsi:

```dart
void hapusSelesai() {
  _items.removeWhere((t) => t.selesai);
  notifyListeners();
}
```

Fungsi ini menghapus semua tugas yang sudah selesai.

## Latihan 3 — SnackBar

Setelah tugas berhasil ditambahkan, diberikan informasi melalui:

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Tugas ditambahkan'),
  ),
);
```

## Latihan 4 — Empty State

Jika belum ada tugas, ditampilkan:

```dart
const Center(
  child: Text('Belum ada tugas'),
)
```

Dengan begitu tampilan tidak langsung berupa list kosong.

---

# 11. Pengembangan Menjadi Daftar Belanja

Setelah memahami Daftar Tugas, konsep yang sama diterapkan pada tugas akhir **Daftar Belanja**.

Struktur data barang:

```dart
class Barang {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Barang(
    this.nama,
    this.jumlah,
    this.kategori, {
      this.sudahDibeli = false,
    });
}
```

Satu barang memiliki empat informasi:

- nama;
- jumlah;
- kategori;
- status sudah dibeli.

---

# 12. BelanjaModel

State aplikasi Daftar Belanja dikelola oleh:

```dart
class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];
}
```

Data yang dapat dibaca diberikan melalui:

```dart
List<Barang> get items => List.unmodifiable(_items);
```

Jumlah barang yang belum dibeli dihitung menggunakan:

```dart
int get jumlahBelumDibeli =>
    _items.where((barang) => !barang.sudahDibeli).length;
```

Nilai tersebut ditampilkan pada AppBar:

```dart
title: Text(
  'Belum Dibeli (${model.jumlahBelumDibeli})',
),
```

Jadi ketika checkbox berubah, jumlah pada AppBar juga dapat ikut berubah.

---

# 13. Form Tambah Barang

Halaman tambah barang memiliki tiga input utama:

1. nama barang;
2. jumlah;
3. kategori.

Controller yang digunakan:

```dart
final _nama = TextEditingController();
final _jumlah = TextEditingController();
```

Kategori disimpan sebagai:

```dart
String? _kategori;
```

### Validasi Nama

```dart
if (v == null || v.trim().isEmpty) {
  return 'Nama barang wajib diisi';
}
```

Nama barang tidak boleh kosong.

### Validasi Jumlah

```dart
final jumlah = int.tryParse(v);

if (jumlah == null || jumlah <= 0) {
  return 'Jumlah harus angka lebih dari 0';
}
```

Jumlah harus berupa angka dan nilainya lebih dari nol.

Penggunaan `int.tryParse()` membantu memeriksa apakah teks yang dimasukkan memang dapat diubah menjadi integer.

### Validasi Kategori

Kategori wajib dipilih:

```dart
if (v == null) {
  return 'Kategori wajib dipilih';
}
```

Pilihan kategori:

```text
Makanan
Minuman
Lainnya
```

---

# 14. Proses Penyimpanan

Setelah semua input valid, data dimasukkan ke model:

```dart
context.read<BelanjaModel>().tambah(
  _nama.text.trim(),
  int.parse(_jumlah.text),
  _kategori!,
);
```

Setelah itu pengguna kembali ke halaman daftar:

```dart
Navigator.pop(context);
```

Alur programnya:

```text
Isi form
   ↓
Klik Simpan
   ↓
Validasi
   ↓
Data valid?
 ┌─┴─┐
Tidak Ya
 ↓    ↓
Error  Tambah ke model
          ↓
   notifyListeners()
          ↓
     UI diperbarui
          ↓
   Kembali ke daftar
```

---

# 15. Tampilan Daftar Belanja

Data barang ditampilkan menggunakan `ListView.builder`.

Nama barang:

```dart
title: Text(barang.nama)
```

Informasi jumlah dan kategori:

```dart
subtitle: Text(
  'Jumlah: ${barang.jumlah} | Kategori: ${barang.kategori}',
)
```

Status pembelian menggunakan checkbox:

```dart
Checkbox(
  value: barang.sudahDibeli,
  onChanged: (_) {
    context.read<BelanjaModel>().toggle(index);
  },
)
```

Jika sudah dibeli, nama barang diberi garis coret.

Barang juga dapat dihapus menggunakan tombol delete.

---

# 16. Alur State Management

Secara keseluruhan, alur state pada aplikasi dapat digambarkan seperti berikut:

```text
             Form Input
                 ↓
          Validasi Data
                 ↓
        context.read<Model>
                 ↓
             Model
                 ↓
       notifyListeners()
                 ↓
        context.watch()
                 ↓
          Tampilan UI
```

Model menjadi tempat untuk mengatur data, sedangkan halaman bertugas menerima input dan menampilkan hasil.

---

# 17. setState dan Provider

Pada bagian awal, `setState()` masih sesuai karena state berada dalam satu halaman.

Contohnya:

```dart
setState(() {
  _jurusan = v;
});
```

Ketika aplikasi berkembang dan data digunakan oleh beberapa halaman, digunakan `ChangeNotifier` dan `Provider`.

| Kebutuhan | Teknologi |
|---|---|
| State sederhana | `setState()` |
| State terpusat | `ChangeNotifier` |
| Membagikan model | `Provider` |
| Mengikuti perubahan | `context.watch()` |
| Menjalankan method | `context.read()` |

Menurut saya, perbedaan ini merupakan salah satu bagian penting dari praktikum karena menunjukkan kapan state sederhana mulai membutuhkan pengelolaan yang lebih terstruktur.

---

# 18. Beberapa Catatan Teknis

### `List.unmodifiable()`

```dart
List<Barang> get items => List.unmodifiable(_items);
```

List yang diberikan kepada widget tidak dapat diubah secara langsung. Perubahan tetap dilakukan melalui method pada model.

### `notifyListeners()`

Method ini dipanggil setiap kali terjadi perubahan data pada model.

```dart
_items.add(...);
notifyListeners();
```

### `int.tryParse()`

Digunakan untuk mengubah input string menjadi angka dengan aman.

```dart
final jumlah = int.tryParse(v);
```

Jika input tidak berupa angka, hasilnya `null`.

### `dispose()`

Controller dibersihkan ketika halaman selesai digunakan:

```dart
@override
void dispose() {
  _nama.dispose();
  _jumlah.dispose();
  super.dispose();
}
```

---

# 19. Pengujian

Beberapa kondisi yang perlu diuji:

| Kondisi | Hasil |
|---|---|
| Nama kosong | Validasi muncul |
| Jumlah kosong | Validasi muncul |
| Jumlah berupa huruf | Ditolak |
| Jumlah `0` | Ditolak |
| Jumlah negatif | Ditolak |
| Kategori tidak dipilih | Validasi muncul |
| Semua input benar | Barang ditambahkan |
| Checkbox dicentang | Status menjadi sudah dibeli |
| Checkbox dilepas | Status kembali belum dibeli |
| Tombol hapus ditekan | Barang dihapus |
| Barang bertambah | Jumlah pada AppBar diperbarui |

Pengujian dilakukan untuk memastikan input, model, dan tampilan saling terhubung.

---

# 20. Struktur Konsep yang Dipelajari

```text
INPUT
 │
 ├── TextField
 ├── TextFormField
 ├── Dropdown
 └── Checkbox
 │
 ↓
VALIDASI
 │
 └── Form + Validator
 │
 ↓
STATE
 │
 ├── setState
 ├── ChangeNotifier
 └── Provider
 │
 ↓
UI
 │
 ├── Text
 ├── ListView
 ├── SnackBar
 └── AppBar
```

Dari praktik ini saya memahami bahwa input pengguna tidak langsung menjadi tampilan. Data perlu melewati proses validasi dan state management terlebih dahulu.

---

# 21. Hasil yang Dicapai

Pada akhir praktikum, fitur utama yang berhasil dibuat meliputi:

- input menggunakan `TextField`;
- form menggunakan `TextFormField`;
- validasi input;
- dropdown kategori;
- checkbox;
- state menggunakan `setState`;
- state menggunakan `ChangeNotifier`;
- Provider sebagai penghubung state;
- tambah data;
- ubah status data;
- hapus data;
- navigasi antar halaman;
- SnackBar;
- empty state;
- aplikasi Daftar Tugas;
- aplikasi Daftar Belanja.

---

# 22. Kesimpulan

Praktikum pertemuan ketiga memberikan pemahaman mengenai bagaimana input pengguna dikelola di dalam aplikasi Flutter.

Pada awalnya saya menggunakan `TextField` dan `setState()` untuk memahami konsep state sederhana. Setelah itu, konsep tersebut dikembangkan menggunakan `Form` dan validator supaya data yang masuk dapat diperiksa terlebih dahulu.

Pada bagian state management, `ChangeNotifier` dan `Provider` digunakan untuk memisahkan pengelolaan data dari tampilan. Hal ini diterapkan pada aplikasi Daftar Tugas dan kemudian dikembangkan menjadi Daftar Belanja.

Hal yang paling saya pahami dari praktikum ini adalah alur:

```text
Input pengguna
      ↓
Validasi
      ↓
State
      ↓
Perubahan data
      ↓
notifyListeners()
      ↓
UI diperbarui
```

Dengan memahami alur tersebut, saya menjadi lebih memahami alasan penggunaan state management dan bukan hanya mengikuti sintaks program.

---

## Checklist Praktikum

- [x] TextField
- [x] TextEditingController
- [x] Form
- [x] TextFormField
- [x] Validator
- [x] DropdownButtonFormField
- [x] Checkbox
- [x] setState
- [x] ChangeNotifier
- [x] Provider
- [x] context.watch
- [x] context.read
- [x] Navigator
- [x] Daftar Tugas
- [x] Latihan 1–4
- [x] Daftar Belanja
- [x] Validasi nama
- [x] Validasi jumlah
- [x] Validasi kategori
- [x] Fitur tambah
- [x] Fitur toggle
- [x] Fitur hapus
- [x] Perhitungan jumlah barang belum dibeli
