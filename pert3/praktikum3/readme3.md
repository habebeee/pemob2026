Praktikum Flutter Fundamental — Pertemuan 3
Mata Kuliah: Pemrograman Mobile
Praktikum: Flutter Fundamental
Pertemuan: 3
Nama: Habiburrahman
NIM: 20240801149
Prodi: Teknik Informatika

1. Ringkasan Praktikum
Pada Pertemuan 3, fokus praktikum beralih pada pengolahan input pengguna, validasi form, serta pengelolaan data yang perlu digunakan oleh lebih dari satu halaman.

Materi tidak lagi terbatas pada penyusunan antarmuka. Praktikum mulai membahas bagaimana data disimpan, diubah, dan dibagikan. Untuk state yang hanya berada pada satu halaman digunakan `setState`, sedangkan data yang digunakan lintas halaman dikelola menggunakan `ChangeNotifier` dan `Provider`.

Praktikum ini terdiri dari beberapa tahap, yaitu:

Input dasar menggunakan TextField.
Form dengan validasi.
Memahami alasan penggunaan state management.
Membuat aplikasi daftar tugas menggunakan Provider.
Mengerjakan latihan mandiri secara bertahap.
Menerapkan konsep yang sama pada tugas akhir berupa aplikasi Daftar Belanja.
Bagian terpenting dari praktikum ini adalah membedakan state lokal dengan state yang perlu dibagikan. Dengan memahami perbedaan tersebut, alur data antarhalaman menjadi lebih jelas dan penggunaan state management dapat diterapkan secara tepat.

2. Target Pembelajaran
Target pembelajaran yang digunakan pada praktikum ini meliputi:

Mengambil input pengguna menggunakan TextField dan TextEditingController.
Membuat form dengan Form, TextFormField, dropdown, dan checkbox.
Memahami keterbatasan setState ketika data digunakan oleh beberapa halaman.
Menerapkan state management dasar menggunakan ChangeNotifier dan Provider.
Membedakan penggunaan context.watch() dan context.read().
Seluruh target tersebut diterapkan secara bertahap melalui implementasi kode pada setiap bagian praktikum.

3. Persiapan Lingkungan Pengembangan
Tools yang digunakan
Flutter SDK
Visual Studio Code / editor
Emulator atau perangkat untuk menjalankan aplikasi
Dart
Package provider
Project Flutter dibuat dengan perintah:

flutter create praktikum_3
Untuk menggunakan Provider, package ditambahkan melalui terminal:

flutter pub add provider
Setelah package berhasil ditambahkan, project dapat menggunakan:

import 'package:provider/provider.dart';
4. Konsep Dasar yang Digunakan
4.1 TextField dan TextEditingController
TextField digunakan untuk menerima input berupa teks dari pengguna. Agar isi dari input tersebut dapat dibaca melalui kode, digunakan TextEditingController.

Contoh yang saya gunakan:

final _controller = TextEditingController();
Controller kemudian dipasang pada TextField:

TextField(
  controller: _controller,
  decoration: const InputDecoration(
    labelText: 'Nama',
    border: OutlineInputBorder(),
  ),
)
Isi input dapat diambil menggunakan:

_controller.text
Karena controller menggunakan resource yang perlu dikelola, controller juga harus dilepas ketika widget sudah tidak digunakan:

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
Dari implementasi ini dapat dipahami bahwa `TextEditingController` menjadi penghubung antara input pada antarmuka dan data yang dibaca oleh kode Dart.

4.2 Form dan Validasi
Jika hanya satu input, TextField sudah cukup. Tetapi jika terdapat beberapa input yang harus diperiksa sebelum data diproses, digunakan Form.

Form diberikan sebuah key:

final _formKey = GlobalKey<FormState>();
Kemudian key tersebut dipasang pada Form:

Form(
  key: _formKey,
  child: ...
)
Validasi dijalankan dengan:

_formKey.currentState!.validate()
Setiap TextFormField mempunyai validator. Jika input tidak sesuai, validator mengembalikan pesan error. Jika input benar, validator mengembalikan null.

