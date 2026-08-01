# Finara — Status Progres & Rencana Lanjutan

> Handoff untuk melanjutkan pengerjaan di Codespace / mesin lain.
> Rencana induk lengkap: lihat `Finara_Master_Prompt_Terstruktur_Final_Stockbit.md` (spesifikasi) dan bagian "Rencana per fase" di bawah.

## Keputusan yang sudah disepakati

- **Stack:** Flutter 3.44.8 (Dart 3.12.2) + Riverpod (TANPA codegen) + Drift/SQLite terenkripsi + go_router
- **Target:** Android dulu saja (iOS ditunda; jaga abstraksi platform)
- **Alur kerja:** kerjakan SATU fase → `flutter analyze` + `flutter test` + build APK debug → tunjukkan ke pemilik proyek → baru lanjut fase berikutnya
- **Konvensi teknis:**
  - Uang = `int` Rupiah (tanpa desimal); format `Rp1.500.000` (lib/core/money.dart)
  - Persentase = basis points `int`, 10000 = 100% (lib/core/basis_points.dart) agar cek 100% eksak
  - Pembulatan: floor untuk komponen non-residual, komponen residual menyerap sisa
  - Nilai tak tersedia = `null`, bukan 0; label "Tidak tersedia" hanya di presentasi
  - Gating fitur per fase via `lib/app/phase_config.dart` (`activeAppPhase`, sekarang `fase1`)
  - UI Bahasa Indonesia via ARB id-only: `lib/l10n/app_id.arb` → `flutter gen-l10n`
  - Business logic HANYA di service Dart murni (deterministik, teruji tanpa UI), bukan di widget

## Status saat ini (Fase 0 — Fondasi Proyek: ±95%)

### Selesai
- Proyek Flutter dibuat di root workspace (project-name `finara`, applicationId `com.andiakbar.finara`, platform Android saja)
- Dependencies terpasang: flutter_riverpod, go_router, intl ^0.20.2 (dikunci flutter_localizations), drift, sqlite3, flutter_secure_storage, flutter_local_notifications, timezone, fl_chart, share_plus, local_auth, freezed_annotation, json_annotation; dev: build_runner, drift_dev, freezed, json_serializable
- Enkripsi DB: `hooks: user_defines: sqlite3: source: sqlite3mc` di pubspec.yaml (pengganti sqlcipher_flutter_libs yang sudah EOL)
- Font Inter 4 weight dibundel offline di `assets/fonts/` (tanpa google_fonts)
- Design system: token warna/spacing/tipografi (`lib/design_system/tokens/`), tema light/dark M3 (`lib/design_system/theme/finara_theme.dart`), widget dasar `FinaraCard`, `AmountText`, `EmptyState`, `StickyActionBar`, `SkeletonBox`
- Navigasi: go_router StatefulShellRoute 4 tab (Beranda/Hitung/Progres/Riwayat) di `lib/app/router.dart` + `lib/features/shell/main_shell.dart`; tab Finara AI disembunyikan sampai Fase 2
- Halaman placeholder: Beranda (bulan aktif + empty state + tombol Hitung Alokasi + pengaturan tema berfungsi), Hitung, Progres, Riwayat
- Tema light/dark/system switcher (in-memory; persistensi menyusul via AppSettings di Fase 1B)
- `flutter analyze`: bersih. `flutter test`: **24/24 lulus** (money 15, basis points/phase 4, smoke widget 5)

