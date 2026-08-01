# Finara — Master Prompt Pengembangan Aplikasi

> Dokumen ini merupakan versi terstruktur dan telah diaudit dari spesifikasi Finara. Aturan bisnis, rumus, roadmap fase, keamanan, pembagian investasi lintas platform, serta pemisahan rencana dan realisasi telah diselaraskan agar dapat diimplementasikan secara deterministik.

## Ringkasan Ruang Lingkup

- **Platform:** Android dan iOS
- **Orientasi utama:** portrait, mobile-first, dan responsif
- **Bahasa antarmuka:** Bahasa Indonesia
- **Model data MVP:** local-first, tanpa login dan tanpa backend wajib
- **Batasan transaksi:** Finara hanya menghitung, mencatat, dan memberikan instruksi manual; Finara tidak melakukan transfer, top-up otomatis, pembelian investasi, penjualan aset, atau pengiriman order saham
- **AI:** API key, provider, dan model dikonfigurasi sendiri oleh pengguna
- **Prinsip desain:** satu halaman, satu tujuan utama

## Aturan Konsistensi Global

Gunakan aturan berikut pada seluruh modul:

1. **Satu nominal hanya boleh memiliki satu sumber anggaran aktif pada satu periode.** Pengeluaran, langganan, transaksi terjadwal, atau realisasi tidak boleh sekaligus dibiayai dari Kantong Pengeluaran Wajib Bank Jago, Alokasi Bank Jago dari Dana Bersih, dan Alokasi DANA.
2. **Bedakan sumber anggaran dan kanal pembayaran.** Sumber anggaran menunjukkan dari pos mana nominal dibiayai; kanal pembayaran menunjukkan media eksekusi seperti Bank Jago, DANA, tunai, atau transfer bank lain. Pemindahan antarplatform bukan pengeluaran baru.
3. **Pisahkan rencana dan realisasi.** Nilai hasil perhitungan Finara adalah rencana; nilai aktual hanya berasal dari input pengguna atau laporan yang telah dikonfirmasi.
4. **Sebutkan basis setiap persentase.** Bedakan persentase terhadap Total Pendapatan, Dana Bersih, dan total internal suatu platform.
5. **Jangan menampilkan data sebagai aktual atau real-time tanpa sumber aktual.** Jika data realisasi tidak tersedia, gunakan label seperti *rencana*, *anggaran*, atau *estimasi*.
6. **Fitur mengikuti fase pengembangan.** Menu, tombol, parser, format impor, dan acceptance criteria yang belum tersedia pada fase aktif harus disembunyikan atau diberi label *Belum tersedia*; jangan menampilkan kontrol yang tidak berfungsi.
7. **Nilai yang tidak tersedia disimpan sebagai `null`.** Label **Tidak tersedia** hanya digunakan pada antarmuka atau ekspor untuk pengguna. Jangan mengubah nilai yang tidak diketahui menjadi nol karena nol merupakan nilai yang valid.
8. **Gunakan satu istilah kanonik.** Istilah utama adalah **Total Pendapatan**, **Dana Bersih**, **Alokasi Bank Jago dari Dana Bersih**, **Total Dana Masuk ke Bank Jago**, **Total Alokasi Investasi**, **Alokasi Bibit**, **Alokasi Stockbit**, **Saldo DANA Biasa**, dan **Saldo DANA+**.
9. **Riwayat keuangan bersifat berversi.** Perubahan terhadap bulan yang telah dikonfirmasi menghasilkan revisi baru dan tidak boleh diam-diam mengubah dasar rekonsiliasi historis.
10. **Gunakan pembagian investasi dua tingkat.** Dana Bersih dibagi terlebih dahulu ke Bank Jago, Total Alokasi Investasi, dan DANA. Total Alokasi Investasi kemudian dibagi ke Bibit dan Stockbit. Transfer ke RDN dan pembelian saham tidak boleh dihitung sebagai dua kontribusi yang berbeda.
11. **Invarian nominal rencana awal harus selalu dipenuhi setelah pembulatan:**

```text
Total Pendapatan =
Penghasilan Utama
+ Total Penghasilan Tambahan yang Diaktifkan pada Bulan Aktif
```

```text
Dana Bersih =
Total Pendapatan
- Kas Pegangan BRImo
- Total Pengeluaran Wajib
```

```text
Kas Pegangan BRImo
+ Total Dana Masuk ke Bank Jago
+ Total Alokasi Investasi
+ Alokasi DANA
= Total Pendapatan
```

```text
Total Alokasi Investasi
= Alokasi Bibit
+ Alokasi Stockbit
```

```text
Total Dana Masuk ke Bank Jago
= Total Pengeluaran Wajib
+ Alokasi Bank Jago dari Dana Bersih
```

Invarian tersebut berlaku pada **rencana awal alokasi bulan aktif**. Setelah pengguna melakukan pembayaran atau pemindahan saldo, saldo aktual rekening dapat berubah dan harus dicatat sebagai realisasi terpisah.

## Glosarium Istilah Utama

- **Total Pendapatan:** Penghasilan Utama ditambah seluruh Penghasilan Tambahan yang diaktifkan untuk bulan aktif.
- **Dana Bersih:** sisa Total Pendapatan setelah Kas Pegangan BRImo dan Total Pengeluaran Wajib dikurangi.
- **Total Alokasi Investasi:** bagian Dana Bersih yang dialokasikan untuk seluruh platform investasi aktif sebelum dibagi secara internal.
- **Alokasi Bibit:** bagian Total Alokasi Investasi yang direncanakan untuk Bibit.
- **Alokasi Stockbit:** bagian Total Alokasi Investasi yang direncanakan untuk Stockbit.
- **Rekening Dana Nasabah (RDN):** rekening dana yang digunakan dalam alur pendanaan investasi saham; saldo RDN, transfer ke RDN, dan pembelian saham harus dicatat sebagai kejadian yang berbeda.
- **Sumber Anggaran:** pos yang membiayai suatu pengeluaran, misalnya Kantong Pengeluaran Wajib, Alokasi Bank Jago, atau Alokasi DANA.
- **Kanal Pembayaran:** media yang digunakan untuk membayar, misalnya Bank Jago, DANA, tunai, atau transfer bank lain.
- **Rencana:** nominal hasil perhitungan Finara yang belum dikonfirmasi sebagai pelaksanaan aktual.
- **Realisasi:** transaksi atau saldo periode berjalan yang dimasukkan pengguna atau berasal dari laporan yang telah dikonfirmasi.
- **Estimasi:** nilai simulasi yang bergantung pada asumsi dan bukan data aktual.
- **Saldo DANA Biasa:** bagian Alokasi DANA yang disiapkan untuk transaksi terdekat.
- **Saldo DANA+:** bagian Alokasi DANA yang sementara ditempatkan pada DANA+ dan tetap diklasifikasikan sebagai anggaran DANA.

## 0. Instruksi Utama

Buatkan aplikasi mobile Android dan iOS bernama **Finara**, sebuah aplikasi pengelolaan dan alokasi keuangan pribadi yang modern, simpel, intuitif, aman, dan responsif.

Finara membantu pengguna membagi penghasilan bulanan secara otomatis ke kas pegangan, pengeluaran wajib, dana darurat, investasi, langganan digital, dan uang jajan. Aplikasi juga memiliki chatbot AI bernama **Finara AI** yang dapat digunakan untuk bertanya tentang pengelolaan keuangan.

Gunakan **Bahasa Indonesia** pada seluruh antarmuka aplikasi.

## Daftar Modul

1. **Fondasi Produk** — Menetapkan identitas, tujuan, batasan produk, platform keuangan, dan disclaimer utama. *(mencakup bagian asli: 1, 2, 3, 58)*
2. **Desain, Navigasi, dan Aksesibilitas** — Mendefinisikan sistem visual, pengalaman pengguna, struktur navigasi, serta perilaku responsif aplikasi. *(mencakup bagian asli: 4, 5, 6, 7, 8, 9, 56, 57)*
3. **Mesin Alokasi Keuangan** — Mencakup input finansial, rumus alokasi, preset, pembulatan, hasil, visualisasi, dan checklist eksekusi manual. *(mencakup bagian asli: 10–21)*
4. **Riwayat, Progres, Simulasi, dan Utilitas** — Mengatur pemantauan kondisi keuangan, evaluasi berkala, pengingat, serta ekspor data. *(mencakup bagian asli: 22, 23, 24, 25, 49, 50)*
5. **Finara AI dan Sistem Multi-Model** — Mendefinisikan chatbot, konfigurasi provider, model discovery, keamanan konteks, biaya, fallback, dan error handling. *(mencakup bagian asli: 26–48)*
6. **Keamanan, Data, Validasi, dan Arsitektur** — Menetapkan keamanan aplikasi, format data, validasi lintas modul, penyimpanan lokal, dan pemisahan tanggung jawab teknis. *(mencakup bagian asli: 51–55)*
7. **Prioritas Pengembangan dan Quality Assurance** — Menentukan cakupan MVP, strategi pengujian, dan kriteria penerimaan hasil akhir. *(mencakup bagian asli: 59–61)*
8. **Modul Impor Laporan Investasi Bibit** — Mencakup impor dokumen, parsing, validasi, rekonsiliasi, privasi, arsitektur, roadmap, dan integrasi AI untuk data investasi aktual. *(mencakup bagian asli: 62–85)*
9. **Modul Pembagian Saldo DANA dan DANA+** — Memperluas alokasi DANA menjadi saldo transaksi dan saldo DANA+, termasuk rekomendasi, realisasi, simulasi reward, arsitektur, dan pengujian. *(mencakup bagian asli: 86–100)*
10. **Modul Pembagian Investasi Bibit dan Stockbit** — Mengubah investasi menjadi kategori induk, membagi target antarplatform, memisahkan transfer RDN dari pembelian saham, serta mengatur realisasi, impor, rekonsiliasi, privasi, arsitektur, dan pengujian Stockbit. *(mencakup bagian: 101–125)*

---

## Bagian I — Fondasi Produk

> Menetapkan identitas, tujuan, batasan produk, platform keuangan, dan disclaimer utama.

### 1. Identitas Aplikasi

- Nama aplikasi: **Finara**
- Tagline: **Setiap rupiah punya arah.**
- Deskripsi singkat: **Finara membantu mengatur penghasilan, pengeluaran, tabungan, investasi, dan tujuan keuangan dalam satu aplikasi.**

Gunakan nama Finara secara konsisten pada:

- Splash screen
- Onboarding
- App bar
- Halaman Tentang
- Disclaimer
- Notifikasi
- Laporan PDF
- Riwayat ekspor
- Chatbot AI
- Metadata aplikasi

Jangan menggunakan nama **Hybrid Financial Allocator**.

### 2. Tujuan Aplikasi

Finara berfungsi untuk:

- Menghitung alokasi penghasilan bulanan
- Mengurangi pengeluaran wajib sebelum membagi dana
- Mengatur kas pegangan
- Membantu membangun dana darurat
- Mengatur porsi investasi
- Membagi uang jajan mingguan atau harian
- Mengelola langganan digital
- Menampilkan checklist transfer manual
- Menyimpan riwayat keuangan
- Menampilkan perkembangan dan target keuangan
- Memberikan simulasi keuangan
- Menyediakan chatbot AI untuk konsultasi dan edukasi keuangan

Finara tidak melakukan transfer uang secara otomatis dan tidak terhubung langsung ke rekening bank atau platform investasi secara default.

### 3. Platform Keuangan Utama

#### BRImo

Digunakan untuk:

- Menerima penghasilan
- Menyimpan kas pegangan
- Menyediakan dana yang dapat ditarik melalui ATM

#### Bank Jago

Digunakan untuk:

- Menyimpan seluruh dana pengeluaran wajib pada **Kantong Pengeluaran Wajib**
- Menyimpan dana darurat
- Menyimpan dana langganan digital yang tidak dicatat sebagai pengeluaran wajib
- Menyimpan dana operasional tambahan
- Menjadi pusat pengelolaan dana berbasis kantong setelah dana diterima dari BRImo

BRImo tetap menjadi rekening penerima penghasilan dan sumber awal transfer manual. Bank Jago tidak disebut sebagai pusat distribusi ke platform investasi dan DANA kecuali pengguna memang memilih alur tersebut.

Dana pengeluaran wajib disimpan secara terpisah dari alokasi Bank Jago berbasis persentase. Nominal pengeluaran wajib tidak termasuk dalam pembagian persentase Bank Jago, Total Alokasi Investasi, dan DANA.

#### Bibit

Digunakan untuk:

- Investasi reksa dana
- Obligasi
- Saham, jika produk tersedia bagi pengguna
- Pencatatan investasi

#### Stockbit

Digunakan untuk:

- Perencanaan kontribusi investasi saham
- Pencatatan transfer manual ke RDN
- Pencatatan pembelian dan penjualan saham
- Pencatatan saldo kas investasi, biaya transaksi, dividen, serta nilai portofolio
- Rekonsiliasi target kontribusi dan realisasi pendanaan

Bibit dan Stockbit merupakan sub-platform dari **Total Alokasi Investasi**. Finara hanya menghitung dan mencatat nominal. Finara tidak melakukan top-up, pembelian, penjualan, atau pengiriman order investasi.

#### DANA

Digunakan untuk:

- Uang jajan
- QRIS
- Transaksi kecil
- Pengeluaran harian atau mingguan

### 58. Disclaimer

Tampilkan:

> Finara membantu melakukan simulasi dan perencanaan keuangan. Finara bukan bank, bukan penasihat keuangan, dan tidak menjamin keuntungan investasi. Selalu periksa kembali informasi sebelum mengambil keputusan keuangan.

Untuk Finara AI:

> Jawaban AI dapat tidak akurat. Periksa kembali informasi penting sebelum mengambil keputusan. Penggunaan API dan biaya mengikuti penyedia AI yang dipilih pengguna.

---

## Bagian II — Desain, Navigasi, dan Aksesibilitas

> Mendefinisikan sistem visual, pengalaman pengguna, struktur navigasi, serta perilaku responsif aplikasi.

### 4. Desain UI dan UX

Gunakan desain yang:

- Modern
- Simpel
- Bersih
- Minimalis
- Responsif
- Tidak terasa padat
- Mudah digunakan pengguna awam
- Dioptimalkan untuk layar ponsel portrait
- Mobile-first

Hindari tampilan dashboard desktop yang diperkecil.

#### Gaya Visual

Gunakan token desain adaptif:

- Rounded corner setara 16–24 dp pada Android atau 16–24 pt pada iOS
- Card dengan bayangan sangat ringan
- Jarak antarelemen yang konsisten
- Ikon sederhana
- Tipografi jelas
- Warna lembut dengan kontras yang baik
- Animasi transisi singkat dan halus
- Skeleton loading
- Empty state informatif
- Error state yang mudah dipahami

Hindari:

- Terlalu banyak warna pada satu halaman
- Gradient berlebihan
- Border tebal
- Teks terlalu kecil
- Card terlalu penuh
- Animasi yang mengganggu
- Tombol kecil
- Tabel horizontal

Area sentuh minimum:

- Android: minimal 48 × 48 dp
- iOS: minimal 44 × 44 pt

Jangan menggunakan pixel fisik sebagai satuan layout lintas platform.

#### Layout

Gunakan:

- Safe area
- Vertical scrolling
- Sticky primary button pada halaman input panjang
- Bottom sheet untuk opsi tambahan
- Responsive spacing
- Keyboard-safe layout
- Input tidak tertutup keyboard
- Layout adaptif, bukan ukuran hard-coded

### 5. Sistem Warna

#### Warna Utama Finara

- Primary: hijau gelap atau emerald
- Secondary: hijau muda
- Background light: putih keabu-abuan
- Background dark: abu-abu sangat gelap
- Text primary: hampir hitam
- Text secondary: abu-abu
- Success: hijau
- Warning: amber
- Error: merah
- Information: biru

#### Warna Platform

Gunakan hanya sebagai aksen card:

- BRImo: biru tua
- Bank Jago: oranye
- Bibit: hijau
- Stockbit: biru kehijauan
- DANA: biru muda

Jangan menggunakan seluruh warna platform sebagai background halaman.

### 6. Tema dan Tipografi

Sediakan:

- Light mode
- Dark mode
- Ikuti tema sistem

Gunakan font modern seperti:

- Inter
- Manrope
- Plus Jakarta Sans
- Font sistem perangkat

Gunakan token tipografi adaptif. Nilai acuan desain:

- Heading utama: setara 24–28 sp pada Android atau pt pada iOS
- Heading section: setara 18–20 sp atau pt
- Body: setara 14–16 sp atau pt
- Caption: minimal setara 12 sp atau pt
- Nominal utama: setara 24–32 sp atau pt

Ukuran akhir harus mengikuti text scaling perangkat, tidak terpotong, dan tetap mempertahankan hierarki visual. Nominal keuangan harus lebih menonjol daripada label.

### 7. Splash Screen dan Onboarding

#### Splash Screen

Tampilkan:

- Logo Finara
- Nama Finara
- Tagline “Setiap rupiah punya arah.”
- Background sederhana
- Animasi ringan

#### Onboarding

Maksimal empat halaman. Konten onboarding harus mengikuti fase aktif.

##### Halaman 1

**Atur penghasilan dengan lebih terarah**

Finara membantu membagi penghasilan ke kebutuhan, tabungan, investasi, dan uang jajan.

##### Halaman 2

**Bangun dana darurat**

Tentukan target dan pantau perkembangan dana darurat setiap bulan.

##### Halaman 3 — mulai Fase 2

**Dapatkan bantuan dari AI**

Tanyakan hasil alokasi dan pelajari strategi keuangan melalui Finara AI.

Halaman ini disembunyikan pada Fase 1.

##### Halaman 4

**Data tetap dalam kendali Anda**

Data disimpan secara aman dan tidak terhubung langsung ke rekening bank.

Tombol:

- Lewati
- Berikutnya
- Mulai Gunakan Finara

### 8. Navigasi Utama

Navigasi harus mengikuti fase aktif.

#### Fase 1

Gunakan bottom navigation dengan empat menu:

1. Beranda
2. Hitung
3. Progres
4. Riwayat

Pada Fase 1, menu Progres hanya menampilkan progres dana darurat, checklist, dan metrik yang datanya sudah tersedia.

#### Mulai Fase 2

Gunakan bottom navigation dengan lima menu:

1. Beranda
2. Hitung
3. Finara AI
4. Progres
5. Riwayat

Menu Pengaturan diakses melalui ikon profil atau ikon pengaturan di kanan atas. Gunakan ikon dan label teks. Menu dari fase yang belum aktif harus disembunyikan, bukan ditampilkan sebagai tombol kosong.

### 9. Halaman Beranda

Tampilkan informasi berdasarkan data dan fase yang tersedia:

- Sapaan pengguna
- Bulan aktif
- Total Pendapatan
- Total Pengeluaran Wajib
- Total Rencana Alokasi, termasuk Kas Pegangan BRImo
- Progres checklist
- Progres dana darurat
- Investasi Direncanakan bulan ini
- Investasi Aktual bulan ini, hanya jika tersedia
- Sisa anggaran uang jajan, hanya jika data realisasi tersedia
- Financial Health Score, mulai fase yang mendukung skor dan jika data minimum tersedia
- Pengingat terdekat
- Tombol **Hitung Alokasi**
- Tombol **Tanya Finara AI**, mulai Fase 2

Prioritaskan maksimal empat informasi utama pada layar pertama. Jangan menampilkan **uang jajan tersisa**, **investasi aktual**, atau skor sebagai data faktual apabila sumber realisasi belum tersedia.