Contohnya:

validator: (v) {
  if (v == null || v.trim().isEmpty) {
    return 'Nama wajib diisi';
  }

  return null;
}
Alur validasinya dapat diringkas sebagai berikut:

User mengisi form
        ↓
Tombol ditekan
        ↓
validate()
        ↓
Validator memeriksa setiap input
        ↓
Jika salah → tampil pesan error
Jika benar → data dapat diproses
4.3 Dropdown dan Checkbox
Pada form saya juga menggunakan dropdown untuk memilih jurusan.

DropdownButtonFormField<String>(
  ...
)
Nilai pilihan disimpan pada:

String? _jurusan;
Sementara checkbox digunakan untuk menyimpan persetujuan pengguna:

bool _setuju = false;
Tombol daftar hanya dapat digunakan ketika checkbox sudah dicentang:

onPressed: _setuju ? _kirim : null,
Bagian ini menunjukkan bahwa input pada Flutter tidak terbatas pada teks. Dropdown dan checkbox juga dapat menyimpan nilai yang digunakan sebagai bagian dari state form.

5. Implementasi Input Dasar
Pada Bagian A saya membuat halaman InputPage.

Halaman ini menggunakan:

StatefulWidget
TextField
TextEditingController
setState
ElevatedButton
Input nama disimpan melalui controller:

final _controller = TextEditingController();
Ketika tombol Sapa ditekan, nilai input digunakan untuk mengubah teks sapaan:

setState(() {
  _salam = 'Halo, ${_controller.text}!';
});
Analisis
Pada tahap ini digunakan state sederhana melalui variabel `_salam`. Ketika nilainya berubah, bagian tampilan yang bergantung pada variabel tersebut ikut diperbarui.

Karena state hanya digunakan di `InputPage`, `setState` masih cukup untuk menangani perubahan data.

Hasil yang Diharapkan
Misalnya pengguna memasukkan:

Habiburrahman
kemudian menekan tombol Sapa, maka akan muncul:

Halo, Habiburrahman!
6. Implementasi Form dan Validasi
Pada Bagian B saya membuat FormPage.

Form ini memiliki beberapa input:

Nama lengkap
Email
Jurusan
Persetujuan ketentuan
Validasi nama
Nama tidak boleh kosong:

validator: (v) =>
    (v == null || v.trim().isEmpty)
        ? 'Nama wajib diisi'
        : null,
Validasi email
Email diperiksa menggunakan karakter @:

validator: (v) {
  if (v == null || !v.contains('@')) {
    return 'Email tidak valid';
  }

  return null;
}
Validasi jurusan
Jurusan harus dipilih:

validator: (v) =>
    v == null ? 'Pilih jurusan' : null,
Checkbox
Nilai checkbox disimpan pada:

bool _setuju = false;
Tombol daftar dibuat aktif hanya jika _setuju bernilai true.

Hasil
Jika data belum benar, Flutter menampilkan pesan validasi berwarna merah.

Jika semua input valid dan checkbox sudah dicentang, data diproses dan muncul SnackBar.

Contohnya:

Terdaftar: Habiburrahman (TI)
Analisis
Validasi dilakukan sebelum data diproses. Penggunaan `Form` dan `validator` membuat pemeriksaan setiap input lebih terstruktur dan mudah dikelola.

7. Analisis Kebutuhan State Management
Bagian C menjelaskan masalah yang mulai muncul ketika data digunakan oleh beberapa halaman.

Contohnya pada aplikasi daftar tugas:

Halaman Daftar Tugas
        ↕
     Data Tugas
        ↕
Halaman Tambah Tugas
Halaman daftar menampilkan data, sedangkan halaman tambah digunakan untuk memasukkan data baru.

Jika hanya mengandalkan `setState`, pembagian data menjadi lebih rumit ketika jumlah halaman bertambah karena data perlu diteruskan melalui constructor atau callback.