### BELUM selesai (pending — kerjakan pertama saat lanjut)
1. **`flutter build apk --debug` GAGAL setelah 8m50s** (Gradle assembleDebug exit 1; log tail terpotong, penyebab belum didiagnosis).
   - Jalankan ulang dengan log penuh: `flutter build apk --debug 2>&1 | tee /tmp/build.log` lalu cari error pertama (`grep -n -m5 -iE "error|failed|exception" /tmp/build.log`)
   - Hipotesis utama (urut kemungkinan):
     a. Build hook native assets `sqlite3`/sqlite3mc butuh toolchain C — di mesin lama TIDAK ada clang/gcc (flutter doctor menandai clang missing). Coba: pasang `clang` (di Codespace: `sudo apt-get install -y clang cmake ninja-build`), atau sementara HAPUS blok `hooks:` di pubspec + dep `sqlite3` untuk membuktikan penyebab (enkripsi bisa ditunda ke Fase 1B)
     b. NDK belum terpasang/gagal diunduh Gradle (cek `ls ~/Android/Sdk/ndk`); bisa pasang manual: `sdkmanager "ndk;<versi yang diminta log>"`
     c. Kegagalan unduh dependensi Gradle (timeout jaringan) — cukup ulangi build
2. Setelah build sukses → **checkpoint Fase 0 ke pemilik proyek** (aturan alur kerja), baru mulai Fase 1

## Setup lingkungan di Codespace (Linux, tanpa sudo tidak masalah kecuali clang)

```bash
# Flutter SDK
mkdir -p ~/development && cd ~/development
curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.44.8-stable.tar.xz
tar xf flutter.tar.xz && rm flutter.tar.xz
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bashrc && export PATH="$HOME/development/flutter/bin:$PATH"
flutter --disable-analytics

# JDK 21 (JANGAN pakai Java sistem yang lebih baru dari 24 untuk Gradle)
cd ~/development && curl -sL -o jdk21.tar.gz "https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jdk/hotspot/normal/eclipse"
tar xzf jdk21.tar.gz && rm jdk21.tar.gz && mv jdk-21* jdk-21

# Android SDK (URL cmdline-tools bisa berubah; cek https://developer.android.com/studio)
mkdir -p ~/Android/Sdk/cmdline-tools && cd ~/Android/Sdk/cmdline-tools
curl -o tools.zip https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip
unzip -q tools.zip && rm tools.zip && mv cmdline-tools latest
export JAVA_HOME=$HOME/development/jdk-21 ANDROID_HOME=$HOME/Android/Sdk
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
flutter config --android-sdk $HOME/Android/Sdk --jdk-dir $HOME/development/jdk-21

# Toolchain C untuk hook sqlite3mc (di Codespace sudo tersedia)
sudo apt-get update && sudo apt-get install -y clang cmake ninja-build pkg-config

# Proyek
cd <repo> && flutter pub get && flutter gen-l10n && flutter analyze && flutter test
```

## Perintah rutin

- Generate l10n setelah mengubah `lib/l10n/app_id.arb`: `flutter gen-l10n`
- Codegen drift/freezed (mulai Fase 1): `dart run build_runner build -d`
- Verifikasi per fase: `flutter analyze && flutter test && flutter build apk --debug`
- APK debug hasil build: `build/app/outputs/flutter-apk/app-debug.apk`

## Rencana per fase (ringkas — detail di percakapan/spesifikasi)