### 56. Responsive Behavior

Pastikan:

- Responsif pada berbagai ukuran layar
- Tidak overflow
- Tidak ada teks terpotong
- Tidak ada tombol keluar layar
- Tetap nyaman saat keyboard terbuka
- Mendukung ukuran font perangkat
- Mendukung safe area
- Dioptimalkan untuk portrait
- Tetap usable pada layar kecil
- Memiliki batas maksimum lebar konten pada layar besar

Gunakan layout adaptif.

### 57. Aksesibilitas

Pastikan:

- Kontras warna baik
- Tombol memiliki label
- Ikon memiliki accessibility description
- Warna bukan satu-satunya indikator
- Font menyesuaikan pengaturan perangkat
- Screen reader dapat membaca nominal dan label

---

## Bagian III — Mesin Alokasi Keuangan

> Mencakup input finansial, rumus alokasi, preset, pembulatan, hasil, visualisasi, dan checklist eksekusi manual.

### 10. Input Penghasilan

#### Penghasilan Utama

- Wajib diisi
- Keyboard numeric
- Format Rupiah otomatis
- Tidak boleh nol atau negatif

#### Penghasilan Tambahan

Pengguna dapat menambahkan:

- Bonus
- Freelance
- Komisi
- Pendapatan usaha
- Uang saku
- Lainnya

Setiap item memiliki:

- Nama
- Nominal
- Status rutin atau tidak rutin
- Status **Sertakan pada bulan aktif**
- Bulan atau periode pencatatan

Penghasilan tambahan yang tidak rutin hanya masuk ke Total Pendapatan apabila pengguna mengaktifkannya untuk bulan tersebut.

```text
Total Pendapatan =
Penghasilan Utama
+ Total Penghasilan Tambahan yang Diaktifkan pada Bulan Aktif
```

Gunakan istilah **Total Pendapatan** pada UI, rumus, database, ekspor, dan konteks AI. Istilah **penghasilan** tetap dapat digunakan sebagai nama jenis input.

#### Kas Pegangan BRImo

- Default Rp300.000
- Dapat diubah
- Tidak boleh melebihi Total Pendapatan

### 11. Pengeluaran Wajib

Kategori default:

- Kos atau kontrakan
- Cicilan
- Makanan
- Transportasi
- Listrik
- Air
- Internet
- Pulsa
- Pendidikan
- Kebutuhan keluarga
- Asuransi
- Lainnya

Setiap item memiliki:

- ID
- Nama
- Kategori
- Nominal
- Tanggal jatuh tempo
- Status rutin
- Jenis nominal: tetap atau variabel
- Status kebutuhan pokok
- Status dihitung dalam dasar dana darurat
- Kanal pembayaran: Bank Jago, DANA, tunai, transfer bank lain, atau lainnya
- Sumber anggaran aktif
- Periode aktif
- Edit
- Hapus

Tampilkan total pengeluaran wajib secara otomatis.

#### Sumber Anggaran dan Kanal Pembayaran

Gunakan dua field terpisah:

- **Sumber anggaran:** Kantong Pengeluaran Wajib Bank Jago.
- **Kanal pembayaran:** Bank Jago, DANA, tunai, transfer bank lain, atau lainnya.

Pemindahan dana dari Kantong Pengeluaran Wajib ke DANA, tunai, atau bank lain tetap merupakan pemindahan internal untuk membayar kewajiban dan tidak dicatat sebagai pengeluaran kedua.

#### Lokasi Penyimpanan Pengeluaran Wajib

Seluruh uang untuk pengeluaran wajib harus dialokasikan ke **Kantong Pengeluaran Wajib di Bank Jago**.

Ketentuan:

- Pengeluaran wajib dipisahkan dari Kas Pegangan BRImo.
- Pengeluaran wajib dipindahkan secara manual dari BRImo ke Kantong Pengeluaran Wajib Bank Jago.
- Nominal ini tidak termasuk dalam persentase alokasi Bank Jago, Total Alokasi Investasi, dan DANA.
- Finara hanya menghitung nominal dan menampilkan instruksi transfer; Finara tidak memindahkan uang secara otomatis.
- Setiap pengeluaran atau langganan hanya boleh menggunakan satu sumber anggaran pada periode yang sama.
- Jika pengeluaran wajib dibayar melalui DANA, dananya tetap berasal dari Kantong Pengeluaran Wajib Bank Jago lalu dipindahkan secara manual ke DANA saat dibutuhkan. Nominal tersebut tidak dihitung lagi sebagai uang jajan.
- Jika dibayar tunai, melalui BRImo, atau melalui bank lain, tampilkan instruksi pemindahan yang sesuai dan tandai sebagai pemindahan internal dari Kantong Pengeluaran Wajib.
- Kategori seperti makanan dan transportasi dapat ditetapkan sebagai Pengeluaran Wajib atau Uang Jajan DANA, tetapi tidak boleh aktif pada kedua sumber anggaran dalam periode yang sama.

### 12. Urutan Perhitungan dan Aliran Dana

#### Tahap 0 — Hitung Total Pendapatan

```text
Total Pendapatan =
Penghasilan Utama
+ Total Penghasilan Tambahan yang Diaktifkan pada Bulan Aktif
```

#### Tahap 1 — Hitung Dana Bersih

```text
Dana Bersih =
Total Pendapatan
- Kas Pegangan BRImo
- Total Pengeluaran Wajib
```

Dana Bersih tidak boleh negatif.

#### Tahap 2 — Bagi Dana Bersih ke Kategori Utama

Dana Bersih dibagi berdasarkan preset atau persentase custom ke:

- Alokasi Bank Jago dari Dana Bersih
- Total Alokasi Investasi
- Alokasi DANA

Total persentase ketiga kategori utama tersebut wajib tepat 100%.

```text
Dana Bersih =
Alokasi Bank Jago dari Dana Bersih
+ Total Alokasi Investasi
+ Alokasi DANA
```

#### Tahap 3 — Bagi Total Alokasi Investasi

Total Alokasi Investasi dibagi secara internal ke:

- Alokasi Bibit
- Alokasi Stockbit

```text
Total Alokasi Investasi =
Alokasi Bibit
+ Alokasi Stockbit
```

Total persentase internal investasi wajib tepat 100%. Jika Stockbit dinonaktifkan, gunakan Bibit 100% dan Stockbit 0%. Jika Bibit dinonaktifkan, gunakan Bibit 0% dan Stockbit 100%. Setidaknya satu platform investasi harus aktif apabila Total Alokasi Investasi lebih dari nol.

#### Tahap 4 — Hitung Total Dana Masuk ke Bank Jago

```text
Total Dana Masuk ke Bank Jago =
Total Pengeluaran Wajib
+ Alokasi Bank Jago dari Dana Bersih
```

Di dalam Bank Jago, dana dipisahkan menjadi:

1. **Kantong Pengeluaran Wajib** — berisi Total Pengeluaran Wajib bulan berjalan.
2. **Kantong Alokasi Bank Jago** — berisi bagian Bank Jago dari Dana Bersih untuk dana darurat, langganan yang tidak termasuk Pengeluaran Wajib, dan operasional tambahan.

Untuk meminimalkan langkah transfer, alur default menggunakan satu transfer dari BRImo sebesar **Total Dana Masuk ke Bank Jago**, kemudian dana dibagi ke kantong internal Bank Jago. Pengguna tetap dapat memilih transfer terpisah apabila diperlukan.

#### Tahap 5 — Buat Instruksi Berdasarkan Kanal Pembayaran dan Tujuan Investasi

Untuk setiap Pengeluaran Wajib, buat instruksi manual sesuai kanal:

- Bank Jago: bayar langsung dari Kantong Pengeluaran Wajib.
- DANA: pindahkan nominal kewajiban dari Kantong Pengeluaran Wajib ke DANA dan tandai sebagai dana wajib.
- Tunai: tarik atau pindahkan nominal dari Kantong Pengeluaran Wajib sesuai kebutuhan.
- Transfer bank lain: pindahkan nominal dari Kantong Pengeluaran Wajib ke rekening tujuan.

Untuk investasi:

- Bibit: tampilkan target top-up atau pembelian manual sesuai Alokasi Bibit.
- Stockbit: tampilkan target transfer ke RDN sesuai Alokasi Stockbit, lalu pisahkan pencatatan transfer, saldo RDN, pembelian, penjualan, dan biaya transaksi.

Pemindahan tersebut tidak mengubah nilai rencana awal dan tidak boleh dihitung sebagai pengeluaran atau kontribusi kedua.

#### Invarian Aliran Dana Rencana Awal

```text
Kas Pegangan BRImo
+ Total Dana Masuk ke Bank Jago
+ Total Alokasi Investasi
+ Alokasi DANA
= Total Pendapatan
```

```text
Total Alokasi Investasi
= Alokasi Bibit
+ Alokasi Stockbit
```

```text
Total Dana Masuk ke Bank Jago
= Total Pengeluaran Wajib
+ Alokasi Bank Jago dari Dana Bersih
```

Jangan membagi persentase langsung dari Total Pendapatan sebelum Kas Pegangan BRImo dan Total Pengeluaran Wajib dikurangi. Jangan menghitung Pengeluaran Wajib kembali sebagai bagian dari Alokasi Bank Jago berbasis persentase. Jangan menghitung transfer ke RDN dan pembelian saham sebagai dua kontribusi investasi.

### 13. Preset Alokasi

Setiap preset memiliki dua tingkat: pembagian Dana Bersih dan pembagian internal Total Alokasi Investasi.

#### Standard Hybrid

Pembagian Dana Bersih:

- Bank Jago: 40%
- Total Alokasi Investasi: 30%
- DANA: 30%

Pembagian internal investasi default:

- Bibit: 70%
- Stockbit: 30%

#### Investor Fokus

Pembagian Dana Bersih:

- Bank Jago: 25%
- Total Alokasi Investasi: 50%
- DANA: 25%

Pembagian internal investasi default:

- Bibit: 50%
- Stockbit: 50%

#### Pelajar atau Mahasiswa

Pembagian Dana Bersih:

- Bank Jago: 45%
- Total Alokasi Investasi: 15%
- DANA: 40%

Pembagian internal investasi default:

- Bibit: 80%
- Stockbit: 20%

#### Konservatif

Pembagian Dana Bersih:

- Bank Jago: 60%
- Total Alokasi Investasi: 20%
- DANA: 20%

Pembagian internal investasi default:

- Bibit: 85%
- Stockbit: 15%

#### Custom

Pengguna dapat mengatur:

1. Persentase Bank Jago, Total Alokasi Investasi, dan DANA terhadap Dana Bersih.
2. Persentase Bibit dan Stockbit terhadap Total Alokasi Investasi.

Gunakan slider dan input angka. Total persentase pada setiap tingkat wajib tepat 100%.

Indikator:

- Kurang dari 100%: merah
- Tepat 100%: hijau
- Lebih dari 100%: merah

Tombol hitung dinonaktifkan jika pembagian tingkat utama atau pembagian internal investasi belum valid. Preset merupakan alat perencanaan, bukan rekomendasi aset atau jaminan hasil.

### 14. Sub-Alokasi Bank Jago

Sub-alokasi pada bagian ini hanya diterapkan pada **Alokasi Bank Jago dari Dana Bersih**. Sub-alokasi ini tidak mencakup dana pada Kantong Pengeluaran Wajib.

Sediakan dua metode.

#### Metode Persentase Tetap

- 10% untuk langganan digital yang tidak dicatat sebagai Pengeluaran Wajib
- 50% untuk dana darurat
- 40% untuk dana operasional tambahan

Total persentase internal wajib tepat 100%.

#### Metode Berdasarkan Langganan Aktual

Kantong Langganan mengikuti kebutuhan pendanaan langganan aktif yang sumber anggarannya adalah **Kantong Langganan dari Alokasi Bank Jago**.

```text
Kebutuhan Langganan Bulan Aktif =
Total Kontribusi Langganan Bulanan
+ Total Tagihan Bayar Saat Jatuh Tempo pada Bulan Aktif
```

```text
Sisa Setelah Langganan =
Alokasi Bank Jago dari Dana Bersih
- Kebutuhan Langganan Bulan Aktif
```

Sisa dibagi menggunakan rasio dasar dana darurat dan operasional sebesar 5:4:

```text
Dana Darurat =
Sisa Setelah Langganan × 5 / 9
```

```text
Dana Operasional Tambahan =
Sisa Setelah Langganan
- Dana Darurat
```

Dana Operasional Tambahan menjadi komponen residual setelah pembulatan internal.

Ketentuan:

- Langganan yang dicatat sebagai Pengeluaran Wajib dibiayai dari Kantong Pengeluaran Wajib.
- Langganan tersebut tidak boleh dimasukkan kembali ke Kantong Langganan dari Alokasi Bank Jago.
- Setiap langganan wajib memiliki satu sumber anggaran aktif.
- Jika Kebutuhan Langganan Bulan Aktif melebihi Alokasi Bank Jago dari Dana Bersih, hasil tidak boleh disimpan. Minta pengguna mengubah sumber anggaran, mengurangi langganan, atau mengubah persentase alokasi.
- Peringatan saja tidak cukup apabila perhitungan menghasilkan Sisa Setelah Langganan negatif.

### 15. Langganan Digital

Gunakan satu record `Subscription` sebagai sumber data utama. Jika langganan dibiayai sebagai Pengeluaran Wajib, `MandatoryExpense` harus mereferensikan record tersebut dan tidak membuat salinan nominal kedua.

Setiap langganan memiliki:

- ID
- Nama layanan
- Nominal atau biaya tahunan
- Tanggal tagihan
- Siklus bulanan atau tahunan
- Status aktif
- Pengingat
- Metode pendanaan
- Saldo cadangan awal, jika memakai cadangan bulanan
- Sumber anggaran:
  - Kantong Pengeluaran Wajib Bank Jago
  - Kantong Langganan dari Alokasi Bank Jago

Satu langganan hanya boleh menggunakan satu sumber anggaran pada satu periode.

#### Langganan Bulanan

```text
Kebutuhan Bulan Aktif = Nominal Bulanan
```

#### Langganan Tahunan

Pengguna memilih salah satu metode:

1. **Cadangan bulanan** — menyisihkan biaya tahunan secara bertahap.
2. **Bayar saat jatuh tempo** — mengalokasikan biaya penuh hanya pada bulan pembayaran.

Untuk metode Cadangan Bulanan:

```text
Kontribusi Cadangan Bulanan =
Biaya Tahunan / 12
```

Karena format Rupiah tidak menggunakan desimal, distribusikan sisa pembagian integer ke kontribusi terakhir sebelum tanggal jatuh tempo.

```text
Saldo Cadangan Akhir =
Saldo Cadangan Awal
+ Kontribusi Cadangan Bulan Ini
- Pembayaran dari Cadangan Bulan Ini
```

Pada bulan jatuh tempo, pembayaran diambil dari Saldo Cadangan. Pembayaran tersebut tidak boleh kembali dibebankan penuh sebagai kebutuhan baru apabila cadangan telah mencukupi.

Untuk metode Bayar Saat Jatuh Tempo:

```text
Tagihan Jatuh Tempo Bulan Ini =
Biaya Tahunan, jika tanggal tagihan berada pada bulan aktif
Rp0, jika tidak jatuh tempo pada bulan aktif
```

Tampilkan secara terpisah:

- Kontribusi cadangan bulan ini
- Saldo cadangan awal dan akhir
- Tagihan jatuh tempo bulan ini
- Pembayaran dari cadangan
- Kekurangan cadangan, jika ada

Kekurangan cadangan harus ditampilkan sebagai kebutuhan yang perlu diselesaikan pengguna dan tidak boleh disembunyikan dengan mengubah angka secara otomatis.

### 16. Dana Darurat

Pengguna dapat memasukkan:

- Pengeluaran pokok bulanan
- Kategori Pengeluaran Wajib yang dihitung sebagai pengeluaran pokok
- Target jumlah bulan
- Saldo saat ini
- Target tanggal tercapai

Nilai pengeluaran pokok secara default dihitung dari kategori Pengeluaran Wajib yang dipilih pengguna. Pengguna dapat melakukan koreksi manual, tetapi aplikasi harus menampilkan sumber perhitungannya.

Rumus:

```text
Target Dana Darurat = Pengeluaran Pokok × Jumlah Bulan Target
```

Tampilkan:

- Target
- Saldo saat ini
- Kekurangan
- Progress bar
- Kontribusi bulan ini
- Estimasi waktu tercapai

### 17. Alokasi DANA

Pilihan eksekusi:

- Mingguan
- Harian
- Seluruh saldo sekaligus

Anggaran Uang Jajan Bulan Aktif sama dengan **Total Alokasi DANA** dan tidak mencakup Pengeluaran Wajib yang hanya menggunakan DANA sebagai kanal pembayaran.

```text
Uang Jajan Harian Dasar =
Anggaran Uang Jajan Bulan Aktif
/ Jumlah Hari pada Bulan Aktif
```

Karena Rupiah disimpan sebagai bilangan bulat, gunakan pembagian integer dan distribusikan sisa nominal ke hari terakhir periode.

```text
Anggaran 7 Hari =
Uang Jajan Harian Dasar
× min(7, Jumlah Hari Tersisa dalam Periode Anggaran)
```

```text
Nominal Dasar per Top-up =
Anggaran Uang Jajan Bulan Aktif
/ Jumlah Jadwal Top-up pada Bulan Aktif
```

Distribusikan sisa nominal ke top-up terakhir sehingga jumlah seluruh jadwal tepat sama dengan Total Alokasi DANA.

Untuk jadwal mingguan, gunakan jumlah kejadian top-up sebenarnya pada bulan aktif. Pengguna dapat memilih hari top-up mingguan.

Setiap transaksi terjadwal DANA harus memiliki:

- Tanggal jatuh tempo
- Nominal
- Sumber anggaran
- Status sudah termasuk anggaran harian atau belum
- Status eksekusi

Pengeluaran Wajib yang dibayar melalui DANA tidak boleh masuk ke Anggaran Uang Jajan Bulan Aktif.

### 18. Pembulatan Nominal

Sediakan:

- Tanpa pembulatan
- Kelipatan Rp1.000
- Kelipatan Rp5.000
- Kelipatan Rp10.000

Gunakan metode **pembulatan ke bawah** untuk komponen non-residual agar total tidak pernah melebihi Dana Bersih.

#### Pembulatan Global Kategori Utama

1. Hitung nilai mentah Alokasi Bank Jago, Total Alokasi Investasi, dan DANA dari Dana Bersih.
2. Bulatkan Total Alokasi Investasi ke bawah pada kelipatan terpilih.
3. Bulatkan Alokasi DANA ke bawah pada kelipatan terpilih.
4. Hitung Alokasi Bank Jago Final sebagai nilai residual.

```text
Alokasi Bank Jago Final =
Dana Bersih
- Total Alokasi Investasi Final
- Alokasi DANA Final
```

Alokasi Bank Jago Final tidak wajib menjadi kelipatan terpilih karena berfungsi sebagai komponen residual. Nilainya tidak boleh negatif.

#### Pembulatan Internal Investasi

1. Hitung nilai mentah Alokasi Bibit dan Alokasi Stockbit dari Total Alokasi Investasi Final.
2. Bulatkan Alokasi Stockbit ke bawah pada kelipatan terpilih.
3. Gunakan Alokasi Bibit sebagai residual.

```text
Alokasi Bibit Final =
Total Alokasi Investasi Final
- Alokasi Stockbit Final
```

Alokasi Bibit Final dan Alokasi Stockbit Final tidak boleh negatif.

