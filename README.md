# Finara

> **Setiap rupiah punya arah.**

Finara adalah aplikasi Android untuk pengelolaan dan alokasi keuangan pribadi: membagi penghasilan bulanan ke kas pegangan, pengeluaran wajib, dana darurat, investasi, langganan digital, dan uang jajan — lengkap dengan checklist transfer manual, analitik, dan asisten AI.

**Local-first**: seluruh data tersimpan di perangkat dalam database terenkripsi. Tanpa login, tanpa backend. Finara hanya menghitung, mencatat, dan memberi instruksi manual — tidak pernah melakukan transfer atau transaksi atas nama Anda.

📦 **Unduh**: [Releases](https://github.com/andiakbararyaputra/Finara/releases) (v0.1.0 pre-release)

## Fitur

### 💰 Mesin alokasi
- Pembagian dua tingkat: Dana Bersih → Bank Jago / Total Alokasi Investasi / DANA, lalu investasi → Bibit / Stockbit (Stockbit bisa dinonaktifkan per bulan)
- 4 preset (Standard Hybrid, Investor Fokus, Pelajar, Konservatif) + custom dengan validasi 100% eksak
- Pembulatan deterministik (floor + komponen residual) — total selalu tepat, Selisih Belum Dialokasikan wajib Rp0
- Checklist transfer dinamis sesuai kanal pembayaran tiap pengeluaran

### 📊 Pencatatan & analitik
- Riwayat bulanan **berversi** (draf → dikonfirmasi → direvisi, audit trail utuh)
- Realisasi pengeluaran, langganan digital + cadangan tahunan, target dana darurat
- Financial Health Score 6 komponen dengan dukungan data parsial
- Savings Rate (rencana vs aktual terpisah), simulasi "Bagaimana Jika"
- Ekspor CSV, PDF, salin/bagikan teks

### 🤖 Finara AI
- Bawa API key sendiri (OpenAI-compatible: OpenAI, Groq, OpenRouter, server lokal, dll.)
- Multi-provider, model discovery, chat streaming, model fallback, estimasi biaya token
- Izin data per provider + sanitasi otomatis — kredensial tidak pernah dikirim ke model
- Tombol "Tanyakan Hasil Ini ke AI" dengan persetujuan eksplisit atas data yang dikirim

### 📈 Ekstensi investasi & DANA+
- Pembagian Saldo DANA Biasa / DANA+ (Smart Liquidity + 4 mode lain), ledger, simulasi reward
- Rekonsiliasi Stockbit/RDN dengan aturan anti *double counting* (deposit ≠ pembelian)
- Impor Statement of Account Bibit (PDF) dengan pratinjau, koreksi, dan anti-duplikat

### 🔒 Keamanan
- Database SQLite terenkripsi (SQLite3MultipleCiphers), kunci di Android Keystore
- PIN aplikasi (hash + salt), biometrik, auto-lock, hapus seluruh data

## Teknologi

| Komponen | Pilihan |
|---|---|
| Framework | Flutter 3.44 / Dart 3.12 (Android) |
| State | Riverpod (tanpa codegen) |
| Database | Drift + SQLite terenkripsi (sqlite3mc) |
| Navigasi | go_router |
| Bahasa UI | Indonesia (ARB) |

Prinsip arsitektur: seluruh logika bisnis berada di *service* Dart murni yang deterministik dan teruji tanpa UI (`lib/domain/`); uang disimpan sebagai `int` Rupiah; persentase sebagai basis points (10000 = 100%); nilai tak tersedia = `null`, bukan nol.

```
lib/
├── app/            # router, providers, konfigurasi fase
├── core/           # money (Rupiah int), basis points
├── design_system/  # token warna/spasi/tipografi + widget dasar
├── domain/         # model & service murni (engine, validator, skor, parser)
├── data/           # Drift, repositories, secure storage, ekspor
└── features/       # halaman UI per fitur
```

## Menjalankan dari sumber

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build -d   # codegen Drift
flutter analyze && flutter test  # 178 test
flutter build apk --release
```

Kebutuhan: Flutter 3.44+, JDK 21, Android SDK 36, toolchain C (clang/cmake/ninja) untuk kompilasi sqlite3mc.

## Status

Roadmap Fase 1–4 spesifikasi telah selesai. Rilis saat ini **pre-release** (signing debug). Progres rinci dan backlog: [PROGRESS.md](PROGRESS.md).

## Disclaimer

> Finara membantu melakukan simulasi dan perencanaan keuangan. Finara bukan bank, bukan penasihat keuangan, dan tidak menjamin keuntungan investasi. Selalu periksa kembali informasi sebelum mengambil keputusan keuangan.
>
> Jawaban AI dapat tidak akurat. Penggunaan API dan biaya mengikuti penyedia AI yang dipilih pengguna. Finara tidak terafiliasi dengan BRI, Bank Jago, Bibit, Stockbit, maupun DANA.