### Fase 1 — Core Financial MVP (berikutnya setelah build APK beres)
Urutan pengerjaan:
1. **1A Mesin perhitungan (pure Dart, `lib/domain/services/`)** — `AllocationEngine` Tahap 0–5 (§12 spesifikasi); preset 2 tingkat (§13: Standard Hybrid 40/30/30 + Bibit/Stockbit 70/30, Investor Fokus 25/50/25 + 50/50, Pelajar 45/15/40 + 80/20, Konservatif 60/20/20 + 85/15, Custom); pembulatan floor+residual (§18: floor Investasi & DANA → Jago residual; floor Stockbit → Bibit residual); sub-alokasi Jago 2 metode (§14, rasio 5:4, blokir jika langganan > alokasi); langganan + ledger cadangan tahunan (§15, `biayaTahunan ~/ 12`, sisa ke kontribusi terakhir); dana darurat (§16); jadwal DANA harian/mingguan (§17, sisa integer ke periode terakhir); `AllocationValidator` semua invarian §53 setelah pembulatan, Selisih Belum Dialokasikan wajib Rp0. Unit test §60 + fuzz test invarian seed tetap.
2. **1B Data layer (`lib/data/`)** — skema Drift subset F1 (§54): MonthlyAllocation+Revision immutable (status draf/dikonfirmasi/dikunci/direvisi), IncomeSource, MandatoryExpense, BudgetFundingAssignment (sumber anggaran ≠ kanal pembayaran), ExpenseRealization, Subscription+ReserveLedger, EmergencyFundTarget/Contribution, OtherSavingsContribution, InvestmentPlatformAllocation, ChecklistItem, Reminder, AppSettings; repositories; enkripsi sqlite3mc (PRAGMA key dari flutter_secure_storage); test integrasi in-memory.
3. **1C UI** — splash+onboarding 3 halaman (tanpa AI, §7); Beranda maks 4 info (§9); alur Hitung multi-step (§10–§13); Hasil 4 card + sub-card Bibit/Stockbit (§19) + donut chart (§20); checklist transfer dinamis per kanal (§21); Riwayat berversi (§22) + Catat Pengeluaran (§22A); Progres dasar (§23); Pengaturan (tema persisten, pembulatan, PIN/biometrik/auto-lock/hapus data §51); notifikasi lokal (§49).
4. **1D QA** — analyze/test hijau, uji manual Android (dark mode, font scaling, keyboard, layar kecil), acceptance §61 subset.

### Fase 2 — Finara AI MVP
Tab AI muncul (`activeAppPhase = fase2`); interface `AIProviderAdapter` (11 method §55); adapter OpenAI-compatible; API key di secure storage (§45, masked, tak pernah ke log/ekspor); model discovery `/v1/models` + cache (§29); searchable model picker (§31); default/favorit/manual (§30/§33/§34); chat UI streaming + system prompt §46 + disclaimer; riwayat percakapan + retensi (§47); izin data per provider (§44) + FinancialContextBuilder + DataSanitizer; tombol "Tanyakan Hasil Ini ke AI" (§43); error handling §48; `MockAIAdapter` untuk semua test.

### Fase 3 — AI Lanjutan & Analitik
Multi-provider (§38); Allowed Models 4 aturan (§34); fallback lintas provider + izin (§37); status kemampuan UNKNOWN/CLAIMED/VERIFIED/UNSUPPORTED + tes terpisah (§32/§35); kompatibilitas parameter (§40–41); estimasi biaya (§39); Financial Health Score 6 komponen + data parsial + versi ambang (§24); Simulasi "Bagaimana Jika" sandbox (§25); analitik 12 bulan + Savings Rate rencana vs aktual (§23); ekspor PDF/CSV/gambar (§50).

### Fase 4 — Ekstensi Produk
- **4A Impor Bibit (Bagian VIII):** pipeline file picker → ekstraksi PDF di isolate → classifier → normalisasi → pratinjau+confidence → konfirmasi → rekonsiliasi §72 → fingerprint anti-duplikat §73; kandidat paket PDF: syncfusion_flutter_pdf (community license) — evaluasi dulu
- **4B DANA+ (Bagian IX):** 5 mode split (Smart Liquidity default §87), 3 strategi eksekusi, validasi §90, pembulatan §91 (floor DANA+, Biasa residual), ledger realisasi §94, simulasi reward §95
- **4C Stockbit (Bagian X):** input manual §116, impor+status order/settlement §117–119, rekonsiliasi RDN §112 (deposit eksternal ≠ pembelian), 11 aturan anti double counting §113, dashboard gabungan §114, integrasi skor §115

## Catatan penting lain

- `riverpod_generator` TIDAK dipakai (konflik analyzer dengan drift_dev) → tulis provider Riverpod manual
- Jangan pakai API deprecated (analysis_options ketat; `flutter analyze` harus 0 issue)
- Semua string UI lewat ARB; jangan hardcode di widget
- Ikuti aturan spesifikasi: satu sumber anggaran per item per periode; pisahkan rencana/realisasi; jangan double counting RDN vs pembelian saham