#### Pembulatan Internal Lainnya

- Pada sub-alokasi Bank Jago, bulatkan komponen non-residual ke bawah dan gunakan Dana Operasional Tambahan sebagai residual.
- Pada pembagian DANA dan DANA+, bulatkan Saldo DANA+ ke bawah dan gunakan Saldo DANA Biasa sebagai residual.
- Pada jadwal harian, mingguan, atau cicilan cadangan, distribusikan sisa integer ke periode terakhir.

#### Persentase yang Ditampilkan

Tampilkan dua nilai jika pembulatan aktif:

- **Persentase target:** persentase yang dipilih pengguna.
- **Persentase efektif:** nominal final setelah pembulatan dibagi basis persentasenya.

Setelah seluruh pembulatan, jalankan ulang semua invarian. Hasil tidak boleh disimpan apabila terdapat selisih nominal.

### 19. Tampilan Hasil

Tampilkan empat card vertikal dengan label yang membedakan rencana, arus transfer, dan realisasi.

#### BRImo

- Kas Pegangan BRImo — Rencana
- Persentase efektif terhadap Total Pendapatan
- Tombol salin nominal

#### Bank Jago

- Total Transfer Awal ke Bank Jago — Rencana
- Total Kantong Pengeluaran Wajib
- Alokasi Bank Jago dari Dana Bersih
- Langganan dari Alokasi Bank Jago
- Dana darurat
- Dana operasional tambahan
- Progres dana darurat
- Tombol salin nominal Pengeluaran Wajib
- Tombol salin Total Transfer Awal ke Bank Jago

#### Investasi

Ringkasan utama:

- Total Alokasi Investasi — Rencana
- Persentase target dan efektif terhadap Dana Bersih
- Persentase efektif terhadap Total Pendapatan sebagai informasi tambahan dengan label berbeda
- Realisasi kontribusi investasi gabungan, hanya jika tersedia
- Peringatan risiko investasi

Detail dapat dibuka menjadi dua sub-card.

**Sub-card Bibit:**

- Alokasi Bibit — Rencana
- Persentase terhadap Total Alokasi Investasi
- Tanggal rencana top-up
- Realisasi kontribusi atau pembelian, hanya jika tersedia
- Nilai portofolio terakhir, hanya jika laporan telah dikonfirmasi
- Tombol salin

**Sub-card Stockbit:**

- Alokasi Stockbit — Rencana
- Persentase terhadap Total Alokasi Investasi
- Target transfer ke RDN
- Anggaran pembelian saham dan target Buffer Kas RDN
- Estimasi biaya transaksi, jika dikonfigurasi
- Realisasi transfer ke RDN, pembelian, dan saldo RDN, hanya jika tersedia
- Nilai portofolio terakhir, hanya jika laporan telah dikonfirmasi
- Tombol salin

#### DANA

- Total Alokasi DANA — Rencana
- Anggaran per periode top-up
- Anggaran harian dasar
- Sisa Anggaran DANA, hanya jika realisasi transaksi tersedia
- Ringkasan Saldo DANA Biasa dan Saldo DANA+, jika fitur aktif
- Jadwal top-up
- Tombol salin

Card harus sederhana, ringkas, dan dapat dibuka untuk melihat detail.

### 20. Ringkasan Visual

Tampilkan:

- Donut chart sederhana
- Progress bar
- Total Pendapatan
- Total Pengeluaran Wajib
- Dana Bersih
- Selisih Belum Dialokasikan

Pemetaan kategori chart:

- **Kebutuhan:** Total Pengeluaran Wajib
- **Kas Pegangan:** Kas Pegangan BRImo
- **Tabungan:** kontribusi dana darurat dan Tabungan Lain yang secara eksplisit dicatat
- **Investasi:** Total Alokasi Investasi, dengan rincian Bibit dan Stockbit pada tampilan detail
- **Uang Jajan:** Alokasi DANA
- **Operasional Tambahan:** Dana Operasional Tambahan Bank Jago

**Selisih Belum Dialokasikan** harus Rp0 pada hasil yang valid. Jika tidak nol, tampilkan sebagai error validasi, bukan sebagai sisa uang bebas.

Chart harus tetap terbaca pada layar kecil dan tidak hanya mengandalkan warna.

### 21. Checklist Transfer

Contoh checklist rencana awal:

- [ ] Sisakan Kas Pegangan BRImo
- [ ] Transfer Total Dana Masuk ke Bank Jago dari BRImo
- [ ] Pisahkan Total Pengeluaran Wajib ke Kantong Pengeluaran Wajib Bank Jago
- [ ] Pisahkan Alokasi Bank Jago dari Dana Bersih ke kantong internal yang sesuai
- [ ] Masukkan dana langganan non-wajib ke Kantong Langganan Bank Jago
- [ ] Masukkan kontribusi dana darurat ke Kantong Dana Darurat Bank Jago
- [ ] Masukkan dana operasional tambahan ke Kantong Operasional Bank Jago
- [ ] Top-up investasi ke Bibit sesuai Alokasi Bibit
- [ ] Transfer target kontribusi Stockbit ke RDN sesuai Alokasi Stockbit
- [ ] Verifikasi transfer RDN dan catat pembelian saham secara terpisah
- [ ] Top-up Alokasi DANA sesuai jadwal

Buat item tambahan secara dinamis berdasarkan kanal pembayaran Pengeluaran Wajib:

- Bank Jago: bayar dari Kantong Pengeluaran Wajib.
- DANA: pindahkan nominal wajib dari Kantong Pengeluaran Wajib ke DANA dan tandai sebagai dana wajib.
- Tunai: tarik nominal wajib dari Kantong Pengeluaran Wajib.
- Transfer bank lain: pindahkan nominal wajib dari Kantong Pengeluaran Wajib ke rekening tujuan.

Tambahkan pemeriksaan:

- [ ] Pastikan pengeluaran, langganan, atau tagihan tidak dibiayai dari dua sumber anggaran
- [ ] Pastikan pemindahan antarplatform tidak dicatat sebagai pengeluaran kedua

Sediakan:

- Tandai selesai
- Tandai semua selesai
- Reset checklist
- Salin langkah transfer
- Bagikan hasil
- Simpan ke riwayat

Checklist otomatis di-reset saat pengguna membuat alokasi bulan baru. Penyelesaian checklist merupakan status eksekusi manual dan tidak otomatis membuktikan saldo aktual.

---

## Bagian IV — Riwayat, Progres, Simulasi, dan Utilitas

> Mengatur pemantauan kondisi keuangan, evaluasi berkala, pengingat, serta ekspor data.

### 22. Riwayat

Simpan:

- Total Pendapatan
- Pengeluaran Wajib
- Nominal Kantong Pengeluaran Wajib Bank Jago
- Total Dana Masuk ke Bank Jago
- Status transfer Pengeluaran Wajib
- Kas Pegangan BRImo
- Preset
- Persentase target dan efektif
- Nominal setiap kategori utama
- Total Alokasi Investasi serta pembagian Bibit dan Stockbit
- Target transfer Stockbit ke RDN dan status realisasinya, jika tersedia
- Sub-kantong Bank Jago
- Anggaran DANA
- Target dana darurat
- Checklist
- Catatan
- Nomor revisi
- Tanggal dibuat dan diperbarui
- Status bulan: draf, dikonfirmasi, dikunci, atau direvisi

Fitur:

- Lihat detail
- Edit draf
- Buat revisi dari bulan yang telah dikonfirmasi
- Duplikasi
- Hapus dengan konfirmasi
- Filter tahun
- Cari
- Bandingkan dengan bulan sebelumnya

Ketentuan versioning:

- Bulan yang telah dikonfirmasi atau memiliki data realisasi tidak boleh ditimpa secara diam-diam.
- Perubahan menghasilkan revisi baru dengan alasan perubahan.
- Rekonsiliasi Bibit, Stockbit, DANA+, dan metrik historis menunjuk ke `monthlyAllocationRevisionId` tertentu.
- Revisi lama dipertahankan sebagai audit trail sampai pengguna secara eksplisit menghapusnya.

### 22A. Pencatatan Realisasi Pengeluaran

Sediakan alur **Catat Pengeluaran** agar metrik aktual dapat dihitung.

Setiap realisasi memiliki:

- ID
- Tanggal
- Nominal
- Kategori
- Sumber anggaran
- Kanal pembayaran
- Referensi Pengeluaran Wajib atau anggaran DANA, jika ada
- Periode dan revisi alokasi
- Status verifikasi
- Catatan

Aturan:

- Pemindahan dana antarplatform tidak dicatat sebagai pengeluaran baru.
- Pengeluaran Wajib melalui DANA tetap direferensikan ke Kantong Pengeluaran Wajib.
- Sisa anggaran uang jajan dihitung dari Total Alokasi DANA dikurangi realisasi pengeluaran yang sumber anggarannya Alokasi DANA.
- Nilai aktual tidak boleh disimpulkan dari checklist saja.

### 23. Dashboard Progres

Tampilkan:

- Perkembangan dana darurat
- Total Alokasi Investasi bulan berjalan
- Rincian target Bibit dan Stockbit
- Realisasi kontribusi investasi gabungan bulan berjalan, jika tersedia
- Realisasi penggunaan dana Stockbit untuk pembelian, ditampilkan terpisah dari kontribusi
- Nilai portofolio terakhir per platform, jika laporan telah diimpor
- Savings Rate
- Rata-rata anggaran pengeluaran
- Rata-rata pengeluaran aktual, hanya jika data realisasi tersedia
- Rata-rata anggaran uang jajan
- Rata-rata uang jajan aktual, hanya jika data realisasi tersedia
- Checklist Completion Rate
- Perbandingan maksimal 12 bulan

Sediakan input opsional **Tabungan Lain** untuk kontribusi tabungan yang tidak termasuk dana darurat atau investasi. Setiap kontribusi harus memiliki nama, nominal, periode, dan status rencana atau aktual.

```text
Savings Rate Rencana =
(Kontribusi Dana Darurat Direncanakan
+ Total Alokasi Investasi
+ Tabungan Lain Direncanakan)
/ Total Pendapatan
× 100%
```

```text
Savings Rate Aktual =
(Kontribusi Dana Darurat Aktual
+ Realisasi Kontribusi Bibit
+ Realisasi Pendanaan Stockbit
+ Tabungan Lain Aktual)
/ Total Pendapatan Aktual
× 100%
```

Dana operasional, Pengeluaran Wajib, dan uang jajan tidak dihitung sebagai tabungan. Saldo DANA+ juga tidak otomatis dihitung sebagai tabungan atau investasi karena merupakan bagian dari anggaran DANA. Untuk Stockbit, gunakan deposit eksternal ke RDN sebagai realisasi kontribusi; jangan menjumlahkannya lagi dengan pembelian saham yang memakai dana tersebut.

```text
Checklist Completion Rate =
Jumlah Item Selesai
/ Jumlah Item Aktif
× 100%
```

Jika belum ada data aktual, gunakan label **anggaran** atau **rencana**, bukan **pengeluaran aktual**. Jangan mencampur Savings Rate Rencana dan Aktual dalam satu angka tanpa label.

### 24. Financial Health Score

Buat skor 0–100 dengan bobot default yang transparan. Skor bersifat indikator edukatif, bukan diagnosis absolut.

#### 1. Kecukupan Dana Darurat — maksimal 30 poin

```text
Rasio Kecukupan = Saldo Dana Darurat / Target Dana Darurat
```

- ≥100%: 30 poin
- 75%–<100%: 24 poin
- 50%–<75%: 18 poin
- 25%–<50%: 9 poin
- <25%: 0 poin

#### 2. Rasio Pengeluaran Wajib terhadap Total Pendapatan — maksimal 20 poin

- ≤50%: 20 poin
- >50%–60%: 15 poin
- >60%–70%: 8 poin
- >70%: 0 poin

#### 3. Rasio Cicilan terhadap Total Pendapatan — maksimal 15 poin

- ≤10%: 15 poin
- >10%–20%: 12 poin
- >20%–30%: 6 poin
- >30%: 0 poin

#### 4. Konsistensi Investasi — maksimal 15 poin

Gunakan maksimal tiga bulan aktif terakhir yang mempunyai target dan data realisasi terverifikasi:

- Target tercapai pada seluruh bulan tersedia: 15 poin
- Tercapai pada ≥67% bulan tersedia: 10 poin
- Tercapai pada ≥34% bulan tersedia: 5 poin
- Tercapai pada <34% bulan tersedia: 0 poin

Target investasi per bulan adalah Total Alokasi Investasi. Realisasi investasi adalah Realisasi Kontribusi Bibit ditambah Realisasi Pendanaan Stockbit. Pembelian saham Stockbit tidak ditambahkan kembali apabila deposit RDN sudah dihitung sebagai kontribusi.

Komponen ini tidak tersedia jika tidak ada satu pun bulan dengan target dan realisasi investasi yang terverifikasi.

#### 5. Rasio Uang Jajan terhadap Total Pendapatan — maksimal 10 poin

- ≤20%: 10 poin
- >20%–30%: 7 poin
- >30%–40%: 3 poin
- >40%: 0 poin

Gunakan rasio aktual jika data aktual tersedia; jika tidak, gunakan rasio rencana dan beri label.

#### 6. Penyelesaian Checklist — maksimal 10 poin

- ≥90%: 10 poin
- 75%–<90%: 7 poin
- 50%–<75%: 4 poin
- <50%: 0 poin

#### Data Parsial

Jangan memberi nol pada komponen yang datanya tidak tersedia.

```text
Skor Sementara =
Total Poin yang Diperoleh
/ Total Bobot Komponen yang Tersedia
× 100
```

```text
Kelengkapan Data =
Total Bobot Komponen yang Tersedia
/ 100
× 100%
```

Kategori:

- 0–39: Perlu perhatian
- 40–59: Cukup berisiko
- 60–79: Cukup sehat
- 80–100: Sangat sehat

Setiap skor harus menyertakan:

- Basis data rencana atau aktual
- Tingkat kelengkapan data
- Komponen yang belum tersedia
- Alasan dan saran

Ambang dapat dikonfigurasi di masa mendatang, tetapi versi ambang yang digunakan harus disimpan pada hasil skor historis.

### 25. Simulasi Keuangan

Tambahkan fitur **Bagaimana Jika**.

Pengguna dapat mengubah:

- Penghasilan
- Pengeluaran wajib
- Anggaran pengeluaran variabel atau uang jajan
- Persentase Total Alokasi Investasi
- Pembagian internal Bibit dan Stockbit
- Persentase alokasi DANA
- Target dana darurat
- Langganan

Tampilkan dampaknya terhadap:

- Target dana darurat
- Investasi tahunan
- Uang jajan
- Financial Health Score

Perubahan simulasi tidak langsung mengubah data utama.

### 49. Pengingat

Sediakan local notification untuk:

- Hari gajian
- Waktu membuat alokasi
- Top-up Bibit
- Transfer kontribusi Stockbit ke RDN
- Evaluasi penggunaan saldo RDN
- Top-up DANA
- Tagihan
- Langganan
- Evaluasi akhir bulan

Pengguna dapat mengatur tanggal dan waktu.

### 50. Ekspor

Sediakan:

- Salin sebagai teks
- Bagikan sebagai gambar
- Ekspor PDF
- Ekspor CSV
- Ekspor riwayat chat

Semua hasil ekspor menggunakan branding Finara.

Jangan sertakan API key atau kredensial sensitif.

---

## Bagian V — Finara AI dan Sistem Multi-Model

> Mendefinisikan chatbot, konfigurasi provider, model discovery, keamanan konteks, biaya, fallback, dan error handling.

### 26. Finara AI

Tambahkan chatbot bernama **Finara AI**.

Finara AI membantu pengguna:

- Memahami hasil alokasi
- Menilai pengeluaran
- Membuat strategi tabungan
- Menyusun target dana darurat
- Memahami risiko investasi
- Membandingkan kondisi antarbulan
- Menjelaskan istilah keuangan
- Mengidentifikasi pengeluaran yang dapat dikurangi
- Membuat simulasi keuangan

Finara AI tidak melakukan transaksi dan tidak mengubah data tanpa persetujuan pengguna.

### 27. Konfigurasi API Finara AI

Aplikasi tidak menyediakan API key bawaan.

Pengguna memasukkan API sendiri melalui:

**Pengaturan → Finara AI → Penyedia dan Model**

Input:

- Nama konfigurasi
- Provider AI
- Base URL
- API key
- Organization ID, opsional
- Project ID, opsional
- Custom HTTP headers, opsional
- Penandaan header sensitif, agar nilainya disimpan dan ditampilkan seperti API key
- Timeout
- Endpoint daftar model, opsional
- Endpoint chat completion
- Dukungan streaming
- Format API

Dukung:

- OpenAI-compatible API
- OpenAI
- Gemini
- Anthropic
- Groq
- OpenRouter
- Ollama
- Local AI server
- Custom endpoint

Jangan menyertakan API key bawaan atau API key nyata.

### 28. Dukungan Banyak Model dari Satu API Key

Satu API key dapat memberikan akses ke banyak model.

Aplikasi harus:

- Mengambil daftar model secara otomatis
- Menampilkan model dalam searchable picker
- Menyimpan model favorit
- Menyimpan model terakhir digunakan
- Memilih model default
- Memilih model berbeda untuk setiap percakapan
- Mendukung input model manual
- Mendukung fallback model
- Mendukung banyak provider
- Menampilkan provider dan model aktif

### 29. Pengambilan Daftar Model Otomatis

Sediakan tombol:

**Ambil Daftar Model**

Untuk provider OpenAI-compatible, dukung endpoint seperti:

```text
GET /v1/models
```

Jangan menganggap semua provider memakai format yang sama.

Alur:

1. Validasi Base URL
2. Validasi API key
3. Kirim request ke endpoint model
4. Ambil seluruh model yang tersedia
5. Normalisasi data model
6. Tampilkan dalam model picker
7. Simpan cache lokal
8. Simpan waktu terakhir diperbarui

Status:

- Belum mengambil model
- Sedang mengambil model
- Model berhasil ditemukan
- Tidak ada model tersedia
- API key tidak valid
- Endpoint tidak tersedia
- Provider tidak mendukung discovery
- Gagal terhubung

Sediakan:

- Ambil Daftar Model
- Muat Ulang Model
- Tes Model Terpilih
- Tambahkan Model Manual
- Hapus Cache Model

### 30. Input Model Manual

Jika discovery gagal, pengguna dapat memasukkan model manual.

Input:

- Model ID
- Nama tampilan
- Provider
- Endpoint khusus, opsional
- Context window, opsional
- Maksimum output token, opsional
- Dukungan streaming
- Dukungan vision
- Dukungan file
- Dukungan function calling
- Dukungan structured output
- Harga input, opsional
- Harga output, opsional

Model manual dapat:

- Diedit
- Dihapus
- Diuji
- Dijadikan default
- Ditambahkan ke favorit

### 31. Model Picker

Model picker harus:

- Modern
- Simpel
- Searchable
- Responsif

Akses dari:

- Konfigurasi AI
- Header Finara AI
- Percakapan baru
- Pengaturan percakapan

Tampilkan:

- Nama model
- Model ID
- Provider
- Status tersedia
- Kemampuan utama
- Status favorit
- Terakhir digunakan

Filter:

- Semua model
- Favorit
- Chat teks
- Vision
- Function calling
- Structured output
- Streaming
- Model lokal
- Gratis, jika metadata tersedia
- Berbayar, jika metadata tersedia

Gunakan bottom sheet untuk detail model.

### 32. Kemampuan Model