Untuk mengatasi kebutuhan tersebut, digunakan satu objek state yang dapat diakses bersama oleh beberapa widget.

Pada praktikum ini, solusi yang digunakan adalah:

ChangeNotifier
      +
   Provider
8. Implementasi Daftar Tugas dengan Provider
Pada Bagian D saya membuat aplikasi sederhana Daftar Tugas.

Struktur dasarnya terdiri dari:

Tugas
  ↓
TugasModel
  ↓
ChangeNotifierProvider
  ↓
TugasPage
  ↓
TambahPage
8.1 Model Tugas
Data tugas dibuat melalui class:

class Tugas {
  String judul;
  bool selesai;

  Tugas(this.judul, {this.selesai = false});
}
Setiap tugas memiliki dua informasi utama:

judul
selesai
8.2 TugasModel
State aplikasi disimpan pada TugasModel:

class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];
}
Model ini menangani beberapa operasi utama terhadap data tugas.

Menambahkan tugas
void tambah(String judul) {
  _items.add(Tugas(judul));
  notifyListeners();
}
Mengubah status tugas
void toggle(int index) {
  _items[index].selesai = !_items[index].selesai;
  notifyListeners();
}
Menghapus tugas
void hapus(int index) {
  _items.removeAt(index);
  notifyListeners();
}
`notifyListeners()` dipanggil setiap kali data berubah agar widget yang mendengarkan model dapat membangun ulang tampilannya.

9. ChangeNotifierProvider
Agar TugasModel dapat digunakan oleh halaman lain, model diletakkan di atas widget yang membutuhkannya:

ChangeNotifierProvider(
  create: (_) => TugasModel(),
  child: const MyApp(),
)
Dengan penempatan tersebut, `TugasPage` dan `TambahPage` menggunakan instance model yang sama.

Akibatnya, data yang ditambahkan dari halaman kedua dapat langsung tercermin pada halaman daftar tanpa pengiriman data manual antarhalaman.

10. context.watch dan context.read
Dua penggunaan Provider yang saya terapkan adalah context.watch() dan context.read().

context.watch()
Pada halaman daftar:

final model = context.watch<TugasModel>();
`watch` digunakan ketika widget perlu bereaksi terhadap perubahan state.

Misalnya jumlah tugas berubah, tampilan AppBar juga perlu diperbarui.

title: Text(
  'Tugas (${model.jumlahSelesai}/${model.items.length})',
),
context.read()
Untuk menjalankan aksi, saya menggunakan:

context.read<TugasModel>().toggle(i);
dan:

context.read<TugasModel>().hapus(i);
`read` digunakan ketika widget hanya perlu menjalankan aksi pada model tanpa ikut mendengarkan perubahan state.

Analisis
Secara sederhana, perbedaannya dapat diringkas sebagai berikut:

watch → saya perlu mengetahui perubahan data

read  → saya hanya perlu menjalankan aksi terhadap data
11. Halaman Tambah Tugas
Halaman TambahPage digunakan untuk memasukkan tugas baru.

Input menggunakan:

final _controller = TextEditingController();
Ketika tombol Simpan ditekan:

final judul = _controller.text.trim();

if (judul.isEmpty) return;

context.read<TugasModel>().tambah(judul);

Navigator.pop(context);
Alurnya:

User mengetik tugas
        ↓
Tombol Simpan
        ↓
Ambil isi controller
        ↓
Cek apakah kosong
        ↓
TugasModel.tambah()
        ↓
notifyListeners()
        ↓
Kembali ke halaman daftar
        ↓
Daftar diperbarui
12. Pengembangan Fitur melalui Latihan
Setelah aplikasi daftar tugas berjalan, fitur kemudian dikembangkan secara bertahap melalui latihan mandiri.

Latihan 1 — Validasi Minimal 3 Karakter
TambahPage diubah dari TextField menjadi TextFormField.

Saya menambahkan:

final _formKey = GlobalKey<FormState>();
Kemudian validator:

validator: (v) {
  if (v == null || v.trim().length < 3) {
    return 'Judul minimal 3 karakter';
  }

  return null;
}
Dengan validasi tersebut, judul tugas yang panjangnya kurang dari tiga karakter akan ditolak.

Latihan 2 — Menghapus Semua Tugas yang Sudah Selesai
Saya menambahkan method:

void hapusSelesai() {
  _items.removeWhere((t) => t.selesai);
  notifyListeners();
}
Kemudian menambahkan tombol pada AppBar:

IconButton(
  icon: const Icon(Icons.delete_sweep),
  onPressed: () {
    context.read<TugasModel>().hapusSelesai();
  },
)
Fungsi ini memungkinkan seluruh tugas yang sudah selesai dihapus dalam satu aksi.

Latihan 3 — SnackBar
Setelah tugas berhasil ditambahkan, saya menampilkan:

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Tugas ditambahkan'),
  ),
);
SnackBar digunakan sebagai umpan balik bahwa proses penambahan data berhasil.

Latihan 4 — Empty State
Jika belum ada tugas, sebelumnya ListView tidak menampilkan apa-apa.

Saya kemudian membuat kondisi:

body: model.items.isEmpty
    ? const Center(
        child: Text('Belum ada tugas'),
      )
    : ListView.builder(
        ...
      ),
Hasilnya ketika daftar kosong akan muncul:

Belum ada tugas
Kondisi kosong menjadi lebih informatif karena pengguna mendapat pesan yang jelas ketika belum ada data.

13. Implementasi Tugas Utama — Daftar Belanja
Konsep yang telah digunakan pada latihan kemudian diterapkan pada tugas utama berupa aplikasi Daftar Belanja.

Tugas pada modul meminta aplikasi Daftar Belanja dengan:

Nama barang wajib diisi.
Jumlah wajib diisi.
Jumlah harus berupa angka lebih dari 0.
Kategori menggunakan dropdown.
Data dapat ditandai sebagai sudah dibeli.
Data dapat dihapus.
State menggunakan satu ChangeNotifier.
State dibagikan menggunakan Provider.
AppBar menampilkan jumlah barang yang belum dibeli.
14. Model Barang
Saya membuat class baru bernama Barang:

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
Setiap objek barang menyimpan empat informasi utama:

Data	Fungsi
nama	Menyimpan nama barang
jumlah	Menyimpan jumlah barang
kategori	Menyimpan kategori
sudahDibeli	Menyimpan status pembelian
15. BelanjaModel
State untuk aplikasi Daftar Belanja disimpan pada:

class BelanjaModel extends ChangeNotifier {
  final List<Barang> _items = [];
}
Jumlah barang yang belum dibeli dihitung melalui getter:

int get jumlahBelumDibeli =>
    _items.where((barang) => !barang.sudahDibeli).length;
Dengan getter tersebut, hanya barang dengan kondisi berikut yang dihitung:

sudahDibeli == false
yang dihitung.

15.1 Menambahkan Barang
Method yang digunakan:

void tambah(String nama, int jumlah, String kategori) {
  _items.add(
    Barang(
      nama,
      jumlah,
      kategori,
    ),
  );

  notifyListeners();
}
Setelah data ditambahkan, notifyListeners() dipanggil supaya halaman daftar mengetahui bahwa data sudah berubah.

15.2 Mengubah Status Barang
Checkbox menggunakan method:

void toggle(int index) {
  _items[index].sudahDibeli =
      !_items[index].sudahDibeli;

  notifyListeners();
}
Method ini membalik status pembelian: barang yang belum dibeli menjadi sudah dibeli, dan sebaliknya.

15.3 Menghapus Barang
Method hapus:

void hapus(int index) {
  _items.removeAt(index);
  notifyListeners();
}
16. Halaman Daftar Belanja
Halaman utama menggunakan:

final model = context.watch<BelanjaModel>();
Kemudian jumlah barang yang belum dibeli ditampilkan di AppBar:

title: Text(
  'Belum Dibeli (${model.jumlahBelumDibeli})',
),
Daftar barang ditampilkan menggunakan:

ListView.builder
Setiap barang mempunyai:

Checkbox
Nama barang
Jumlah
Kategori
Tombol hapus
Contoh informasi yang ditampilkan:

Beras
Jumlah: 2 | Kategori: Makanan
Jika barang dicentang, nama barang akan dicoret menggunakan:

decoration: barang.sudahDibeli
    ? TextDecoration.lineThrough
    : null,
17. Halaman Tambah Barang
Form tambah barang menggunakan:

Form(
  key: _formKey,
  ...
)
Ada tiga input utama:

Nama Barang
validator: (v) {
  if (v == null || v.trim().isEmpty) {
    return 'Nama barang wajib diisi';
  }

  return null;
}
Jumlah
Jumlah diperiksa menggunakan int.tryParse():

final jumlah = int.tryParse(v);

if (jumlah == null || jumlah <= 0) {
  return 'Jumlah harus angka lebih dari 0';
}
`int.tryParse()` digunakan agar input yang bukan angka dapat ditangani tanpa menimbulkan error saat proses konversi.

Kategori
Kategori menggunakan:

DropdownButtonFormField<String>
Pilihan yang saya buat:

Makanan
Minuman
Lainnya
Kategori wajib dipilih sebelum data dapat disimpan.

18. Proses Penyimpanan Data
Ketika tombol Simpan ditekan, form terlebih dahulu divalidasi:

if (_formKey.currentState!.validate()) {
Jika valid, data dikirim ke BelanjaModel:

context.read<BelanjaModel>().tambah(
  _nama.text.trim(),
  int.parse(_jumlah.text),
  _kategori!,
);
Setelah data berhasil dimasukkan, halaman kembali ke halaman daftar:

Navigator.pop(context);
Alur lengkapnya:

Form Tambah Barang
        ↓
User mengisi nama
        ↓
User mengisi jumlah
        ↓
User memilih kategori
        ↓
Tekan Simpan
        ↓
validate()
        ↓
Data valid?
   ↙          ↘
 Tidak        Ya
  ↓            ↓
Error       BelanjaModel
               ↓
             tambah()
               ↓
        notifyListeners()
               ↓
        Kembali ke daftar
               ↓
        Data langsung tampil
19. Urutan Proses Pengerjaan
Urutan pengerjaan praktikum secara keseluruhan dapat digambarkan sebagai berikut:

Mulai
  ↓
Mempelajari TextField
  ↓
Membuat InputPage
  ↓
Memahami TextEditingController
  ↓
Membuat FormPage
  ↓
Menambahkan validasi
  ↓
Memahami setState
  ↓
Memahami masalah state antar halaman
  ↓
Memasang Provider
  ↓
Membuat ChangeNotifier
  ↓
Membuat Daftar Tugas
  ↓
Menggunakan context.watch
  ↓
Menggunakan context.read
  ↓
Mengerjakan Latihan 1
  ↓
Mengerjakan Latihan 2
  ↓
Mengerjakan Latihan 3
  ↓
Mengerjakan Latihan 4
  ↓
Menerapkan konsep pada Daftar Belanja
  ↓
Menambahkan validasi
  ↓
Menghubungkan Form dengan Provider
  ↓
Menguji tambah, centang, dan hapus
  ↓
Selesai
20. Perbandingan Penggunaan setState dan Provider
`setState` dan `Provider` memiliki fungsi yang berbeda dan tidak selalu saling menggantikan.

setState	Provider
Cocok untuk state lokal	Cocok untuk state yang digunakan beberapa widget/halaman
Sederhana digunakan	Memerlukan model dan provider
State berada pada widget	State dapat dipusatkan pada model
Contoh: checkbox lokal	Contoh: daftar tugas dan daftar belanja
Rebuild dikelola oleh widget tersebut	Widget yang melakukan watch mengikuti perubahan model
Untuk state sederhana yang hanya digunakan pada satu halaman, `setState` masih memadai. Ketika data perlu dipakai oleh beberapa halaman, `Provider` menjadi pilihan yang lebih tepat.

21. Hasil Akhir Implementasi
Setelah seluruh tahap selesai, implementasi menghasilkan beberapa fungsi utama yang dapat diuji secara langsung.

Bagian A
Input nama melalui TextField dan menampilkan sapaan setelah tombol ditekan.

Nama
[_____________________]

[Sapa]

Halo, Habiburrahman!
Bagian B
Form pendaftaran dengan:

Nama lengkap
[_____________________]

Email
[_____________________]

Jurusan
[ Teknik Informatika ▼ ]

☐ Saya menyetujui ketentuan

[Daftar]
Jika data tidak sesuai, pesan validasi ditampilkan pada field yang bermasalah.

Daftar Tugas
Aplikasi dapat:

Menambah tugas.
Menandai tugas selesai.
Mencoret tugas selesai.
Menghapus tugas.
Menghapus seluruh tugas yang selesai.
Menampilkan jumlah tugas.
Menampilkan pesan ketika daftar kosong.
Menampilkan SnackBar setelah tugas ditambahkan.
Daftar Belanja
Aplikasi akhir dapat:

Menambahkan barang.
Memvalidasi nama barang.
Memvalidasi jumlah.
Memvalidasi kategori.
Menampilkan daftar barang.
Menandai barang sebagai sudah dibeli.
Mencoret barang yang sudah dibeli.
Menghapus barang.
Menampilkan jumlah barang yang belum dibeli.
22. Skenario Pengujian
Beberapa kondisi yang perlu diuji dari aplikasi:

Pengujian	Hasil yang Diharapkan
Nama barang dikosongkan	Muncul Nama barang wajib diisi
Jumlah dikosongkan	Muncul Jumlah wajib diisi
Jumlah diisi teks	Muncul Jumlah harus angka lebih dari 0
Jumlah diisi 0	Ditolak
Jumlah diisi angka negatif	Ditolak
Kategori tidak dipilih	Muncul pesan validasi
Data valid	Barang berhasil ditambahkan
Barang dicentang	Status berubah menjadi sudah dibeli
Barang sudah dibeli	Nama barang dicoret
Barang dihapus	Barang hilang dari daftar
Semua barang belum dibeli	Jumlah pada AppBar mengikuti jumlah barang
Daftar tugas kosong	Muncul Belum ada tugas
23. Analisis Teknis
Kenapa menggunakan List.unmodifiable()?
Pada model digunakan:

List<Barang> get items => List.unmodifiable(_items);
Data utama tetap dikelola oleh model, sedangkan halaman hanya menerima salinan list yang tidak dapat diubah secara langsung.

Dengan pendekatan tersebut, perubahan data tetap dilakukan melalui method yang disediakan oleh model, seperti:

tambah()
toggle()
hapus()
Kenapa setiap perubahan memanggil notifyListeners()?
Provider perlu menerima pemberitahuan setiap kali state berubah.

Contohnya:

void hapus(int index) {
  _items.removeAt(index);
  notifyListeners();
}
Jika data berubah tanpa `notifyListeners()`, widget yang menggunakan `context.watch()` tidak akan memperoleh pemberitahuan untuk memperbarui tampilannya.

Kenapa context.watch() digunakan di build()?
Pada halaman daftar, tampilan perlu selalu mengikuti perubahan state yang terjadi pada model.

Contohnya:

final model = context.watch<BelanjaModel>();
Ketika jumlah atau isi _items berubah, halaman akan mendapatkan perubahan tersebut dan tampilan dapat diperbarui.

Kenapa context.read() digunakan pada tombol?
Pada tombol aksi, kebutuhan utamanya hanya menjalankan method pada model.

Contohnya:

context.read<BelanjaModel>().hapus(index);
Tombol tidak perlu ikut mendengarkan perubahan state; tombol cukup mengambil model lalu menjalankan method `hapus()`.

Kenapa menggunakan ListView pada form?
Form dapat memiliki beberapa input, dan pada layar kecil kemunculan keyboard berpotensi menutup bagian bawah halaman.

Dengan `ListView`, seluruh isi form tetap dapat digulir sehingga field yang tertutup keyboard masih dapat diakses.

24. Gambaran Struktur Aplikasi
Struktur konsep aplikasi akhir dapat dipahami seperti ini:

                   ┌─────────────────────┐
                   │  BelanjaModel       │
                   │  ChangeNotifier     │
                   └─────────┬───────────┘
                             │
                    Provider │
                             ↓
              ┌──────────────┴──────────────┐
              │                             │
              ↓                             ↓
   ┌──────────────────┐          ┌──────────────────┐
   │ DaftarBelanjaPage│          │TambahBarangPage  │
   │                  │          │                  │
   │ context.watch    │          │ context.read     │
   │                  │          │ Form + Validator │
   └──────────────────┘          └──────────────────┘
              │                             │
              │                             │
              └──────────── Data ───────────┘
Dengan struktur tersebut, kedua halaman tidak perlu saling mengirim data melalui constructor. Keduanya cukup mengakses `BelanjaModel` yang sama melalui `Provider`.

25. Kesimpulan Akhir
Praktikum Pertemuan 3 menunjukkan bahwa pengembangan Flutter tidak hanya berfokus pada tampilan, tetapi juga pada bagaimana input pengguna divalidasi dan dikelola sebagai state.

Tahap awal menggunakan `TextField` dan `TextEditingController` untuk mengambil input. Setelah itu digunakan `Form` dan `validator` agar data dapat diperiksa sebelum diproses.

`setState` masih sesuai untuk state sederhana pada satu halaman. Ketika data mulai digunakan lintas halaman, state management diperlukan agar pengelolaan data tetap terstruktur.

Melalui `ChangeNotifier` dan `Provider`, data dapat dipusatkan pada satu model dan digunakan oleh beberapa halaman. `context.watch()` digunakan untuk mengikuti perubahan data, sedangkan `context.read()` digunakan untuk menjalankan aksi tanpa berlangganan pada perubahan.

Seluruh konsep tersebut kemudian diterapkan pada aplikasi Daftar Belanja yang memiliki form tambah barang dengan validasi, daftar barang, status pembelian, fungsi hapus, dan jumlah barang yang belum dibeli pada `AppBar`.

Pengerjaan secara bertahap membuat hubungan antar-konsep lebih mudah dipahami. Fitur pada aplikasi daftar tugas dikembangkan satu per satu, lalu pola yang sama diterapkan kembali pada aplikasi Daftar Belanja.

26. Ringkasan Capaian
 Memahami TextField
 Menggunakan TextEditingController
 Melakukan dispose() pada controller
 Membuat Form
 Menggunakan TextFormField
 Membuat validasi input
 Menggunakan dropdown
 Menggunakan checkbox
 Memahami setState
 Memahami ChangeNotifier
 Memasang Provider
 Menggunakan context.watch()
 Menggunakan context.read()
 Membuat aplikasi Daftar Tugas
 Menambahkan validasi minimal 3 karakter
 Menambahkan fitur hapus tugas selesai
 Menambahkan SnackBar
 Menambahkan empty state
 Membuat aplikasi Daftar Belanja
 Membuat validasi nama barang
 Membuat validasi jumlah
 Membuat validasi kategori
 Menggunakan ChangeNotifier untuk state Daftar Belanja
 Menggunakan Provider
 Menambahkan fitur centang barang
 Menambahkan fitur hapus barang
 Menampilkan jumlah barang yang belum dibeli
Referensi Modul
Materi utama README ini disusun berdasarkan:

Modul Praktikum Flutter Fundamental — Pertemuan 3: Form Input dan State Management

Referensi yang tercantum pada modul:

Flutter — Forms: docs.flutter.dev/cookbook/forms
Flutter — State Management: docs.flutter.dev/data-and-backend/state-mgmt
Provider Package: pub.dev/packages/provider