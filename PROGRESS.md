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

## Status saat ini (Fase 0 ✅ · 1A ✅ · 1B ✅ · 1C ✅ · 1D ✅ — Fase 1 LENGKAP, menunggu review pemilik proyek)

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
- **`flutter build apk --debug` SUKSES** (2026-08-01, Codespace baru): Gradle assembleDebug 217s, artefak `build/app/outputs/flutter-apk/app-debug.apk` (162 MB, debug). Kegagalan di mesin lama terkonfirmasi karena toolchain hilang — di lingkungan dengan clang/cmake/ninja terpasang, Gradle otomatis mengunduh NDK, CMake 3.22.1, dan Platform 35; sqlite3mc terkompilasi normal (enkripsi TIDAK perlu ditunda)
- **Fase 1A — Mesin perhitungan (2026-08-01):**
  - Model domain `lib/domain/models/`: `AllocationInput` (+enum kanal/pembulatan/metode sub-Jago/siklus langganan/frekuensi DANA), `AllocationResult` (+`JagoSubAllocationResult`, `SubscriptionPlanResult`, `SubscriptionMonthlyPlan`, `EmergencyFundPlan`, `DanaScheduleResult`), `AllocationPreset` (4 preset 2 tingkat §13), `AllocationViolation` (16 kode → dipetakan ke ARB di presentasi nanti)
  - Service `lib/domain/services/` (pure Dart, deterministik): `AllocationEngine` Tahap 0–5 §12 + pembulatan floor+residual §18 (floor Investasi & DANA → Jago residual; floor Stockbit → Bibit residual); `SubscriptionReserveService` §15 (`biayaTahunan ~/ 12`, sisa ke kontribusi bulan jatuh tempo, ledger cadangan, kekurangan eksplisit); `EmergencyFundService` §16 (pokok otomatis dari kategori bertanda + koreksi manual bertanda); `DanaScheduleService` §17 (harian/mingguan/sekaligus, sisa integer ke periode terakhir, jumlah kejadian mingguan sebenarnya); `AllocationValidator` §53 (validasi input pra-hitung + semua invarian pasca-pembulatan, Selisih Belum Dialokasikan wajib Rp0, blokir langganan > alokasi Jago §14)
  - Test `test/domain/`: engine 17, langganan 8, jadwal DANA 6, dana darurat 8, fuzz 1000 input seed tetap (20260801) semua invarian — total **65/65 lulus**, analyze 0 issue
- **Fase 1B — Data layer (2026-08-01):**
  - Skema Drift subset F1 `lib/data/db/tables.dart` (15 tabel §54): MonthlyAllocations+Revisions (snapshot input+hasil, status draf/dikonfirmasi/dikunci/direvisi, unik (bulan,nomorRevisi)), IncomeSources, MandatoryExpenses, BudgetFundingAssignments (sumber≠kanal, unik per item+revisi), ExpenseRealizations, Subscriptions+ReserveLedgers (unik per periode), EmergencyFundTargets/Contributions, OtherSavingsContributions, InvestmentPlatformAllocations (unik revisi+platform), ChecklistItems (kode template→ARB), Reminders, AppSettings (key-value)
  - Enum status di `lib/domain/models/finance_enums.dart` (RevisionStatus, BudgetSource, PlanActualStatus, VerificationStatus, InvestmentPlatform, ReminderKind)
  - `AppDatabase` + codegen (`dart run build_runner build -d`); PRAGMA foreign_keys ON
  - Enkripsi: `DatabaseKeyManager` (kunci hex 256-bit acak di flutter_secure_storage, tidak pernah di-log) + `openEncryptedConnection` (PRAGMA key sqlite3mc + fail-fast `PRAGMA cipher` jika cipher tidak aktif)
  - `ChecklistBuilder` (domain, pure): checklist §21 dinamis per kanal pembayaran wajib
  - Repositories `lib/data/repositories/`: AllocationRepository (simpanRevisi transaksional: bulan+revisi+anak; revisi immutable, revisi lama → `direvisi`; transisi status; checklist toggle), ExpenseRealizationRepository (§22A; sisa anggaran DANA null tanpa realisasi; wajib via DANA tidak mengurangi uang jajan), SubscriptionRepository (CRUD+ledger append-only sinkron saldo), EmergencyFundRepository (target terbaru menang + kontribusi rencana/aktual + tabungan lain), SettingsRepository (key-value; kredensial TIDAK di sini)
  - Test integrasi in-memory `test/data/` (13 test) — total **78/78 lulus**, analyze 0 issue, build APK debug OK
  - Dep baru: path_provider, path