Jika metadata tersedia, tampilkan:

- Text chat
- Image input
- File input
- Audio input
- Text-to-speech
- Function calling
- Tool use
- Structured JSON output
- Streaming
- Reasoning
- Context window
- Maksimum output token

Jangan menebak kemampuan hanya berdasarkan nama model.

Gunakan status kemampuan:

- `UNKNOWN` — belum ada klaim atau pengujian
- `CLAIMED` — dinyatakan oleh metadata atau pengguna, tetapi belum diuji
- `VERIFIED` — berhasil diuji untuk konfigurasi aktif
- `UNSUPPORTED` — diklaim tidak didukung atau gagal pada tes kemampuan yang valid

Jika belum diketahui, tampilkan **Kemampuan model belum terverifikasi**. Model dengan status `UNKNOWN` atau `CLAIMED` dapat diuji secara eksplisit oleh pengguna.

### 33. Model Default dan Model Per Percakapan

Pengguna dapat menentukan:

- Model default seluruh aplikasi
- Model default analisis keuangan
- Model default pertanyaan umum
- Model berbeda untuk setiap percakapan

Saat percakapan baru:

1. Gunakan model default
2. Izinkan pengguna mengganti model
3. Simpan model pada metadata percakapan

Tampilkan model aktif pada header chat.

Jika pengguna mengganti model di tengah percakapan, tampilkan pilihan:

- Lanjutkan dengan riwayat chat yang sama
- Mulai percakapan baru

### 34. Favorit, Model Terakhir, dan Allowed Models

Sediakan:

- Model Favorit
- Terakhir Digunakan
- Direkomendasikan untuk Analisis Keuangan
- Semua Model

Simpan maksimal 10 model terakhir.

Sediakan **Allowed Models**:

- Izinkan semua model
- Hanya izinkan model tertentu
- Blokir model tertentu
- Hanya izinkan model favorit

Finara hanya boleh memilih model dari daftar yang diizinkan pengguna. Urutan prioritas aturan:

1. Model yang diblokir selalu ditolak.
2. Jika mode *hanya izinkan model tertentu* aktif, model harus berada pada allowlist.
3. Jika mode *hanya izinkan model favorit* aktif, model harus berstatus favorit dan tidak diblokir.
4. Pemilihan otomatis hanya boleh menggunakan model dengan kemampuan yang telah terverifikasi untuk kebutuhan request.

### 35. Pengujian Model

Sediakan tombol **Tes Model**.

Periksa secara terpisah:

- Model dapat diakses
- API key memiliki izin
- Endpoint berfungsi
- Chat completion berhasil
- Streaming berfungsi
- Structured output berfungsi
- Function calling berfungsi
- Waktu respons
- Pesan error provider

Gunakan pengujian terpisah agar hasil tidak menyesatkan:

- **Tes koneksi dan chat:** gunakan prompt `Balas dengan kata: Terhubung.`
- **Tes streaming:** gunakan respons singkat yang dikirim bertahap.
- **Tes structured output:** gunakan skema JSON minimal.
- **Tes function calling:** gunakan satu tool dummy tanpa efek samping.

Aturan:

- Tes koneksi tidak otomatis memverifikasi streaming, structured output, atau function calling.
- Kemampuan berstatus `UNKNOWN` atau `CLAIMED` boleh diuji atas tindakan eksplisit pengguna.
- Jangan menandai kemampuan sebagai gagal hanya karena tes tersebut tidak dijalankan.
- Tandai `UNSUPPORTED` hanya setelah provider menyatakan tidak didukung atau tes kemampuan yang valid gagal dengan respons yang relevan.

Status hasil tes:

- Berhasil
- Gagal
- Tidak diuji
- Tidak memiliki izin
- Model tidak ditemukan
- Model dinonaktifkan
- Kuota habis
- Rate limit
- Timeout
- Respons tidak kompatibel

### 36. Pemilihan Model

Mode:

#### Manual

Pengguna memilih model sendiri.

#### Default

Finara menggunakan model default.

#### Otomatis Berdasarkan Kemampuan

Finara memilih model dari daftar yang diizinkan berdasarkan kebutuhan.

Contoh:

- Pertanyaan sederhana: model ringan
- Analisis panjang: context window besar
- Analisis gambar: model vision
- Function calling: model yang mendukung tools

Jangan mengganti model secara diam-diam.

Tampilkan model yang dipilih sebelum atau ketika request dijalankan. Jika kemampuan yang dibutuhkan belum terverifikasi pada seluruh model yang diizinkan, jangan memilih secara otomatis; minta pengguna memilih model atau menjalankan tes kemampuan.

### 37. Fallback Model

Pengguna dapat menentukan:

1. Model utama
2. Model cadangan pertama
3. Model cadangan kedua

Fallback hanya digunakan jika:

- Model tidak tersedia
- Rate limit
- Provider error
- Kemampuan wajib tidak sesuai
- Timeout

Pilihan:

- Gunakan otomatis
- Minta konfirmasi
- Jangan gunakan fallback

Ketentuan keamanan dan izin:

- Fallback dalam provider yang sama mengikuti izin data provider tersebut.
- Fallback lintas provider hanya boleh dijalankan otomatis jika pengguna telah memberikan izin eksplisit untuk mengirim kategori data yang sama ke provider tujuan.
- Jika izin provider tujuan belum ada, minta konfirmasi sebelum mengirim request.
- Tampilkan provider dan model tujuan sebelum atau ketika request dijalankan.
- Jangan gunakan fallback untuk API key tidak valid pada provider utama, kecuali provider fallback mempunyai konfigurasi dan kredensial valid sendiri.
- Catat alasan fallback tanpa menyimpan data sensitif.

### 38. Multi-Provider

Pengguna dapat menyimpan beberapa provider.

Contoh:

- Provider Utama
- Provider Hemat
- Provider Lokal
- Provider Cadangan

Setiap provider memiliki:

- Nama
- Base URL
- API key
- Daftar model
- Model default
- Status koneksi
- Waktu terakhir diperiksa

API key disimpan terpisah menggunakan secure storage.

### 39. Harga dan Estimasi Biaya

Setiap model dapat memiliki:

- Harga input per satu juta token
- Harga output per satu juta token
- Mata uang
- Biaya tetap per request, opsional

Tampilkan:

- Estimasi token input
- Estimasi token output
- Perkiraan biaya request
- Total estimasi biaya harian
- Total estimasi biaya bulanan

Jika data harga tidak tersedia, jangan menampilkan estimasi palsu.

Tampilkan disclaimer bahwa estimasi dapat berbeda dari tagihan provider.

### 40. Parameter Model

Setiap model dapat memiliki:

- Temperature
- Top P
- Maximum output token
- Reasoning effort, jika didukung
- Response format
- Streaming
- Timeout
- System prompt tambahan
- Tool use

Tingkat pengaturan:

- Sederhana
- Lanjutan
- Gunakan default provider

Pada mode sederhana, tampilkan hanya:

- Model
- Panjang jawaban
- Gaya jawaban
- Streaming

### 41. Kompatibilitas Parameter

Sebelum mengirim request:

1. Periksa kemampuan model dan format provider.
2. Petakan nama parameter melalui adapter provider.
3. Jangan mengirim parameter OpenAI ke provider lain tanpa adapter.
4. Tangani format system message, structured output, function calling, dan streaming sesuai provider.
5. Pisahkan parameter opsional dari kemampuan wajib.

Kebijakan parameter:

- **Parameter opsional tidak didukung:** hapus sebelum request dan tampilkan peringatan yang dapat dilihat pengguna. Jangan menghapusnya secara diam-diam.
- **Kemampuan wajib tidak didukung:** batalkan request dan minta pengguna memilih model atau konfigurasi lain.
- **Kemampuan belum terverifikasi:** jangan gunakan pemilihan otomatis; izinkan pengguna menjalankan tes atau memilih secara manual.
- Simpan request efektif tanpa nilai sensitif untuk kebutuhan debug lokal.

### 42. Tampilan Finara AI

Tampilkan:

- Header Finara AI
- Nama provider dan model
- Status koneksi
- Riwayat pesan
- Input multiline
- Tombol kirim
- Tombol hentikan
- Salin jawaban
- Regenerasi
- Percakapan baru
- Suggestion chips
- Indikator mengetik
- Timestamp

Contoh pertanyaan cepat:

- Analisis alokasi bulan ini
- Apakah uang jajan saya terlalu besar?
- Bagaimana mempercepat dana darurat?
- Apa yang perlu saya kurangi?
- Bagaimana membagi investasi antara Bibit dan Stockbit?
- Bagaimana meningkatkan investasi?
- Bandingkan bulan ini dengan bulan lalu

Input chat harus tetap terlihat saat keyboard terbuka.

Gunakan streaming response jika provider mendukungnya.

### 43. Tombol “Tanyakan Hasil Ini ke AI”

Tambahkan tombol pada halaman hasil:

**Tanyakan Hasil Ini ke AI**

Konteks yang dapat dikirim:

- Total Pendapatan
- Kas Pegangan BRImo
- Total Pengeluaran Wajib
- Nominal Kantong Pengeluaran Wajib Bank Jago
- Total Dana Masuk ke Bank Jago
- Preset
- Alokasi Bank Jago dari Dana Bersih
- Sub-kantong Bank Jago
- Total Alokasi Investasi
- Alokasi Bibit
- Alokasi Stockbit
- Target transfer Stockbit ke RDN dan realisasi terverifikasi, jika dipilih pengguna
- Alokasi DANA
- Anggaran per periode top-up
- Anggaran harian
- Target dana darurat
- Financial Health Score
- Peringatan aktif

Sebelum mengirim data, minta persetujuan pengguna.

Finara AI tidak boleh langsung mengubah data utama.

Jika memberi saran, tampilkan:

- Lihat Simulasi
- Terapkan ke Simulasi
- Abaikan Saran

### 44. Izin Data AI

Pilihan cakupan data:

- Tanpa akses data keuangan
- Akses bulan aktif
- Akses tiga bulan terakhir
- Akses enam bulan terakhir
- Pilih data manual

Simpan izin per provider dan per kategori data. Jangan mengirim data ke AI tanpa persetujuan pengguna.

Jangan pernah memasukkan data berikut ke prompt, pesan, konteks AI, file lampiran AI, log, analytics, ekspor, atau detail error:

- PIN
- OTP
- Password
- CVV
- Nomor kartu lengkap
- API key
- Kredensial bank
- Authorization header
- Custom header sensitif

API key dan Authorization header hanya boleh digunakan sebagai kredensial autentikasi untuk endpoint provider yang dikonfigurasi pengguna, bukan sebagai konten yang diproses model.

### 45. Keamanan API Key

Simpan API key menggunakan:

- Android Keystore
- iOS Keychain
- Secure storage

API key hanya boleh dikirim sebagai kredensial autentikasi ke endpoint provider yang telah dikonfigurasi pengguna.

Jangan:

- Menyimpan API key dalam plain text
- Menampilkan API key lengkap
- Menyertakan API key dalam log
- Menyertakan API key dalam ekspor
- Mengirim API key dalam prompt atau konteks model
- Menampilkan Authorization header dalam error
- Mengirim kredensial ke host yang berbeda setelah redirect tanpa validasi eksplisit

Tampilkan API key secara tersamarkan. Terapkan perlindungan yang sama pada custom header sensitif, token akses, dan parameter URL yang mengandung kredensial. Jangan memasukkan nilai sensitif ke backup, ekspor, analytics, crash log, atau detail error.

### 46. System Prompt Finara AI

Gunakan system prompt dasar berikut:

```text
Anda adalah Finara AI, asisten keuangan di dalam aplikasi Finara. Gunakan Bahasa Indonesia yang jelas, sederhana, objektif, dan mudah dipahami.

Bantu pengguna memahami penghasilan, pengeluaran, dana darurat, tabungan, investasi, langganan, dan uang jajan.

Jangan menjanjikan keuntungan investasi. Jangan menyatakan investasi pasti naik atau bebas risiko. Jangan meminta PIN, OTP, password, CVV, API key, nomor kartu lengkap, atau kredensial perbankan.

Ketika memberikan rekomendasi, jelaskan dasar perhitungan, asumsi, risiko, dan alternatifnya. Prioritaskan kebutuhan wajib dan dana darurat sebelum menyarankan peningkatan investasi.

Gunakan format Rupiah Indonesia. Jangan menyajikan asumsi sebagai fakta. Jika data tidak cukup, jelaskan data yang belum tersedia.

Jawaban bersifat edukasi dan informasi, bukan nasihat keuangan profesional atau jaminan hasil.
```

### 47. Riwayat Percakapan

Simpan secara lokal:

- ID percakapan
- Judul
- Tanggal dibuat
- Tanggal terakhir diperbarui
- Provider
- Model
- Daftar pesan
- Data konteks yang digunakan
- Estimasi token

Fitur:

- Percakapan baru
- Ubah judul
- Cari
- Hapus satu percakapan
- Hapus semua
- Ekspor sebagai teks
- Salin jawaban
- Lanjutkan percakapan lama

Pilihan penyimpanan:

- Jangan simpan
- Hapus setelah sesi
- Hapus otomatis 7, 30, atau 90 hari
- Simpan sampai dihapus

### 48. Error Handling AI

Tangani:

- API key kosong
- API key ditolak
- Endpoint salah
- Model tidak tersedia
- Tidak ada internet
- Timeout
- Rate limit
- Kuota habis
- Respons tidak valid
- Respons kosong
- Context terlalu panjang
- Streaming terputus
- Parameter tidak didukung
- Model overload

Sediakan:

- Coba lagi
- Buka Pengaturan AI
- Ganti model
- Gunakan fallback
- Kurangi konteks
- Mulai chat baru
- Salin detail error

Jangan menampilkan data sensitif pada detail error.

---

## Bagian VI — Keamanan, Data, Validasi, dan Arsitektur

> Menetapkan keamanan aplikasi, format data, validasi lintas modul, penyimpanan lokal, dan pemisahan tanggung jawab teknis.

### 51. Keamanan Aplikasi

Tambahkan:

- PIN aplikasi
- Biometrik
- Penyimpanan lokal terenkripsi
- Hapus seluruh data, termasuk database lokal, file dokumen, cache, dan kredensial pada secure storage
- Backup dan restore terenkripsi untuk data non-kredensial
- API key dan custom header sensitif tidak ikut dalam backup aplikasi; pengguna harus memasukkannya kembali setelah restore
- Auto-lock
- Konfirmasi sebelum menghapus data

Jangan meminta kredensial rekening bank atau platform investasi.

### 52. Format Rupiah

Gunakan format:

- Rp300.000
- Rp1.500.000
- Rp10.000.000

Tidak perlu angka desimal.

Input nominal otomatis menambahkan pemisah ribuan.

### 53. Validasi

Terapkan:

- Penghasilan Utama wajib lebih dari nol
- Total Pendapatan sama dengan Penghasilan Utama ditambah Penghasilan Tambahan yang aktif
- Kas Pegangan BRImo tidak boleh melebihi Total Pendapatan
- Kas Pegangan BRImo ditambah Total Pengeluaran Wajib tidak boleh melebihi Total Pendapatan
- Dana Bersih tidak boleh negatif
- Total Pengeluaran Wajib harus sama dengan nominal Kantong Pengeluaran Wajib Bank Jago
- Total Dana Masuk ke Bank Jago harus sama dengan Total Pengeluaran Wajib ditambah Alokasi Bank Jago dari Dana Bersih
- Pengeluaran Wajib tidak boleh dihitung kembali dalam persentase Alokasi Bank Jago
- Satu item anggaran hanya boleh memiliki satu sumber anggaran aktif pada satu periode
- Sumber anggaran dan kanal pembayaran harus disimpan terpisah
- Satu langganan tidak boleh dibiayai sekaligus dari Kantong Pengeluaran Wajib dan Kantong Langganan
- Kebutuhan langganan dari Alokasi Bank Jago tidak boleh melebihi Alokasi Bank Jago
- Pengeluaran Wajib yang dibayar melalui DANA tidak boleh dihitung kembali sebagai uang jajan
- Kategori makanan atau transportasi tidak boleh aktif sekaligus sebagai Pengeluaran Wajib dan Uang Jajan pada periode yang sama
- Total custom allocation tingkat utama wajib 100%
- Nominal tidak boleh negatif
- Tombol hitung hanya aktif jika data valid
- Seluruh hasil perhitungan harus konsisten
- Kas Pegangan BRImo + Total Dana Masuk ke Bank Jago + Total Alokasi Investasi + Alokasi DANA harus sama dengan Total Pendapatan setelah pembulatan
- Total Alokasi Investasi harus sama dengan Alokasi Bibit ditambah Alokasi Stockbit
- Total persentase Bibit dan Stockbit wajib tepat 100% ketika Total Alokasi Investasi lebih dari nol
- Transfer ke RDN dan pembelian saham tidak boleh dihitung sebagai dua kontribusi investasi
- Persentase harus selalu menampilkan basis perhitungannya
- Persentase efektif harus dihitung dari nominal final setelah pembulatan
- Selisih Belum Dialokasikan harus Rp0 pada hasil valid
- Nilai tidak tersedia disimpan sebagai `null`
- Revisi historis tidak boleh menimpa dasar rekonsiliasi lama
- Model ID wajib valid
- Base URL wajib valid dan menggunakan skema yang diizinkan
- API key tidak boleh dicatat pada log
- Parameter request disesuaikan dengan kemampuan model dan adapter provider
- Fallback lintas provider wajib memeriksa izin data provider tujuan

### 54. Penyimpanan Data

Untuk MVP:

- Gunakan local database
- Tidak memerlukan login
- Tidak memerlukan backend
- Tidak melakukan integrasi bank
- Tidak melakukan transfer otomatis
- Data tetap tersedia setelah aplikasi ditutup

Struktur data inti:

- UserProfile
- MonthlyAllocation
- MonthlyAllocationRevision
- IncomeSource
- MandatoryExpense
- MandatoryExpenseFundingPlan
- BudgetFundingAssignment
- ExpenseRealization
- Subscription
- SubscriptionReserveLedger
- EmergencyFundTarget
- EmergencyFundContribution
- OtherSavingsContribution
- InvestmentPlatformAllocation
- StockbitAllocationPlan
- StockbitPortfolioSnapshot
- StockbitTransaction
- InvestmentPlatformReconciliation
- ChecklistItem
- Reminder
- SimulationScenario
- ChatConversation
- ChatMessage
- AIProviderConfiguration
- AIProviderDataPermission
- AIModel
- AIModelCapability
- AIModelPricing
- AIModelParameters
- AIModelTestResult
- AIModelFallbackRule
- AllowedModelConfiguration
- ModelListCache
- AppSettings

Field minimum `BudgetFundingAssignment`:

- itemId
- itemType
- period
- fundingSource
- paymentChannel
- includedInSpendingBudget

Field minimum `ExpenseRealization`:

- id
- transactionDate
- amount
- categoryId
- fundingSource
- paymentChannel
- monthlyAllocationRevisionId
- referenceItemId
- verificationStatus
- userNotes

Nilai yang tidak tersedia disimpan sebagai `null`. String **Tidak tersedia** hanya digunakan untuk presentasi.

### 55. Arsitektur

Pisahkan:

- UI layer
- State management
- Calculation service
- Allocation flow validation service
- Financial metric service
- Investment allocation service
- Investment platform allocation service
- Stockbit allocation service
- Investment aggregation service
- RDN reconciliation service
- Mandatory expense funding service
- Budget funding assignment service
- Expense realization service
- Subscription reserve service
- Allocation revision service
- Local database
- Secure storage
- Notification service
- AI provider registry
- AI provider adapter
- AI model discovery service
- AI model repository
- AI model selection service
- AI model testing service
- AI fallback service
- AI provider permission service
- AI request builder
- Chat service
- Financial context builder
- Data sanitizer
- Token estimator
- Cost estimator
- Export service

Interface minimal provider:

- `testConnection()`
- `fetchModels()`
- `normalizeModel()`
- `testModel()`
- `sendMessage()`
- `streamMessage()`
- `cancelRequest()`
- `validateParameters()`
- `buildRequest()`
- `parseResponse()`
- `parseError()`

Gunakan komponen reusable. Jangan menulis business logic langsung di dalam widget UI. Semua service perhitungan harus menghasilkan keluaran deterministik dan dapat diuji tanpa UI.

---

## Bagian VII — Prioritas Pengembangan dan Quality Assurance

> Menentukan cakupan MVP, strategi pengujian, dan kriteria penerimaan hasil akhir.

### 59. Prioritas Pengembangan

Gunakan fase bertahap agar cakupan dapat diuji tanpa mencampurkan fitur inti dan fitur lanjutan. Navigasi, onboarding, tombol, dan acceptance criteria harus mengikuti fase aktif.

#### Fase 1 — Core Financial MVP

1. Splash screen dan onboarding tanpa halaman AI
2. Beranda dasar
3. Navigasi: Beranda, Hitung, Progres dasar, dan Riwayat
4. Input Total Pendapatan dan Kas Pegangan BRImo
5. Pengeluaran Wajib dan Kantong Pengeluaran Wajib Bank Jago
6. Sumber anggaran dan kanal pembayaran
7. Preset dan custom allocation
8. Perhitungan otomatis serta validasi invarian aliran dana
9. Sub-alokasi Bank Jago
10. Total Alokasi Investasi serta pembagian rencana Bibit dan Stockbit
11. Alokasi DANA dasar
12. Pembulatan deterministik
13. Card hasil dan checklist transfer
14. Riwayat lokal berversi
15. Pencatatan realisasi pengeluaran dasar
16. Target dana darurat
17. Langganan dan saldo cadangan tahunan
18. Progres dana darurat, anggaran, dan checklist
19. Dark mode
20. Local notification
21. Validasi lengkap

#### Fase 2 — Finara AI MVP

1. Aktifkan menu dan onboarding Finara AI
2. Satu konfigurasi OpenAI-compatible API
3. Secure API key storage
4. Model discovery
5. Searchable model picker
6. Model default dan favorit
7. Riwayat percakapan lokal
8. Izin data per provider
9. Mock API dan error handling dasar

#### Fase 3 — AI Lanjutan dan Analitik

1. Multi-provider
2. Allowed Models dan fallback dengan izin lintas provider
3. Pengujian kemampuan model
4. Estimasi biaya
5. Financial Health Score lengkap
6. Simulasi keuangan
7. Analitik realisasi dan perbandingan sampai 12 bulan

#### Fase 4 — Ekstensi Produk

1. Impor laporan Bibit sesuai roadmap modul
2. Impor dan rekonsiliasi Stockbit sesuai roadmap modul
3. Pembagian DANA dan DANA+ sesuai roadmap modul
4. Integrasi AI terhadap data investasi dan DANA+ setelah izin pengguna

### 60. Pengujian

Tambahkan unit test dan integration test sesuai fase untuk:

#### Keuangan Inti

- Rumus Total Pendapatan dan aktivasi Penghasilan Tambahan
- Pengurangan Pengeluaran Wajib sebelum pembagian persentase
- Pemisahan sumber anggaran dan kanal pembayaran
- Penyimpanan Pengeluaran Wajib pada Kantong Pengeluaran Wajib Bank Jago
- Perhitungan Total Dana Masuk ke Bank Jago
- Pencegahan double counting antara Pengeluaran Wajib, sub-alokasi Bank Jago, dan DANA
- Pemindahan antarplatform tidak dihitung sebagai pengeluaran kedua
- Preset dan custom allocation tingkat utama
- Pembagian internal Bibit dan Stockbit
- Total custom allocation tepat 100% pada kedua tingkat
- Stockbit dinonaktifkan menghasilkan Bibit 100% dan Stockbit 0%
- Migrasi riwayat lama mempertahankan Bibit 100% dan Stockbit 0%
- Transfer RDN, pembelian saham, penjualan, dan saldo awal tidak mengalami double counting
- Pembulatan ke bawah dan komponen residual
- Invarian Total Pendapatan setelah pembulatan
- Persentase target dan persentase efektif
- Sub-alokasi berdasarkan langganan aktual dengan rasio 5:4
- Kebutuhan langganan melebihi Alokasi Bank Jago
- Saldo cadangan langganan tahunan dan pembayaran jatuh tempo
- Pembagian sisa integer pada jadwal terakhir
- Dana darurat
- Uang jajan berdasarkan jumlah hari dan jumlah jadwal top-up bulan aktif
- Pencatatan realisasi pengeluaran
- Sisa anggaran DANA berdasarkan realisasi
- Riwayat berversi dan revisi historis
- Savings Rate rencana dan aktual
- Checklist Completion Rate
- Financial Health Score dengan data lengkap dan parsial

#### Finara AI

- Pengambilan dan normalisasi daftar model
- Pencarian dan filter model
- Model favorit dan default
- Model per percakapan
- Input model manual
- Status kemampuan `UNKNOWN`, `CLAIMED`, `VERIFIED`, dan `UNSUPPORTED`
- Pengujian kemampuan terpisah
- Model tidak tersedia dan pergantian model
- Fallback dalam provider yang sama
- Fallback lintas provider tanpa dan dengan izin tujuan
- Multi-provider
- Parameter opsional tidak didukung
- Kemampuan wajib tidak didukung
- Estimasi biaya
- Cache model
- Penyimpanan dan penghapusan API key
- Penyaringan data sensitif
- Redirect endpoint yang berpotensi membocorkan kredensial
- Streaming, timeout, rate limit, dan riwayat chat

Gunakan mock API agar pengujian tidak menggunakan layanan berbayar.

### 61. Ketentuan Hasil Akhir Produk Lengkap

Ketentuan berikut berlaku setelah seluruh fase terkait selesai. Pada fase yang lebih awal, hanya acceptance criteria fitur yang sudah aktif yang diwajibkan.

Aplikasi yang dihasilkan harus:

- Menggunakan nama Finara secara konsisten
- Modern tetapi tidak berlebihan
- Simpel dan mudah dipahami
- Responsif pada Android dan iOS
- Dioptimalkan untuk layar portrait
- Memiliki navigasi sesuai fase aktif
- Menyembunyikan fitur yang belum tersedia
- Memiliki tombol yang berfungsi
- Memiliki loading, success, error, dan empty state
- Tidak memiliki data dummy permanen
- Tidak memiliki API key bawaan
- Mendukung banyak model dari satu API key mulai fase terkait
- Mendukung banyak provider mulai fase terkait
- Tidak mengganti model atau provider secara diam-diam
- Tidak mengarang kemampuan atau harga model
- Tidak melakukan transaksi keuangan
- Menempatkan Pengeluaran Wajib secara terpisah pada Kantong Pengeluaran Wajib Bank Jago dalam perencanaan
- Tidak menghitung Pengeluaran Wajib dua kali dalam Alokasi Bank Jago atau DANA
- Membagi investasi melalui Total Alokasi Investasi dengan rincian Bibit dan Stockbit
- Tidak menghitung transfer ke RDN dan pembelian saham sebagai dua kontribusi
- Memisahkan sumber anggaran dan kanal pembayaran
- Menampilkan basis setiap persentase secara eksplisit
- Menampilkan persentase target dan efektif saat pembulatan aktif
- Membedakan rencana, estimasi, dan realisasi
- Menyimpan riwayat berversi
- Tidak meminta kredensial bank atau platform investasi
- Memiliki kode modular
- Memiliki unit test dan integration test
- Memiliki mock API untuk chatbot pada fase AI
- Memiliki desain visual konsisten

Fokus utama desain Finara:

> **Satu halaman, satu tujuan utama.**

Gunakan progressive disclosure agar pengaturan lanjutan hanya muncul saat diperlukan.

---

## Bagian VIII — Modul Impor Laporan Investasi Bibit

> Mencakup impor dokumen, parsing, validasi, rekonsiliasi, privasi, arsitektur, roadmap, dan integrasi AI untuk data investasi aktual.

### 62. Impor Laporan Investasi Bibit

Tambahkan fitur bernama:

**Impor Laporan Bibit**

Fitur ini memungkinkan pengguna memasukkan laporan investasi dari Bibit ke dalam Finara tanpa menghubungkan akun Bibit secara langsung dan tanpa memberikan kredensial perbankan atau investasi.

Finara tidak boleh meminta:

- Username Bibit
- Password Bibit
- PIN Bibit
- OTP
- Nomor kartu
- Kredensial AKSes KSEI
- Kredensial rekening dana nasabah

Integrasi dilakukan melalui dokumen yang dipilih dan diunggah sendiri oleh pengguna.

### 63. Jenis Dokumen yang Didukung

Dukung impor dokumen berikut sesuai fase:

1. Statement of Account Bibit
2. Transaction History Bibit
3. Tax Report Bibit sebagai fitur lanjutan
4. Laporan Bulanan Reksa Dana AKSes KSEI
5. Laporan Mutasi Reksa Dana AKSes KSEI
6. CSV transaksi, jika format tersedia
7. XLSX, jika format tersedia
8. Gambar atau screenshot dengan OCR sebagai fallback lanjutan
9. Input manual sebagai fallback setiap fase

Format berdasarkan fase:

- **MVP modul:** PDF Statement of Account dan input manual
- **Versi kedua:** Transaction History, laporan KSEI, dan CSV
- **Versi lanjutan:** Tax Report, XLSX, serta gambar atau screenshot dengan OCR

Utamakan pembacaan teks asli PDF. Jangan menggunakan OCR jika PDF sudah memiliki lapisan teks yang dapat dibaca.

### 64. Cara Memasukkan Laporan

Pengguna dapat memasukkan laporan melalui:

- Tombol Pilih File
- File picker perangkat
- Android Share Intent
- iOS Share Extension
- Menu Bagikan dari aplikasi file atau email
- Drag-and-drop pada perangkat yang mendukung
- Impor lampiran email yang telah disimpan pengguna

Tampilkan tombol:

- Impor Laporan Bibit
- Pilih PDF
- Pilih CSV, hanya jika dukungan CSV pada fase aktif telah tersedia
- Masukkan Manual
- Lihat Riwayat Impor

### 65. Alur Impor

Gunakan alur berikut:

1. Pengguna memilih dokumen
2. Finara memeriksa jenis dan ukuran file
3. Finara membaca metadata file
4. Finara mengekstrak teks dan tabel
5. Finara mencoba mengenali jenis laporan
6. Finara menentukan periode laporan
7. Finara memetakan data ke struktur internal
8. Finara menjalankan validasi
9. Finara menampilkan pratinjau
10. Pengguna memperbaiki data yang keliru
11. Pengguna menekan Konfirmasi Impor
12. Finara menyimpan data ke bulan yang sesuai
13. Finara melakukan rekonsiliasi dengan rencana alokasi

Jangan menyimpan hasil secara permanen sebelum pengguna menekan tombol konfirmasi.

### 66. Data yang Diekstrak

Ekstrak data berikut apabila tersedia pada laporan.

#### Informasi Laporan

- Nama sumber laporan
- Jenis laporan
- Periode laporan
- Tanggal pembuatan laporan
- Mata uang
- Nomor referensi dokumen, jika tersedia

#### Ringkasan Portofolio

- Nilai portofolio akhir
- Total modal investasi
- Total pembelian
- Total penjualan
- Keuntungan belum terealisasi
- Kerugian belum terealisasi
- Keuntungan terealisasi
- Kerugian terealisasi
- Persentase profit atau loss
- Saldo kas atau RDN, jika tercantum
- Dividen, jika tercantum
- Kupon, jika tercantum

#### Alokasi Aset

- Reksa dana pasar uang
- Reksa dana pendapatan tetap atau obligasi
- Reksa dana saham
- Reksa dana campuran
- SBN
- Obligasi FR
- Saham
- Saldo RDN
- Produk lainnya

#### Kepemilikan Produk

Untuk setiap produk, simpan:

- Nama produk
- Jenis produk
- Jumlah unit
- Harga rata-rata pembelian
- Nilai aktiva bersih atau harga terakhir
- Total modal
- Nilai pasar
- Keuntungan atau kerugian
- Persentase keuntungan atau kerugian

#### Transaksi

Untuk setiap transaksi, simpan:

- Tanggal transaksi
- Jenis transaksi
- Nama produk
- Nominal
- Jumlah unit
- Harga atau NAB
- Status transaksi
- Keuntungan terealisasi, jika tersedia
- Biaya, jika tersedia
- Catatan sumber data

Jika suatu data tidak tersedia, simpan sebagai `null`. Tampilkan label **Tidak tersedia** hanya pada antarmuka atau ekspor untuk pengguna. Jangan membuat atau memperkirakan nilai yang tidak tercantum.

### 67. Pengenalan Dokumen

Buat sistem document classifier untuk membedakan:

- Statement of Account Bibit
- Transaction History Bibit
- Tax Report Bibit
- Laporan Bulanan KSEI
- Laporan Mutasi KSEI
- Dokumen tidak dikenal

Gunakan kombinasi:

- Nama file
- Judul dokumen
- Kata kunci
- Struktur tabel
- Kolom yang tersedia
- Periode dokumen

Jika tingkat keyakinan rendah, tampilkan:

> Finara belum dapat memastikan jenis laporan ini. Pilih jenis laporan secara manual.

### 68. Parsing PDF

Gunakan proses berikut:

1. Baca lapisan teks PDF
2. Deteksi tabel
3. Gabungkan teks yang terpisah akibat layout PDF
4. Normalisasi spasi
5. Normalisasi angka Rupiah
6. Normalisasi tanggal
7. Kenali angka negatif atau kerugian
8. Kenali tanda persen
9. Cocokkan total dengan rincian
10. Berikan confidence score pada setiap data

Dukung format angka:

- Rp1.000.000
- Rp 1.000.000
- 1,000,000
- 1.000.000
- Angka dalam tanda kurung sebagai nilai negatif
- Tanda minus sebagai nilai negatif

Jangan mengirim PDF ke layanan AI eksternal secara default.

Parsing awal harus dilakukan secara lokal bila memungkinkan. Jika suatu tahap memerlukan layanan eksternal, tampilkan persetujuan terpisah yang menjelaskan data yang akan dikirim; tanpa persetujuan, sediakan koreksi atau input manual sebagai fallback.

### 69. PDF Terproteksi

Jika dokumen PDF dilindungi password:

- Tampilkan input password dokumen
- Gunakan password hanya untuk membuka dokumen pada sesi tersebut
- Jangan menyimpan password
- Jangan mencatat password dalam log
- Lepaskan referensi password dan bersihkan buffer sensitif setelah proses selesai sejauh didukung oleh platform; password tidak boleh dipertahankan di state aplikasi
- Jangan menganggap password PDF sama dengan PIN Bibit

Tampilkan penjelasan:

> Password hanya digunakan pada perangkat untuk membuka dokumen ini dan tidak akan disimpan.

### 70. Pratinjau dan Konfirmasi

Setelah parsing, tampilkan halaman pratinjau.

Bagian pratinjau:

- Sumber laporan
- Periode
- Nilai portofolio
- Modal investasi
- Profit atau loss
- Alokasi aset
- Daftar kepemilikan
- Daftar transaksi
- Data yang gagal dibaca
- Data dengan confidence rendah
- Peringatan ketidaksesuaian

Gunakan status:

- Terbaca dengan baik
- Perlu diperiksa
- Tidak berhasil dibaca
- Tidak tersedia dalam dokumen

Pengguna dapat:

- Mengedit nilai
- Menghapus baris
- Menambah transaksi
- Mengubah kategori produk
- Mengubah periode
- Membatalkan impor
- Mengonfirmasi impor

Tampilkan file asli melalui tombol **Lihat Dokumen Asli** agar pengguna dapat melakukan verifikasi.

### 71. Confidence Score

Setiap nilai hasil ekstraksi memiliki status keyakinan:

- Tinggi
- Sedang
- Rendah

Angka persentase hanya boleh ditampilkan apabila parser mempunyai metode terkalibrasi dan terdokumentasi. Jika menggunakan angka, dasar penilaian minimal mencakup:

- Kecocokan label atau kolom
- Keberhasilan parsing angka
- Kecocokan total dengan rincian
- Konsistensi periode
- Konsistensi struktur dokumen

Pemetaan default jika skor terkalibrasi tersedia:

- Tinggi: 90–100%
- Sedang: 70–89%
- Rendah: di bawah 70%

Data dengan keyakinan rendah harus ditandai dan memerlukan pemeriksaan pengguna. Setelah pengguna mengoreksi nilai, simpan sumber nilai sebagai **Dikoreksi pengguna** dan set confidence parser untuk nilai aktif menjadi `null`; confidence lama boleh dipertahankan hanya pada audit metadata.

Jangan menyembunyikan ketidakpastian hasil parsing.

### 72. Rekonsiliasi Rencana dan Realisasi Bibit

Setelah laporan dikonfirmasi, bandingkan data investasi aktual dengan revisi Alokasi Bibit yang direncanakan pada bulan yang sama.

Rekonsiliasi hanya dapat dihitung jika:

- Target Alokasi Bibit tersedia.
- Total pembelian aktual tersedia dari laporan transaksi yang didukung atau input manual terverifikasi.
- Mata uang target dan aktual sama, secara default IDR.

Hanya transaksi pembelian dengan status normalisasi **SELESAI** atau **SETTLED** yang dihitung. Transaksi pending, gagal, dibatalkan, direfund, atau direversal tidak dihitung sebagai kontribusi aktual.

Tampilkan:

- Target investasi bulan tersebut dan nomor revisinya
- Total transaksi pembelian aktual yang selesai
- Selisih target dan realisasi
- Persentase realisasi
- Penjualan atau pencairan selesai
- Nilai portofolio akhir
- Profit atau loss
- Alokasi aset aktual
- Konsistensi investasi

```text
Realisasi Kontribusi =
Total Transaksi Pembelian Aktual Berstatus Selesai
```

```text
Arus Investasi Bersih =
Total Transaksi Pembelian Aktual Berstatus Selesai
- Total Transaksi Penjualan atau Pencairan Berstatus Selesai
```

```text
Selisih Kontribusi =
Realisasi Kontribusi
- Target Alokasi Bibit
```

```text
Persentase Realisasi Target =
Realisasi Kontribusi
/ Target Alokasi Bibit
× 100%
```

Kategori:

- Belum tercapai: di bawah 80%
- Mendekati target: 80% sampai kurang dari 100%
- Sesuai target: 100% sampai 110%
- Melebihi target: di atas 110%
- Tidak dapat dibandingkan: target nol, mata uang berbeda, pembelian aktual tidak tersedia, atau periode tidak dapat dipetakan

Statement of Account yang tidak memuat transaksi pembelian tidak boleh dipakai untuk mengarang Realisasi Kontribusi. Pada MVP, tampilkan **Tidak dapat dibandingkan** atau minta input pembelian manual.

### 73. Hindari Double Counting

Satu transaksi atau laporan tidak boleh dimasukkan lebih dari satu kali.

Buat fingerprint dokumen berdasarkan:

- Hash file
- Periode
- Jenis laporan
- Nomor referensi
- Kombinasi data utama