- **Fase 1C — UI inti (2026-08-01):**
  - Splash (§7) + onboarding 3 halaman tanpa AI (`lib/features/onboarding/`); flag `onboardingSelesai` di AppSettings; initialLocation `/splash`
  - Tema persisten via AppSettings (ThemeModeController baca/tulis SettingsRepository)
  - Alur Hitung 3 langkah (`hitung_page.dart` + `hitung_controller.dart`): Pendapatan (utama+kas+tambahan) → Pengeluaran Wajib (kanal+dasar darurat) → Pembagian (4 preset chips + custom % dua tingkat + indikator 100% merah/hijau + pembulatan + frekuensi DANA); tombol Hitung disabled saat invalid
  - Hasil (`hasil_page.dart`): donut §20 (pemetaan kategori) + 4 card §19 (BRImo/Jago/Investasi+sub-card Bibit&Stockbit/DANA) + persentase efektif + tombol salin + peringatan risiko + Simpan ke Riwayat
  - Riwayat berversi (§22): list bulan + StatusChip; detail revisi + konfirmasi status draf→dikonfirmasi + checklist transfer interaktif (kode→ARB via `_labelChecklist`)
  - Beranda §9: maks 4 info (Total Pendapatan, Wajib, Investasi rencana, progres checklist) dari revisi aktif; empty state jika belum ada
  - Progres §23 dasar: dana darurat (target via dialog, disimpan EmergencyFundRepository) + progres checklist; label "Tidak tersedia" utk nilai null
  - Pengaturan §51 subset: tema radio persisten + lihat onboarding + tentang + disclaimer
  - Router: rute /splash /onboarding /hasil /pengaturan /riwayat/:revisiId; providers data di `lib/app/data_providers.dart`
  - Smoke test ditulis ulang (DB in-memory via override databaseProvider): onboarding flow, navigasi, tema persisten, **E2E hitung→hasil→simpan→riwayat→konfirmasi→beranda** — total **79/79 lulus**, analyze 0 issue, APK debug OK
- **Fase 1C lanjutan (2026-08-01):**
  - Catat Pengeluaran §22A: dialog + daftar realisasi + **Sisa Anggaran DANA** di detail riwayat (null → "Tidak tersedia", bukan Rp0; wajib via DANA tidak mengurangi uang jajan)
  - Kelola Langganan §15 (`lib/features/langganan/`): CRUD via dialog (siklus, bulan tagihan, metode tahunan, sumber anggaran, aktif); **langganan aktif dari DB otomatis ikut dihitung** saat Hitung; dropdown metode sub-Jago (persentase tetap / berdasarkan langganan) di langkah 3; blokir §14 ditampilkan sebagai pesan spesifik
  - Aksi riwayat §22: menu Edit draf / Duplikasi ke Hitung (prefill controller dari revisi via `muatUntukPrefill`) + Hapus bulan dengan konfirmasi (`hapusBulan` transaksional hapus semua anak)
  - Hapus seluruh data §51: `AppDatabase.hapusSemuaData()` + konfirmasi ganda di Pengaturan
  - Notifikasi lokal §49 dasar (`lib/data/services/notification_service.dart`): pengingat top-up DANA 08.00 WIB utk jadwal mendatang, dijadwalkan saat konfirmasi alokasi; inexact schedule (tanpa izin exact alarm); POST_NOTIFICATIONS di manifest; error plugin ditelan (aman utk test); label app "Finara"
  - Test baru: catat pengeluaran→sisa anggaran, kelola langganan, hapus semua data — total **82/82 lulus**, analyze 0 issue, APK debug OK
  - **Ditunda ke 1D:** PIN/biometrik/auto-lock §51 (butuh uji perangkat fisik); bandingkan antarbulan + filter/cari riwayat §22
- **Fase 1D (2026-08-01):**
  - Keamanan §51: `PinManager` (SHA-256+salt acak di secure storage, tidak pernah plaintext); `LockPage` (/kunci) dgn PIN + biometrik via local_auth (MainActivity → FlutterFragmentActivity, izin USE_BIOMETRIC); splash cek PIN; auto-lock via WidgetsBindingObserver di FinaraApp (paused >1 menit → /kunci); UI Pengaturan→Keamanan (set PIN 2x input, toggle biometrik hanya saat PIN aktif); hapus semua data juga hapus PIN
  - Riwayat §22: filter tahun (dropdown, muncul jika >1 tahun) + card "Dibanding bulan sebelumnya" (delta pendapatan/wajib/investasi/DANA; "Tidak ada data bulan sebelumnya" jika kosong)
  - Dep baru: crypto. Test baru: pin_manager (hash/salt/verifikasi), alur kunci PIN E2E, perbandingan bulan — total **85/85 lulus**, analyze 0 issue, APK debug OK
  - Catatan test: ListView lazy — scroll dulu sebelum assert elemen bawah; FlutterSecureStorage difake via `Fake implements` (param AppleOptions di v10)

### BELUM selesai (pending — kerjakan saat lanjut)
1. **Checkpoint Fase 1 LENGKAP ke pemilik proyek.** Uji manual di perangkat Android wajib sebelum lanjut: PIN/biometrik/auto-lock, notifikasi terjadwal, dark mode, font scaling besar, keyboard tidak menutup input, layar kecil.
2. Setelah disetujui → **Fase 2 Finara AI MVP** (`activeAppPhase = fase2`): interface `AIProviderAdapter` 11 method §55, adapter OpenAI-compatible, API key secure storage §45, model discovery+cache §29, searchable picker §31, default/favorit/manual §30/§33/§34, chat streaming + system prompt §46, riwayat percakapan §47, izin data §44 + FinancialContextBuilder + DataSanitizer, tombol "Tanyakan Hasil Ini ke AI" §43, error handling §48, `MockAIAdapter` utk test

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

### Fase 1 — Core Financial MVP (berikutnya setelah checkpoint Fase 0 disetujui)
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