Sebelum menyimpan, periksa:

- Apakah file pernah diimpor
- Apakah transaksi yang sama sudah tersimpan
- Apakah snapshot periode dan sumber yang sama sudah ada

Statement of Account dan Transaction History pada periode yang sama dapat saling melengkapi dan tidak otomatis dianggap duplikat karena jenis datanya berbeda.

Jika ditemukan potensi duplikasi, tampilkan:

> Laporan atau transaksi serupa sudah pernah diimpor.

Pilihan:

- Batalkan
- Ganti data lama
- Gabungkan data
- Tinjau perbedaan

Aturan gabung:

- Snapshot portofolio dan transaksi disimpan sebagai entitas berbeda.
- Transaksi digabung berdasarkan fingerprint transaksi.
- Nilai konflik tidak ditimpa otomatis.
- Sumber yang diganti diberi status `superseded` dan tetap tersedia pada audit trail.
- Data manual dapat diganti oleh data laporan terverifikasi hanya setelah persetujuan pengguna.

### 74. Halaman Investasi Aktual Bibit

Tambahkan bagian **Investasi Aktual Bibit** pada menu Progres.

Tampilkan:

- Nilai portofolio terakhir
- Modal investasi
- Total pembelian Bibit bulan berjalan
- Total penjualan atau pencairan Bibit
- Profit atau loss
- Return persentase dari laporan, jika tersedia
- Estimasi return sederhana, hanya jika dihitung oleh Finara dan diberi label terpisah
- Alokasi aset
- Riwayat nilai portofolio
- Perbandingan target dan realisasi
- Tanggal pembaruan terakhir
- Sumber data terakhir

Gunakan chart sederhana:

- Line chart nilai portofolio
- Bar chart target versus realisasi
- Donut chart alokasi aset
- Progress bar pencapaian investasi

Berikan label:

> Berdasarkan laporan terakhir yang diimpor pada [tanggal].

Jangan menyebut data sebagai real-time.

### 75. Integrasi dengan Sub-card Bibit

Perbarui Sub-card Bibit di dalam Card Investasi pada hasil alokasi.

#### Rencana Bulan Ini

- Target transfer ke Bibit
- Persentase alokasi
- Tanggal rencana top-up

#### Realisasi Terakhir

- Nominal pembelian aktual
- Nilai portofolio terakhir
- Profit atau loss
- Persentase realisasi target
- Periode laporan terakhir

Sediakan tombol:

- Impor Laporan
- Lihat Portofolio
- Bandingkan Rencana
- Tanya Finara AI

### 76. Integrasi dengan Riwayat Bulanan

Pada setiap riwayat bulan, simpan:

- ID revisi target Alokasi Bibit
- Target Alokasi Bibit
- Realisasi pembelian selesai
- Realisasi penjualan selesai
- Nilai portofolio akhir
- Profit atau loss
- Alokasi aset
- Mata uang
- Nama file sumber
- Tanggal impor
- Status verifikasi
- Catatan pengguna

Pisahkan dengan jelas:

- Nilai yang direncanakan Finara
- Nilai aktual dari laporan
- Nilai yang dimasukkan manual
- Nilai hasil koreksi pengguna
- Nilai yang telah digantikan atau `superseded`

Mengedit rencana bulan lama harus membuat revisi baru. Rekonsiliasi historis tetap menunjuk ke revisi yang digunakan ketika rekonsiliasi dibuat, kecuali pengguna memilih menghitung ulang secara eksplisit.

### 77. Analisis Finara AI terhadap Laporan

Tambahkan tombol:

**Analisis dengan Finara AI**

Sebelum mengirim data, tampilkan izin dan ringkasan data yang akan dikirim.

Finara AI dapat membantu:

- Menjelaskan perubahan nilai portofolio
- Membandingkan target dan realisasi investasi Bibit
- Menjelaskan alokasi aset
- Menilai konsistensi investasi
- Mengidentifikasi konsentrasi aset
- Menjelaskan profit dan loss
- Menyusun pertanyaan evaluasi bulanan
- Membuat simulasi kontribusi berikutnya

Finara AI tidak boleh:

- Mengklaim mengetahui harga pasar real-time jika tidak ada data real-time
- Menjanjikan keuntungan
- Menyarankan pembelian aset tertentu sebagai kepastian
- Menganggap hasil parsing selalu benar
- Mengubah data tanpa persetujuan
- Menerima dokumen lengkap tanpa izin pengguna

Secara default, kirim data terstruktur hasil konfirmasi, bukan file PDF mentah.

### 78. Privasi Dokumen

Terapkan aturan:

- Dokumen disimpan lokal secara default
- Pengguna dapat memilih apakah file asli disimpan
- Data tidak dikirim ke AI tanpa persetujuan
- File tidak dimasukkan ke backup biasa jika berisi data sensitif, kecuali pengguna mengaktifkan backup terenkripsi
- Dokumen dapat dihapus tanpa menghapus seluruh riwayat investasi
- Riwayat hasil ekstraksi dapat dihapus
- Jangan menyimpan password PDF
- Jangan menyimpan kredensial Bibit atau KSEI
- Jangan mencatat isi laporan dalam analytics
- Jangan mencatat data portofolio dalam crash log

Sediakan:

- Hapus File Asli
- Hapus Data Hasil Impor
- Hapus Semua Laporan Investasi
- Nonaktifkan Analisis AI
- Kelola Izin Data

### 79. Input Manual sebagai Fallback

Jika laporan gagal dibaca, pengguna dapat memasukkan:

- Bulan laporan
- Nilai portofolio
- Modal investasi
- Profit atau loss
- Pembelian bulan tersebut
- Penjualan bulan tersebut
- Alokasi aset
- Catatan

Tandai data sebagai:

**Dimasukkan manual**

Data manual dapat diedit dan diganti kemudian dengan hasil impor laporan.

### 80. Struktur Data Tambahan

Tambahkan struktur:

- InvestmentReportImport
- InvestmentReportFile
- InvestmentPortfolioSnapshot
- InvestmentHolding
- InvestmentTransaction
- InvestmentAssetAllocation
- InvestmentImportField
- InvestmentImportValidation
- InvestmentReconciliation
- InvestmentDocumentFingerprint

Contoh properti `InvestmentReportImport`:

- id
- source
- sourcePlatform, bernilai `BIBIT` untuk modul ini
- reportType
- reportPeriod
- importedAt
- originalFileName
- fileHash
- parsingStatus
- verificationStatus
- overallConfidence
- isOriginalFileStored
- userNotes

Contoh properti `InvestmentPortfolioSnapshot`:

- period
- portfolioValue
- investedCapital
- unrealizedGainLoss
- realizedGainLoss
- cashBalance
- totalPurchases
- totalSales
- returnPercentage
- sourceReportId

### 81. Arsitektur Impor Laporan

Pisahkan modul:

- DocumentPickerService
- ShareIntentService
- InvestmentReportImportService
- InvestmentDocumentClassifier
- PDFTextExtractor
- PDFTableExtractor
- CSVParser
- FinancialNumberNormalizer
- DateNormalizer
- InvestmentReportMapper
- ImportConfidenceCalculator
- InvestmentReportValidator
- DuplicateDetectionService
- InvestmentReconciliationService
- SecureDocumentStorage
- InvestmentReportRepository

Jangan menaruh proses parsing langsung di UI.

Gunakan worker atau isolate agar parsing dokumen besar tidak membekukan antarmuka.

### 82. Validasi Laporan

Periksa:

- Total kepemilikan terhadap nilai portofolio
- Total alokasi aset terhadap 100% dengan toleransi default ±0,5 poin persentase
- Periode laporan valid
- Nilai angka tidak rusak
- Nilai negatif dibaca dengan benar
- Data transaksi tidak terduplikasi
- Status transaksi dinormalisasi
- Tanggal transaksi berada dalam periode yang sesuai
- Nilai target Finara tidak tertukar dengan nilai aktual
- Mata uang dikenali
- Dokumen berasal dari jenis laporan yang didukung

Aturan mata uang:

- Rekonsiliasi otomatis hanya dilakukan jika target dan aktual menggunakan mata uang yang sama.
- Data non-IDR disimpan dengan kode mata uangnya dan tidak dijumlahkan langsung dengan IDR.
- Konversi hanya dilakukan jika pengguna memasukkan kurs, tanggal kurs, dan sumber kurs secara eksplisit.

Jika terdapat selisih, tampilkan:

> Total rincian tidak sama dengan ringkasan laporan. Periksa kembali data sebelum menyimpan.

Jangan memaksa data tidak konsisten menjadi seimbang dengan mengubah angka secara otomatis.

### 83. Error Handling Impor

Tangani:

- Format file tidak didukung
- File rusak
- File kosong
- PDF terproteksi
- Password PDF salah
- Teks tidak dapat dibaca
- Tabel tidak dikenali
- Periode tidak ditemukan
- Dokumen bukan laporan investasi
- Dokumen duplikat
- Penyimpanan perangkat penuh
- Proses impor dibatalkan
- Parsing berhenti

Sediakan tindakan:

- Coba lagi
- Pilih file lain
- Masukkan password
- Pilih jenis laporan manual
- Masukkan data manual
- Lihat detail error
- Laporkan masalah tanpa menyertakan dokumen

### 84. Prioritas Pengembangan Fitur Laporan Bibit

#### MVP

Bangun:

1. Pemilihan PDF
2. Impor Statement of Account Bibit
3. Ekstraksi teks PDF
4. Deteksi periode
5. Pembacaan nilai portofolio
6. Pembacaan modal dan profit atau loss
7. Pratinjau hasil
8. Koreksi manual
9. Konfirmasi pengguna
10. Penyimpanan snapshot bulanan
11. Rekonsiliasi hanya jika total pembelian tersedia; jika tidak, tampilkan **Tidak dapat dibandingkan**
12. Input pembelian manual terverifikasi sebagai fallback rekonsiliasi
13. Pencegahan duplikasi
14. Penyimpanan lokal
15. Penghapusan dokumen
16. Input manual sebagai fallback

#### Versi Kedua

Tambahkan:

1. Transaction History
2. Parsing daftar transaksi dan status transaksi
3. Rekonsiliasi transaksi penuh
4. Alokasi aset
5. Kepemilikan per produk
6. Laporan AKSes KSEI
7. Share Intent Android
8. Share Extension iOS
9. Analisis Finara AI
10. CSV import

#### Versi Lanjutan

Tambahkan:

1. Tax Report Bibit
2. XLSX import
3. Gambar atau screenshot dengan OCR sebagai fallback
4. Integrasi API Bibit resmi, hanya jika akses resmi tersedia
5. Sinkronisasi portofolio dengan persetujuan pengguna
6. Pembaruan otomatis melalui mekanisme resmi
7. Webhook atau mekanisme sinkronisasi resmi
8. Rekonsiliasi multi-platform investasi

Jangan melakukan scraping atau reverse engineering aplikasi Bibit.

### 85. Ketentuan Akhir Fitur Laporan

Pastikan:

- Finara tidak meminta login Bibit
- Finara tidak meminta PIN Bibit
- Finara tidak mengklaim terafiliasi dengan Bibit
- Data tidak disebut real-time
- Pengguna selalu memverifikasi hasil parsing
- File PDF tidak dikirim ke AI secara default
- Nilai yang tidak tersedia tidak dibuat-buat
- Data target dan aktual dipisahkan
- Dokumen duplikat dapat dideteksi
- File dan data dapat dihapus
- Semua informasi sensitif disimpan secara aman

---

## Bagian IX — Modul Pembagian Saldo DANA dan DANA+

> Memperluas alokasi DANA menjadi saldo transaksi dan saldo DANA+, termasuk rekomendasi, realisasi, simulasi reward, arsitektur, dan pengujian.

### 86. Pembagian Internal Alokasi DANA

Perluas fitur alokasi DANA agar total dana yang dialokasikan ke platform DANA dibagi lagi menjadi:

1. **Saldo DANA Biasa**
2. **Saldo DANA+**

Tujuan pembagian:

- Saldo DANA Biasa digunakan sebagai buffer transaksi cepat dan pengeluaran terdekat.
- Saldo DANA+ digunakan untuk porsi anggaran DANA yang sementara ditempatkan pada fitur saldo bertumbuh.
- Saldo DANA+ tetap merupakan bagian dari Alokasi DANA dan tidak otomatis diklasifikasikan sebagai tabungan, investasi, atau pendapatan.
- Pengguna tetap memiliki kendali penuh atas persentase dan nominal pembagian.
- Finara hanya membuat perencanaan dan instruksi manual, bukan memindahkan saldo secara otomatis.

Gunakan istilah **Saldo DANA Biasa** dan **Saldo DANA+** secara konsisten agar pengguna tidak salah memahami total alokasi DANA.

Total pembagian internal harus selalu memenuhi:

```text
Total Alokasi DANA =
Saldo DANA Biasa
+ Saldo DANA+
```

### 87. Mode Pembagian DANA dan DANA+

Sebelum menghitung pembagian internal, tentukan strategi eksekusi top-up:

1. **Top-up seluruh Alokasi DANA sekaligus**, lalu bagi ke Saldo DANA Biasa dan Saldo DANA+.
2. **Bagi setiap top-up**, yaitu setiap top-up periodik dibagi dengan mode yang dipilih.
3. **Hitung ulang Smart Liquidity pada setiap top-up**, menggunakan sisa anggaran dan kebutuhan sampai top-up berikutnya.

Tampilkan terpisah:

- Target pembagian bulanan
- Nominal yang dapat dieksekusi pada top-up berikutnya
- Total yang sudah dieksekusi pada bulan aktif

#### Mode 1: Smart Liquidity

Gunakan sebagai pilihan default.

Finara menghitung kebutuhan Saldo DANA Biasa berdasarkan sisa anggaran sampai horizon berikutnya, transaksi terjadwal yang belum tercakup, dan buffer keamanan.

```text
Hari Horizon =
minimum(
  7,
  Jumlah Hari Tersisa dalam Periode Anggaran,
  Jumlah Hari sampai Top-up Berikutnya jika tersedia
)
```

```text
Anggaran Horizon =
Sisa Anggaran Uang Jajan Aktual
/ Jumlah Hari Tersisa dalam Periode
× Hari Horizon
```

```text
Kebutuhan DANA Biasa =
Anggaran Horizon
+ Transaksi DANA Terjadwal dalam Horizon yang Belum Termasuk Anggaran
+ Buffer Keamanan
```

Transaksi terjadwal tidak boleh ditambahkan kembali jika nominalnya sudah termasuk dalam anggaran harian atau merupakan Pengeluaran Wajib dari Kantong Pengeluaran Wajib.

```text
Target Saldo DANA+ =
Total Alokasi DANA yang Belum Dialokasikan
- Kebutuhan DANA Biasa
```

Jika kebutuhan DANA Biasa lebih besar daripada dana yang tersedia:

```text
Saldo DANA Biasa = Dana DANA yang Tersedia
Saldo DANA+ = Rp0
```

Jangan menghasilkan nilai negatif.

#### Mode 2: Persentase

Pengguna menentukan persentase Saldo DANA Biasa dan Saldo DANA+. Total persentase wajib tepat 100%.

```text
Saldo DANA Biasa =
Dana DANA yang Dieksekusi
× Persentase DANA Biasa
```

```text
Saldo DANA+ =
Dana DANA yang Dieksekusi
- Saldo DANA Biasa
```

Saldo DANA+ menjadi komponen residual sebelum pembulatan internal diterapkan kembali sesuai Bagian 91.

#### Mode 3: Nominal Tetap DANA Biasa

```text
Saldo DANA Biasa =
minimum(Nominal Buffer Pengguna, Dana DANA yang Dieksekusi)
```

```text
Saldo DANA+ =
Dana DANA yang Dieksekusi
- Saldo DANA Biasa
```

#### Mode 4: Nominal Tetap DANA+

```text
Saldo DANA+ =
minimum(Target DANA+ Pengguna, Dana DANA yang Dieksekusi)
```

```text
Saldo DANA Biasa =
Dana DANA yang Dieksekusi
- Saldo DANA+
```

#### Mode 5: Manual

Pengguna mengetik nominal Saldo DANA Biasa dan Saldo DANA+ secara langsung. Tombol simpan hanya aktif jika jumlahnya sama dengan dana DANA yang sedang dieksekusi.

### 88. Input Pengaturan DANA+

Tambahkan pengaturan pada:

**Pengaturan → Strategi Alokasi → DANA dan DANA+**

Sediakan input:

- Status penggunaan DANA+
- Mode pembagian default
- Strategi eksekusi top-up
- Persentase DANA Biasa
- Persentase DANA+
- Nominal buffer DANA Biasa
- Target nominal DANA+
- Hari top-up DANA
- Frekuensi top-up
- Transaksi terjadwal yang menggunakan DANA
- Batas saldo DANA+ yang diketahui pengguna, opsional
- Estimasi reward atau imbal hasil, opsional
- Tanggal terakhir ketentuan diperiksa
- Catatan pengguna

Setiap transaksi terjadwal memiliki:

- Nominal
- Tanggal jatuh tempo
- Sumber anggaran
- `includedInDailyBudget`
- Status eksekusi

Pilihan status penggunaan DANA+:

- Saya menggunakan DANA+
- Saya belum menggunakan DANA+
- Fitur DANA+ belum tersedia di akun saya
- Saya tidak ingin menggunakan DANA+

Jika pengguna tidak menggunakan DANA+:

```text
Saldo DANA Biasa = Dana DANA yang Dieksekusi
Saldo DANA+ = Rp0
```

Jangan memaksa pengguna mengaktifkan DANA+.

Jangan menanam secara permanen:

- Persentase reward
- Batas saldo
- Syarat aktivasi
- Minimum saldo
- Jenis transaksi yang didukung

Ketentuan produk dapat berubah. Nilai tersebut harus berasal dari input pengguna, konfigurasi yang dapat diperbarui, atau sumber resmi yang terverifikasi.

### 89. Rekomendasi Pembagian Otomatis

Finara dapat memberikan rekomendasi, tetapi tidak boleh menentukan pembagian secara absolut.

Gunakan faktor berikut:

- Total Alokasi DANA Bulanan
- Dana DANA yang tersedia pada top-up saat ini
- Sisa anggaran uang jajan aktual
- Hari horizon sampai maksimal tujuh hari atau top-up berikutnya
- Transaksi terjadwal non-wajib dalam horizon
- Frekuensi top-up
- Kebutuhan buffer
- Status ketersediaan DANA+
- Batas DANA+ yang dimasukkan pengguna
- Preferensi likuiditas pengguna

Contoh rekomendasi:

> Untuk top-up berikutnya, pertahankan Rp250.000 pada Saldo DANA Biasa untuk kebutuhan sampai jadwal top-up selanjutnya dan pindahkan Rp150.000 ke Saldo DANA+.

Setiap rekomendasi harus menampilkan alasan:

- Horizon perhitungan
- Sisa anggaran transaksi dalam horizon
- Jumlah tagihan terdekat yang belum termasuk anggaran
- Buffer keamanan
- Dana yang belum diperlukan segera

Sediakan tombol:

- Gunakan Rekomendasi
- Sesuaikan Pembagian
- Tetap Gunakan Pembagian Saya

### 90. Validasi Pembagian DANA+

Terapkan validasi untuk target bulanan dan setiap eksekusi top-up.

#### Target Bulanan

- Target Saldo DANA Biasa tidak boleh negatif
- Target Saldo DANA+ tidak boleh negatif
- Total target bulanan harus sama dengan Total Alokasi DANA Bulanan
- Total persentase wajib 100%

#### Eksekusi Top-up

- Nominal DANA Biasa pada eksekusi tidak boleh negatif
- Nominal DANA+ pada eksekusi tidak boleh negatif
- Jumlah keduanya harus sama dengan nominal top-up yang sedang dieksekusi
- Akumulasi seluruh eksekusi pada bulan aktif tidak boleh melebihi Total Alokasi DANA Bulanan
- Pada mode nominal tetap, target yang melebihi dana eksekusi dibatasi ke dana eksekusi dan disertai peringatan
- Pada mode manual, jumlah yang tidak sama dengan dana eksekusi merupakan error dan tidak boleh disimpan
- DANA+ harus Rp0 jika fitur tidak tersedia atau dinonaktifkan
- Nilai reward tidak boleh negatif
- Batas saldo DANA+ yang dimasukkan pengguna tidak boleh diabaikan
- Selisih pembulatan dimasukkan ke Saldo DANA Biasa

Jika target DANA+ membuat saldo akhir melampaui batas pengguna:

```text
DANA+ yang Dapat Ditambahkan =
maksimum(
  0,
  Batas DANA+ Pengguna - Saldo Awal DANA+
)
```

```text
Kelebihan =
Target Pemindahan DANA+ Eksekusi
- DANA+ yang Dapat Ditambahkan
```

Kelebihan dialihkan ke Saldo DANA Biasa dan pengguna diberi penjelasan:

> Target pemindahan ke DANA+ melebihi ruang saldo berdasarkan batas yang Anda masukkan. Selisih tetap berada pada Saldo DANA Biasa.

### 91. Pembulatan Pembagian DANA

Gunakan pengaturan pembulatan global Finara:

- Tanpa pembulatan
- Kelipatan Rp1.000
- Kelipatan Rp5.000
- Kelipatan Rp10.000

Pembulatan internal dapat diterapkan pada target bulanan atau nominal top-up yang sedang dieksekusi. Gunakan basis yang sesuai dan jangan mencampur keduanya.

Urutan:

1. Tentukan `Dana Dasar Pembagian`, yaitu Total Alokasi DANA Bulanan untuk target bulanan atau Nominal Top-up untuk eksekusi saat ini.
2. Hitung target Saldo DANA+.
3. Batasi Saldo DANA+ terhadap Dana Dasar Pembagian dan ruang batas pengguna, jika ada.
4. Bulatkan Saldo DANA+ ke bawah pada kelipatan terpilih.
5. Terapkan kembali batas sebagai pemeriksaan akhir.
6. Hitung Saldo DANA Biasa sebagai residual.

```text
Saldo DANA Biasa =
Dana Dasar Pembagian
- Saldo DANA+ Setelah Pembulatan
```

Metode ini memastikan:

- Tidak ada selisih total
- Saldo DANA+ tidak melampaui batas
- Nominal top-up periodik tidak keliru menggunakan target bulanan penuh
- Saldo DANA Biasa menyerap sisa pembulatan

### 92. Tampilan Card DANA yang Diperbarui

Perbarui Card DANA agar menampilkan:

#### Ringkasan Utama

- Total Alokasi DANA Bulanan — Rencana
- Sisa Alokasi DANA yang Belum Dieksekusi
- Nominal top-up berikutnya
- Anggaran uang jajan per hari
- Jadwal top-up berikutnya

#### Pembagian Saldo

- Target bulanan Saldo DANA Biasa
- Target bulanan Saldo DANA+
- Pembagian untuk top-up berikutnya
- Persentase masing-masing
- Mode pembagian dan strategi eksekusi
- Buffer kebutuhan horizon
- Tanggal perhitungan terakhir

Gunakan visual sederhana:

- Progress bar dua bagian
- Donut chart kecil
- Label nominal yang jelas

Jangan hanya menggunakan perbedaan warna. Tambahkan label dan ikon.

Sediakan tombol:

- Ubah Pembagian
- Salin Nominal DANA
- Salin Nominal DANA+
- Lihat Jadwal
- Tanya Finara AI, jika fase AI aktif

Jika DANA+ tidak aktif, sembunyikan rincian yang tidak relevan dan tampilkan:

> Seluruh dana DANA yang dieksekusi ditempatkan pada Saldo DANA Biasa.

### 93. Checklist Eksekusi DANA dan DANA+

Instruksi harus mengikuti strategi eksekusi pengguna.

Contoh untuk top-up berikutnya:

- [ ] Top-up Rp[Nominal Top-up Berikutnya]
- [ ] Pertahankan Rp[Nominal DANA Biasa Top-up Ini] pada Saldo DANA Biasa
- [ ] Pindahkan Rp[Nominal DANA+ Top-up Ini] ke Saldo DANA+ jika tersedia
- [ ] Periksa bahwa total nominal top-up telah terbagi sesuai rencana
- [ ] Catat nominal pemindahan aktual periode berjalan

Untuk top-up seluruh saldo sekaligus, gunakan Total Alokasi DANA bulanan. Untuk top-up mingguan atau harian, jangan meminta pengguna mengeksekusi target bulanan penuh sebelum dana tersebut ditop-up.

Jangan mengklaim Finara telah melakukan top-up atau pemindahan saldo. Checklist hanya berupa instruksi manual yang harus dikonfirmasi pengguna.

### 94. Pelacakan Realisasi DANA+

Tambahkan status realisasi:

- Belum dieksekusi
- Sebagian selesai
- Selesai
- Tidak sesuai rencana
- Dibatalkan

Jangan menggunakan saldo akun sebagai satu-satunya realisasi target, karena saldo dapat berasal dari bulan sebelumnya, reward, pengeluaran, atau pemindahan lain.

Pengguna dapat mencatat ledger periode berjalan:

- Saldo awal DANA Biasa
- Saldo awal DANA+
- Total top-up periode ini
- Total pemindahan ke DANA+ periode ini
- Total pemindahan keluar dari DANA+ periode ini
- Pengeluaran dari DANA Biasa
- Pengeluaran dari DANA+
- Reward aktual
- Saldo akhir
- Tanggal dan catatan

```text
Saldo Akhir DANA Biasa =
Saldo Awal DANA Biasa
+ Top-up ke DANA Biasa
+ Pemindahan Keluar dari DANA+
- Pengeluaran dari DANA Biasa
- Pemindahan ke DANA+
```

```text
Saldo Akhir DANA+ =
Saldo Awal DANA+
+ Pemindahan ke DANA+
+ Reward Aktual
- Pengeluaran dari DANA+
- Pemindahan Keluar dari DANA+
```

Realisasi target periode:

```text
Realisasi DANA+ =
Total Pemindahan ke DANA+ pada Bulan Aktif
```

```text
Selisih Realisasi DANA+ =
Realisasi DANA+
- Target Pemindahan DANA+ Bulan Aktif
```

Pisahkan dengan jelas:

- Target pemindahan
- Realisasi pemindahan
- Saldo akun
- Estimasi reward
- Reward aktual

Reward aktual hanya boleh dicatat setelah dimasukkan atau dikonfirmasi pengguna dan tidak otomatis mengubah alokasi bulan yang sudah disimpan.

### 95. Estimasi Pertumbuhan DANA+

Estimasi pertumbuhan bersifat opsional dan hanya ditampilkan jika pengguna memasukkan tingkat reward atau imbal hasil.

Sediakan input:

- Tingkat estimasi
- Satuan tingkat:
  - Per hari
  - Per bulan
  - Per tahun
- Metode:
  - Sederhana
  - Majemuk, jika sesuai
- Periode simulasi

Tampilkan:

- Saldo awal
- Estimasi pertumbuhan
- Estimasi saldo akhir
- Asumsi yang digunakan
- Tanggal input tingkat terakhir

Gunakan disclaimer:

> Perhitungan ini hanya simulasi berdasarkan tingkat yang Anda masukkan. Reward, ketentuan, batas saldo, dan ketersediaan DANA+ dapat berubah mengikuti kebijakan penyedia.

Jangan:

- Mengambil tingkat lama sebagai tingkat saat ini
- Menjamin reward
- Menyebut estimasi sebagai bunga pasti
- Memasukkan reward estimasi ke penghasilan aktual
- Mengubah alokasi utama berdasarkan reward tanpa persetujuan

### 96. Integrasi Finara AI untuk DANA+

Finara AI dapat membantu:

- Menjelaskan pembagian DANA Biasa dan DANA+
- Menghitung buffer transaksi tujuh hari
- Menilai apakah saldo DANA Biasa mencukupi
- Membandingkan beberapa skenario pembagian
- Menjelaskan selisih target dan realisasi
- Membantu mengatur jadwal top-up
- Menjelaskan asumsi estimasi reward

Finara AI tidak boleh:

- Menganggap DANA+ tersedia untuk semua pengguna
- Mengarang reward atau batas saldo
- Mengklaim data real-time tanpa sumber
- Menjamin saldo akan bertumbuh
- Mengaktifkan atau memindahkan dana secara otomatis
- Meminta PIN, OTP, atau kredensial DANA

Konteks yang dapat dikirim setelah izin pengguna:

- Total alokasi DANA
- Target DANA Biasa
- Target DANA+
- Anggaran uang jajan tujuh hari
- Anggaran uang jajan harian
- Transaksi terjadwal yang belum termasuk dalam anggaran harian
- Batas yang dimasukkan pengguna
- Realisasi pembagian
- Tingkat estimasi yang dimasukkan pengguna

### 97. Struktur Data Tambahan DANA+

Tambahkan struktur:

- DanaAllocationPlan
- DanaPlusConfiguration
- DanaInternalSplit
- DanaScheduledExpense
- DanaAllocationExecution
- DanaBalanceLedger
- DanaPlusRewardEstimate
- DanaPlusActualReward
- DanaSplitRecommendation

Contoh properti `DanaInternalSplit`:

- id
- monthlyAllocationRevisionId
- totalMonthlyDanaAllocation
- executionStrategy
- currentExecutionAmount
- targetRegularDanaAmount
- targetDanaPlusAmount
- currentRegularDanaAmount
- currentDanaPlusAmount
- regularDanaPercentage
- danaPlusPercentage
- allocationMode
- roundingMode
- calculatedAt
- userConfirmedAt
- executionStatus

Contoh properti `DanaPlusConfiguration`:

- isEnabled
- availabilityStatus
- defaultSplitMode
- executionStrategy
- regularBalanceBuffer
- danaPlusTarget
- userDefinedLimit
- estimatedRewardRate
- rewardRatePeriod
- termsLastCheckedAt
- userNotes

Contoh properti `DanaBalanceLedger`:

- period
- openingRegularBalance
- openingDanaPlusBalance
- regularTopUp
- transferToDanaPlus
- transferFromDanaPlus
- regularSpending
- danaPlusSpending
- actualReward
- closingRegularBalance
- closingDanaPlusBalance

### 98. Arsitektur Pembagian DANA+

Pisahkan modul:

- DanaAllocationService
- DanaSplitCalculationService
- DanaLiquidityRequirementService
- DanaScheduledExpenseRepository
- DanaPlusConfigurationRepository
- DanaSplitValidationService
- DanaSplitRecommendationService
- DanaAllocationExecutionRepository
- DanaPlusRewardSimulationService

Jangan menaruh perhitungan langsung di komponen UI.

Semua hasil harus dapat diuji secara deterministik.

### 99. Pengujian Pembagian DANA+

Tambahkan unit test untuk:

- Smart Liquidity
- Pembagian persentase
- Nominal tetap DANA Biasa
- Nominal tetap DANA+
- Mode manual
- Total persentase tidak 100%
- Target melebihi total DANA
- Batas DANA+ pengguna
- DANA+ tidak tersedia
- Selisih pembulatan
- Total alokasi sangat kecil
- Total alokasi nol
- Transaksi tujuh hari lebih besar dari total alokasi
- Transaksi terjadwal yang sudah termasuk anggaran harian tidak dihitung dua kali
- Pengeluaran wajib yang dibayar melalui DANA tidak dihitung sebagai uang jajan
- Perbandingan target pemindahan dan realisasi pemindahan
- Saldo awal tidak dianggap sebagai realisasi periode berjalan
- Top-up mingguan tidak mengeksekusi target bulanan penuh
- Horizon Smart Liquidity pada akhir bulan
- Simulasi reward
- Reward tidak dimasukkan sebagai pendapatan aktual

Pastikan invariannya selalu berlaku:

```text
Target Bulanan Saldo DANA Biasa
+ Target Bulanan Saldo DANA+
= Total Alokasi DANA Bulanan
```

```text
Nominal DANA Biasa pada Eksekusi
+ Nominal DANA+ pada Eksekusi
= Nominal Top-up yang Dieksekusi
```

```text
Akumulasi Nominal Top-up yang Dieksekusi
≤ Total Alokasi DANA Bulanan
```

### 100. Ketentuan Akhir Pembagian DANA+

Pastikan:

- Pengguna dapat memilih berapa dana yang masuk ke DANA Biasa dan DANA+
- Smart Liquidity tersedia sebagai mode default
- Seluruh nilai tetap dapat diubah pengguna
- DANA+ tidak dianggap tersedia untuk semua akun
- Tidak ada tingkat reward atau batas saldo yang di-hard-code
- Total pembagian selalu konsisten
- Finara tidak melakukan pemindahan saldo
- Checklist hanya berupa instruksi manual
- Estimasi reward ditandai sebagai simulasi
- Data aktual dipisahkan dari target
- Pengguna dapat menonaktifkan DANA+ sepenuhnya
- Desain tetap simpel, modern, dan responsif

---


## Bagian X — Modul Pembagian Investasi Bibit dan Stockbit

> Mengubah investasi menjadi kategori induk, membagi target antara Bibit dan Stockbit, memisahkan kontribusi dari penggunaan dana, serta mengatur pencatatan, impor, rekonsiliasi, privasi, arsitektur, roadmap, dan pengujian Stockbit.

### 101. Tujuan Modul Stockbit

Tambahkan dukungan **Stockbit** sebagai platform investasi di samping Bibit.

Modul ini bertujuan untuk:

- Membagi Total Alokasi Investasi antara Bibit dan Stockbit.
- Menentukan target kontribusi bulanan setiap platform.
- Memisahkan transfer ke RDN, saldo kas investasi, pembelian, penjualan, biaya, dan nilai portofolio.
- Memantau target dan realisasi Stockbit tanpa menghubungkan akun secara langsung.
- Mengimpor laporan atau riwayat transaksi secara bertahap.
- Mencegah double counting antara deposit RDN, pembelian saham, hasil penjualan, dan nilai portofolio.

Finara tetap hanya melakukan perhitungan, pencatatan, simulasi, dan instruksi manual. Finara tidak melakukan transfer ke RDN, membeli atau menjual saham, menggunakan margin, atau mengirim order.

### 102. Model Pembagian Investasi Dua Tingkat

Gunakan dua tingkat pembagian.

#### Tingkat Pertama — Pembagian Dana Bersih

```text
Dana Bersih =
Alokasi Bank Jago dari Dana Bersih
+ Total Alokasi Investasi
+ Alokasi DANA
```

#### Tingkat Kedua — Pembagian Total Alokasi Investasi

```text
Total Alokasi Investasi =
Alokasi Bibit
+ Alokasi Stockbit
```

Ketentuan:

- Total persentase tingkat pertama wajib tepat 100%.
- Total persentase internal investasi wajib tepat 100%.
- Jika Total Alokasi Investasi bernilai nol, Alokasi Bibit dan Alokasi Stockbit harus nol.
- Jika hanya satu platform aktif, platform tersebut menerima 100% dari Total Alokasi Investasi.
- Platform baru pada masa mendatang harus ditambahkan sebagai sub-platform investasi, bukan sebagai kategori utama baru, kecuali aturan bisnis diubah secara eksplisit.

### 103. Rumus dan Invarian Stockbit

```text
Alokasi Bibit Mentah =
Total Alokasi Investasi
× Persentase Bibit
```

```text
Alokasi Stockbit Mentah =
Total Alokasi Investasi
× Persentase Stockbit
```

```text
Kas Pegangan BRImo
+ Total Dana Masuk ke Bank Jago
+ Total Alokasi Investasi
+ Alokasi DANA
= Total Pendapatan
```

```text
Total Alokasi Investasi
= Alokasi Bibit
+ Alokasi Stockbit
```

Seluruh invarian harus dipenuhi setelah pembulatan. Hasil tidak boleh disimpan apabila salah satu invarian gagal.

### 104. Preset Pembagian Investasi

Gunakan nilai default berikut sebagai konfigurasi awal yang dapat diubah pengguna:

| Preset | Bibit | Stockbit |
|---|---:|---:|
| Standard Hybrid | 70% | 30% |
| Investor Fokus | 50% | 50% |
| Pelajar atau Mahasiswa | 80% | 20% |
| Konservatif | 85% | 15% |

Ketentuan:

- Persentase dihitung terhadap Total Alokasi Investasi, bukan Dana Bersih atau Total Pendapatan.
- Pengguna dapat mengubah seluruh nilai.
- Preset bukan rekomendasi produk, saham, atau tingkat risiko personal.
- Perubahan preset tidak mengubah riwayat bulan sebelumnya.

### 105. Migrasi Data Lama

Untuk data yang dibuat sebelum fitur Stockbit tersedia:

```text
Total Alokasi Investasi Lama =
Alokasi Bibit Lama
```

Gunakan pembagian migrasi:

- Bibit: 100%
- Stockbit: 0%

Ketentuan:

- Jangan memindahkan investasi historis ke Stockbit secara otomatis.
- Simpan versi skema dan versi mesin perhitungan pada setiap revisi bulanan.
- Hasil lama tetap dapat ditampilkan dengan label struktur historis.
- Pengguna dapat membuat revisi baru untuk bulan aktif, tetapi riwayat lama tidak boleh ditimpa.

### 106. Konfigurasi Stockbit

Tambahkan halaman:

**Pengaturan → Investasi → Stockbit**

Sediakan:

- Aktifkan Alokasi Stockbit
- Nama atau label akun, opsional
- Tujuan investasi
- Persentase dari Total Alokasi Investasi
- Tanggal rencana transfer ke RDN
- Frekuensi kontribusi
- Target Buffer Kas RDN
- Metode pembulatan
- Gunakan saldo RDN lama untuk pembelian, opsional
- Aktifkan estimasi biaya transaksi
- Pengingat evaluasi portofolio
- Mode pencatatan:
  - Investasi jangka panjang
  - Trading aktif
  - Campuran

Mode pencatatan hanya memengaruhi pengelompokan dan tampilan evaluasi. Mode tidak boleh menghasilkan order, sinyal beli atau jual otomatis, ataupun penggunaan buying power tanpa keputusan pengguna.

### 107. Sub-Alokasi Stockbit

Alokasi Stockbit dapat dibagi menjadi:

1. **Anggaran Pembelian Saham**
2. **Target Penambahan Buffer Kas RDN**
3. **Estimasi Biaya Pembelian**

```text
Alokasi Stockbit =
Anggaran Pembelian Saham
+ Target Penambahan Buffer Kas RDN
+ Estimasi Biaya Pembelian
```

Ketentuan:

- Estimasi biaya hanya ditampilkan jika pengguna mengaktifkannya dan memasukkan dasar perhitungan.
- Saldo RDN awal tidak dihitung sebagai kontribusi bulan berjalan.
- Penggunaan saldo RDN lama harus ditampilkan sebagai sumber pembelian terpisah.
- Jika estimasi biaya aktual belum tersedia, simpan sebagai `null` atau tampilkan sebagai estimasi, bukan realisasi.
- Sub-alokasi tidak boleh menghasilkan nilai negatif.

### 108. Pembulatan Internal Investasi

Gunakan urutan:

1. Hitung Total Alokasi Investasi Final pada pembulatan tingkat utama.
2. Hitung Alokasi Stockbit Mentah.
3. Bulatkan Alokasi Stockbit ke bawah berdasarkan kelipatan aktif.
4. Gunakan Alokasi Bibit sebagai residual.

```text
Alokasi Bibit Final =
Total Alokasi Investasi Final
- Alokasi Stockbit Final
```

Pada sub-alokasi Stockbit:

- Bulatkan Estimasi Biaya dan Target Buffer Kas RDN ke bawah.
- Gunakan Anggaran Pembelian Saham sebagai residual.
- Jika residual negatif, batalkan hasil dan minta pengguna mengurangi komponen tetap.

Tampilkan persentase target dan persentase efektif setelah pembulatan.

### 109. Tampilan Card Investasi dan Stockbit

Gunakan satu Card Investasi pada layar utama agar tampilan tidak padat.

Ringkasan Card Investasi:

- Total Alokasi Investasi
- Persentase terhadap Dana Bersih
- Target Bibit
- Target Stockbit
- Realisasi kontribusi gabungan, jika tersedia
- Status pembaruan data aktual

Sub-card Stockbit menampilkan:

- Alokasi Stockbit — Rencana
- Target transfer ke RDN
- Anggaran Pembelian Saham
- Target Buffer Kas RDN
- Estimasi biaya
- Tanggal rencana transfer
- Realisasi Pendanaan Stockbit
- Realisasi Pembelian
- Saldo RDN terakhir
- Nilai portofolio terakhir
- Realized gain atau loss, jika tersedia
- Unrealized gain atau loss, jika tersedia
- Periode dan sumber data terakhir

Gunakan label **Rencana**, **Aktual**, **Estimasi**, dan **Berdasarkan laporan terakhir** secara eksplisit.

### 110. Checklist Eksekusi Manual Stockbit

Tambahkan item dinamis:

- [ ] Tentukan Total Alokasi Investasi
- [ ] Pisahkan Alokasi Bibit dan Alokasi Stockbit
- [ ] Transfer target kontribusi Stockbit ke RDN
- [ ] Verifikasi dana masuk ke RDN
- [ ] Sisakan Buffer Kas RDN sesuai rencana
- [ ] Lakukan pembelian saham secara manual
- [ ] Catat transaksi yang berhasil atau telah selesai
- [ ] Catat biaya aktual jika tersedia
- [ ] Periksa status settlement jika data tersedia
- [ ] Pastikan deposit RDN dan pembelian tidak dihitung sebagai dua kontribusi

Order pending, ditolak, gagal, dibatalkan, atau dibalik tidak boleh ditandai sebagai pembelian aktual.

### 111. Pemisahan Rencana dan Realisasi Stockbit

Bedakan minimal:

- **Target Kontribusi Stockbit:** dana baru yang direncanakan masuk pada bulan aktif.
- **Realisasi Pendanaan Stockbit:** deposit eksternal yang benar-benar masuk ke RDN.
- **Realisasi Pembelian:** nilai pembelian yang telah berhasil dieksekusi berdasarkan data terverifikasi.
- **Dana Belum Digunakan:** dana yang masih berada sebagai saldo kas investasi.
- **Penjualan atau Pencairan:** nilai penjualan pada periode berjalan.
- **Penarikan RDN:** dana yang dipindahkan kembali ke rekening pribadi.
- **Nilai Portofolio:** nilai aset pada tanggal laporan atau input pengguna.

Target kontribusi tidak sama dengan pembelian aktual. Pengguna dapat mendanai RDN tanpa membeli saham, atau membeli menggunakan saldo lama tanpa deposit baru.

### 112. Rekonsiliasi Stockbit

```text
Realisasi Pendanaan Stockbit =
Total Deposit Eksternal ke RDN yang Terverifikasi
```

Jangan memasukkan hasil penjualan, dividen, saldo awal, atau pemindahan internal sebagai deposit eksternal.

```text
Arus Dana Eksternal Bersih =
Deposit Eksternal
- Penarikan ke Rekening Pribadi
```

```text
Realisasi Pembelian =
Total Nilai Bersih Pembelian Berhasil
```

```text
Selisih Pendanaan =
Realisasi Pendanaan Stockbit
- Target Kontribusi Stockbit
```

```text
Persentase Realisasi Pendanaan =
Realisasi Pendanaan Stockbit
/ Target Kontribusi Stockbit
× 100%
```

Jika target nol atau data aktual tidak tersedia, hasil persentase disimpan sebagai `null` dan ditampilkan sebagai **Tidak dapat dibandingkan**.

Status default:

- Belum tercapai: di bawah 80%
- Mendekati target: 80% sampai kurang dari 100%
- Sesuai target: 100% sampai 110%
- Melebihi target: di atas 110%
- Tidak dapat dibandingkan: target nol atau data aktual tidak tersedia

### 113. Pencegahan Double Counting Stockbit

Terapkan:

1. Deposit eksternal ke RDN adalah kontribusi investasi.
2. Pembelian saham menggunakan dana RDN adalah penggunaan dana, bukan kontribusi baru.
3. Penjualan saham bukan pendapatan baru dan bukan kontribusi negatif.
4. Hasil penjualan yang tetap di RDN bukan deposit baru.
5. Penarikan dari RDN tidak otomatis menjadi uang jajan atau pendapatan.
6. Dividen adalah hasil investasi dan tidak otomatis menjadi Penghasilan Tambahan.
7. Nilai portofolio bukan kontribusi.
8. Unrealized gain atau loss bukan pendapatan atau pengeluaran.
9. Transfer antarportofolio internal bukan kontribusi baru.
10. Satu transaksi atau dokumen tidak boleh disimpan lebih dari satu kali.
11. Biaya yang sudah termasuk dalam nilai bersih transaksi tidak boleh ditambahkan kembali.

### 114. Dashboard Progres Investasi Gabungan

Tambahkan tab atau bagian:

- Ringkasan
- Bibit
- Stockbit
- Target versus Realisasi
- Riwayat

Tampilkan:

- Total target investasi bulan aktif
- Target Bibit dan Stockbit
- Realisasi Kontribusi Bibit
- Realisasi Pendanaan Stockbit
- Realisasi Pembelian Stockbit sebagai indikator penggunaan dana
- Nilai portofolio terakhir per platform
- Profit atau loss per platform, jika tersedia
- Distribusi investasi per platform
- Distribusi jenis aset, jika tersedia
- Konsistensi kontribusi
- Tanggal dan sumber pembaruan terakhir

Nilai gabungan hanya boleh dihitung jika mata uang sama dan periode datanya dapat dibandingkan. Jika tanggal laporan berbeda, tampilkan tanggal masing-masing platform.

### 115. Integrasi Financial Health Score dan Savings Rate

Gunakan:

```text
Target Investasi Bulan =
Total Alokasi Investasi
```

```text
Realisasi Kontribusi Investasi =
Realisasi Kontribusi Bibit
+ Realisasi Pendanaan Stockbit
```

Jangan menambahkan Realisasi Pembelian Stockbit apabila Realisasi Pendanaan Stockbit sudah dihitung sebagai kontribusi.

Komponen Konsistensi Investasi menggunakan target gabungan dan realisasi kontribusi gabungan. Penggunaan dana Stockbit dapat ditampilkan sebagai indikator tambahan, tetapi tidak mengubah Savings Rate secara terpisah.

### 116. Input Aktual Manual Stockbit

Sebelum impor dokumen tersedia, sediakan input:

- Periode
- Deposit eksternal ke RDN
- Penarikan dari RDN
- Saldo RDN awal dan akhir
- Saldo kas investasi atau trading balance, jika diketahui
- Total pembelian
- Total penjualan
- Biaya beli
- Biaya jual
- Pajak
- Dividen
- Nilai portofolio
- Modal investasi
- Realized gain atau loss
- Unrealized gain atau loss
- Catatan
- Status verifikasi

Tandai sumber sebagai **Dimasukkan manual**. Nilai yang tidak diketahui disimpan sebagai `null`.

### 117. Impor Laporan Stockbit

Tambahkan fitur:

**Impor Laporan Stockbit**

Metode:

- Pilih file
- Share intent atau share extension pada fase yang mendukung
- Input manual sebagai fallback

Format mengikuti roadmap dan hanya ditampilkan jika parser fase aktif telah tersedia.

Finara tidak boleh meminta:

- Username atau password Stockbit
- PIN trading
- OTP
- Kredensial RDN
- Cookie, token sesi, atau authorization header

Jangan melakukan scraping atau reverse engineering. Integrasi otomatis hanya boleh digunakan jika tersedia mekanisme resmi dan pengguna memberikan persetujuan.

### 118. Data yang Diekstrak dari Laporan Stockbit

Ekstrak jika tersedia:

#### Informasi Laporan

- Jenis laporan
- Periode
- Tanggal pembuatan
- Mata uang
- Nomor referensi
- Identitas portofolio yang telah disamarkan, jika diperlukan

#### Dana dan RDN

- Deposit
- Penarikan
- Saldo awal
- Saldo akhir
- Saldo kas investasi

#### Transaksi

- Tanggal order
- Tanggal transaksi
- Tanggal settlement
- Kode saham
- Jenis transaksi
- Harga
- Jumlah lot
- Jumlah saham
- Nilai bruto
- Biaya
- Pajak
- Nilai bersih
- Status order
- Status settlement

#### Portofolio

- Kode saham
- Jumlah lembar
- Harga rata-rata
- Harga terakhir pada laporan
- Modal
- Nilai pasar
- Realized gain atau loss
- Unrealized gain atau loss
- Persentase alokasi

Nilai yang tidak tersedia disimpan sebagai `null`. Jangan memperkirakan harga, jumlah saham, profit, atau saldo yang tidak tercantum.

### 119. Pratinjau, Validasi, Duplikasi, dan Privasi

Sebelum menyimpan:

1. Kenali jenis dan periode dokumen.
2. Ekstrak data secara lokal jika memungkinkan.
3. Normalisasi angka, tanggal, status order, dan status settlement.
4. Tampilkan pratinjau.
5. Tandai data tidak tersedia atau berkeyakinan rendah.
6. Izinkan koreksi pengguna.
7. Jalankan validasi dan deteksi duplikasi.
8. Simpan hanya setelah konfirmasi.

Validasi:

- Total transaksi tidak rusak.
- Lot dan jumlah saham konsisten jika keduanya tersedia.
- Status order dikenali.
- Transaksi berada pada periode yang sesuai.
- Deposit tidak tertukar dengan hasil penjualan.
- Mata uang target dan aktual sama sebelum rekonsiliasi.
- Rincian portofolio mendekati nilai ringkasan sesuai toleransi yang didokumentasikan.

Fingerprint dapat menggunakan hash file, periode, jenis laporan, nomor referensi, serta kombinasi tanggal, kode saham, jenis transaksi, jumlah, dan nilai bersih.

Dokumen disimpan lokal secara default. File atau data tidak boleh dikirim ke AI tanpa izin. Pengguna harus dapat menghapus file asli, hasil impor, atau seluruh data Stockbit secara terpisah.

### 120. Struktur Data Stockbit dan Generalisasi Investasi

Tambahkan:

- InvestmentPlatformAllocation
- StockbitAllocationPlan
- StockbitPortfolioSnapshot
- StockbitTransaction
- InvestmentPlatformReconciliation
- StockbitReportImport
- StockbitDocumentFingerprint

Field minimum `InvestmentPlatformAllocation`:

- id
- monthlyAllocationRevisionId
- platform
- targetPercentage
- targetAmount
- roundedAmount
- plannedTransferDate
- contributionFrequency
- status

Field minimum `StockbitTransaction`:

- id
- tradeDate
- settlementDate
- symbol
- transactionType
- orderStatus
- settlementStatus
- price
- lots
- shares
- grossAmount
- feeAmount
- taxAmount
- netAmount
- portfolioId
- sourceImportId
- verificationStatus

Generalisasikan struktur impor investasi dengan `sourcePlatform`, sehingga layanan bersama dapat menangani Bibit dan Stockbit tanpa mencampur parser khusus platform.

### 121. Arsitektur Stockbit

Pisahkan:

- InvestmentAllocationService
- InvestmentPlatformAllocationService
- StockbitAllocationService
- StockbitReportClassifier
- StockbitStatementParser
- StockbitTransactionNormalizer
- StockbitSettlementService
- RDNReconciliationService
- InvestmentAggregationService
- CrossPlatformDuplicateDetectionService
- InvestmentPlatformRepository

Gunakan layanan bersama untuk pemilihan dokumen, ekstraksi PDF, normalisasi angka, normalisasi tanggal, confidence, penyimpanan aman, ekspor, dan sanitasi data.

Parsing dan rekonsiliasi harus berjalan di worker atau isolate jika berpotensi membekukan UI. Jangan menempatkan business logic di widget UI.

### 122. Finara AI, Keamanan, dan Privasi Stockbit

Finara AI dapat:

- Menjelaskan pembagian Bibit dan Stockbit.
- Membandingkan target dan realisasi kontribusi.
- Menjelaskan perbedaan deposit RDN, pembelian, dan nilai portofolio.
- Mengidentifikasi konsentrasi aset dari data yang telah dikonfirmasi.
- Menjelaskan realized dan unrealized gain atau loss.
- Membuat simulasi perubahan pembagian investasi.

Finara AI tidak boleh:

- Mengirim order atau melakukan transaksi.
- Meminta PIN, OTP, password, token sesi, atau kredensial Stockbit dan RDN.
- Menjanjikan keuntungan atau menyatakan saham tertentu pasti naik.
- Mengklaim harga real-time tanpa sumber real-time.
- Menganggap hasil parsing belum dikonfirmasi sebagai benar.
- Mengirim dokumen mentah atau data terstruktur ke provider tanpa izin pengguna.
- Menggunakan data Stockbit saat izin akses AI tidak mencakup data tersebut.

Secara default, kirim hanya data terstruktur yang dipilih dan telah dikonfirmasi pengguna.

### 123. Pengingat Stockbit

Sediakan local notification untuk:

- Jadwal transfer kontribusi ke RDN
- Target kontribusi belum tercapai
- Saldo RDN yang belum digunakan, jika pengguna mengaktifkannya
- Pengingat pencatatan pembelian manual
- Evaluasi portofolio bulanan
- Status settlement yang perlu diperiksa, jika datanya tersedia
- Laporan Stockbit belum diperbarui

Notifikasi lock screen tidak boleh menampilkan nilai portofolio, saldo, atau kode saham kecuali pengguna mengizinkan pratinjau sensitif.

### 124. Prioritas Pengembangan Stockbit

#### Fase Modul 1 — Pembagian Investasi

1. Ubah kategori utama Bibit menjadi Total Alokasi Investasi.
2. Tambahkan pembagian Bibit dan Stockbit.
3. Terapkan rumus dan pembulatan dua tingkat.
4. Tambahkan Card Investasi dan Sub-card Stockbit.
5. Tambahkan checklist transfer RDN.
6. Simpan target Stockbit pada riwayat berversi.
7. Migrasikan data lama ke Bibit 100% dan Stockbit 0%.
8. Tambahkan input aktual manual.
9. Tambahkan validasi dan pengujian inti.

#### Fase Modul 2 — Impor dan Rekonsiliasi

1. Pemilihan dokumen.
2. Pengenalan laporan Stockbit yang didukung.
3. Parsing deposit, penarikan, transaksi, biaya, dan saldo jika tersedia.
4. Status order dan settlement.
5. Pratinjau dan koreksi.
6. Deteksi duplikasi.
7. Rekonsiliasi target dan aktual.
8. Dashboard aktual Stockbit.

#### Fase Modul 3 — Analitik Lanjutan

1. Analisis kepemilikan dan alokasi aset.
2. Performa portofolio dari data laporan.
3. Performa transaksi dari data laporan.
4. Dukungan beberapa portofolio.
5. Dukungan produk investasi tambahan jika format tersedia.
6. Tax report dan format tambahan jika tersedia.
7. Analisis Finara AI setelah izin pengguna.
8. Ekspor laporan investasi gabungan.

#### Fase Modul 4 — Integrasi Resmi

Tambahkan sinkronisasi otomatis hanya jika tersedia mekanisme resmi, terdokumentasi, aman, dan disetujui pengguna. Tanpa integrasi resmi, gunakan input manual, file picker, dan mekanisme berbagi dokumen.

### 125. Pengujian dan Kriteria Penerimaan Stockbit

Tambahkan unit test dan integration test untuk:

- Total Alokasi Investasi sama dengan Alokasi Bibit ditambah Alokasi Stockbit.
- Total persentase investasi internal tepat 100%.
- Invarian global setelah pembulatan.
- Migrasi data lama.
- Kondisi Bibit 0% atau Stockbit 0%.
- Pembulatan Stockbit dan Bibit sebagai residual.
- Target kontribusi dan deposit aktual.
- Pembelian menggunakan saldo RDN lama.
- Deposit tidak dihitung dua kali bersama pembelian.
- Penjualan, dividen, dan saldo awal tidak dihitung sebagai kontribusi.
- Order pending, gagal, ditolak, dibatalkan, dan reversed.
- Settlement pada bulan berbeda.
- Dokumen dan transaksi duplikat.
- Input manual yang kemudian diganti hasil impor.
- Mata uang dan periode yang tidak dapat dibandingkan.
- Savings Rate dan Financial Health Score gabungan.
- Izin AI dan penghapusan data Stockbit.

Fitur dianggap selesai apabila:

- Pengguna dapat mengaktifkan atau menonaktifkan Stockbit.
- Pengguna dapat membagi Total Alokasi Investasi antara Bibit dan Stockbit.
- Riwayat lama tidak berubah dan dimigrasikan ke Bibit 100% serta Stockbit 0%.
- Transfer RDN, pembelian, penjualan, saldo, biaya, dan nilai portofolio dibedakan.
- Deposit dan pembelian tidak dihitung sebagai dua kontribusi.
- Data rencana, estimasi, dan aktual memiliki label jelas.
- Finara tidak meminta kredensial Stockbit atau melakukan transaksi otomatis.
- Data tidak disebut real-time tanpa sumber yang sesuai.
- Laporan hanya disimpan setelah konfirmasi pengguna.
- Dokumen dan hasil impor dapat dihapus.
- Seluruh rumus dan rekonsiliasi memiliki pengujian.

---

## Indeks Implementasi Cepat

| Kebutuhan | Bagian Utama |
|---|---|
| Identitas dan batasan produk | Bagian I |
| UI, navigasi, responsivitas, aksesibilitas | Bagian II |
| Perhitungan dan alokasi bulanan | Bagian III |
| Riwayat, progres, simulasi, pengingat, ekspor | Bagian IV |
| Chatbot, provider AI, dan pemilihan model | Bagian V |
| Keamanan, penyimpanan, validasi, arsitektur | Bagian VI |
| MVP, pengujian, dan acceptance criteria | Bagian VII |
| Impor serta rekonsiliasi laporan Bibit | Bagian VIII |
| Pembagian internal DANA dan DANA+ | Bagian IX |
| Pembagian investasi Bibit dan Stockbit | Bagian X |

> **Catatan implementasi:** Apabila terdapat konflik antara rekomendasi UI dan aturan perhitungan, prioritaskan aturan validasi, keamanan, privasi, versioning data, izin provider, invariansi total nominal, serta pencegahan double counting investasi. Istilah dalam Glosarium menjadi rujukan kanonik.
