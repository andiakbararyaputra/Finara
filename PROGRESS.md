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

## Status saat ini (Fase 1–4 LENGKAP ✅ · RILIS v0.1.0 pre-release diterbitkan)

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
- **Fase 2 — Finara AI MVP (2026-08-01):**
  - `activeAppPhase = fase2`: onboarding 4 halaman (halaman AI §7), bottom nav 5 tab, cabang router /ai + /ai-pengaturan + /ai-chat/:id
  - Domain `lib/domain/ai/`: `AIProviderAdapter` interface 11 method §55; `OpenAICompatibleAdapter` (GET /models + POST /chat/completions, streaming SSE parser `parseSseLine`, timeout/socket → error terklasifikasi, `parseError` memetakan 401/404/413/429/5xx → `AIErrorKind` §48 tanpa kredensial); `MockAIAdapter` utk semua test; `DataSanitizer` (regex API key/bearer/PIN/kartu → [DIHAPUS]); `FinancialContextBuilder` (system prompt §46 + konteks alokasi berlabel RENCANA §43, tersanitasi)
  - Data: skema **v2** (migrasi onUpgrade) — AiProviderConfigurations (izinData `AIDataScope` §44; API key TIDAK di DB), AiModels (favorit/manual/terakhirDipakai, unik provider+modelId), ModelListCaches, ChatConversations, ChatMessages; `ApiKeyStore` (secure storage `ai_api_key_<id>`, `samarkan()` → ••••xxxx); `AIProviderRepository` (discovery pertahankan favorit, model manual, default, cache); `ChatRepository`
  - UI `lib/features/finara_ai/`: tab AI (daftar percakapan / ajakan setup); AiConfigPage (form provider: base URL wajib https kecuali localhost §53, API key masked, tes koneksi, ambil/muat ulang model, cari model, favorit, jadikan default, model manual, dropdown izin data, hapus provider ikut hapus API key+percakapan); ChatPage (streaming per-chunk, hentikan, salin via long-press, suggestion chips §42, disclaimer AI §58, judul otomatis dari pesan pertama, error → SnackBar Indonesia)
  - Tombol **Tanyakan Hasil Ini ke AI** di HasilPage (§43): hanya fase2; blokir jika izin `tanpaAkses`; dialog persetujuan menampilkan konteks persis yang akan dikirim; buat percakapan berisi konteks
  - Test: 15 unit adapter/sanitizer/context + 4 widget AI flow (setup+discovery+masking, chat streaming mock + system prompt terkirim, error mapping, tab kosong) + update smoke (5 tab, onboarding 4 halaman) — total **104/104 lulus**, analyze 0 issue, APK debug OK
  - Dep baru: http
  - Perbaikan hasil uji perangkat (2026-08-01): tombol hentikan butuh diklik berulang → streaming kini via `StreamSubscription`+`Completer` (batal seketika, jawaban parsial tetap disimpan) + test regresi satu-klik — **105/105 lulus**; APK release `uji-fase2` diperbarui
- **Fase 3A — Analitik (2026-08-01):**
  - `FinancialHealthScoreService` §24 (`lib/domain/services/`): 6 komponen berbobot 30/20/15/15/10/10, seluruh ambang sesuai spesifikasi, **data parsial** (komponen tanpa data = tersedia:false, skor dinormalkan ke bobot tersedia, kelengkapan bp), kategori 4 tingkat, `versiAmbangSkor` disimpan di hasil, basis rencana/aktual ditandai pada komponen uang jajan
  - `SavingsRateService` §23: rencana & aktual TERPISAH; aktual null jika tidak ada satu pun data aktual; pendapatan nol/null → null
  - Provider perakit `skorKesehatanProvider` (data_providers): darurat dari target aktif, cicilan via heuristik nama/kategori mengandung "cicilan", uang jajan aktual dari realisasi bersumber alokasiDana (fallback anggaran rencana berlabel), konsistensi investasi = tidak tersedia di F2 (butuh realisasi terverifikasi)
  - Progres UI: card skor (nilai/100 + kategori + kelengkapan + rincian poin per komponen + "Tidak tersedia"), card Savings Rate (aktual "Tidak tersedia"), card perbandingan bulanan (maks 12 entri, bar relatif)
  - Simulasi "Bagaimana Jika" §25 (`lib/features/simulasi/`, rute /simulasi dari Progres): sandbox murni (test membuktikan tidak menambah revisi DB), baseline dimuat dari revisi aktif, slider dua tingkat + input nominal, dampak Sebelum→Sesudah (dana bersih, investasi bulanan+tahunan, Bibit/Stockbit, uang jajan harian, kontribusi darurat)
  - Ekspor §50 subset: menu Salin sebagai teks + Bagikan (share_plus) di detail riwayat, teks branding Finara tanpa kredensial
  - Test: 11 unit skor/savings + 2 widget analitik (skor data parsial end-to-end di UI, simulasi sandbox) — total **118/118 lulus**, analyze 0 issue, APK OK
  - **Sisa Fase 3 (3B, berikutnya):** multi-provider §38, Allowed Models 4 aturan §34, fallback lintas provider + izin §37, status kemampuan + tes terpisah §32/§35, kompatibilitas parameter §40–§41, estimasi biaya §39, ekspor PDF/CSV/gambar §50 penuh, retensi riwayat chat §47
- **Fase 3B — AI Lanjutan (2026-08-01):**
  - Skema **v3** (migrasi addColumn): AiModels + diblokir/diizinkan/statusChat/statusStreaming (CapabilityStatus §32)/harga input-output per juta token §39; provider + allowedMode/fallbackModel1/fallbackModel2
  - `model_policy.dart` (pure): `AllowedModelsService` 4 aturan §34 (blokir menang; allowlist; favorit; pemilihan otomatis hanya chat VERIFIED + streaming verified saat dibutuhkan); `FallbackService` §37 (error layak: modelTidakTersedia/rateLimit/overload/timeout; apiKeyDitolak TIDAK memicu; §34 tetap berlaku pada cadangan); `CostEstimator` §39 (≈4 char/token; harga null → estimasi null)
  - Multi-provider §38: AiConfigPage = daftar provider + dialog tambah; `AiProviderDetailPage` (/ai-provider/:id): tes koneksi, discovery, cari, per-model popup (favorit/default/blokir/allowlist/tes chat/tes streaming/harga), dropdown izin data + Allowed Models + fallback 1&2; percakapan baru dengan >1 provider → bottom sheet pilih provider
  - Tes kemampuan §35: VERIFIED saat lulus; UNSUPPORTED hanya saat provider menyatakan model tak tersedia / streaming kosong; error lain tidak menandai gagal
  - Chat: rantai fallback dalam provider yang sama (izin data identik §37) dengan SnackBar "Beralih ke cadangan"; estimasi token+biaya tampil setelah respons hanya jika harga diisi (+disclaimer biaya)
  - Retensi chat §47: dropdown selamanya/7/30/90 hari, purge saat splash; hapus semua percakapan
  - Ekspor §50 penuh: CSV riwayat (ikon di Riwayat, share file), PDF per revisi (menu detail, package `pdf`, branding + disclaimer), salin/bagikan teks (3A)
  - Test: 13 unit policy/fallback/biaya + update AI flow (multi-provider dialog, tes model → Terverifikasi) — total **131/131 lulus**, analyze 0 issue, APK OK
  - APK dirilis: `uji-fase3`. Dep baru: pdf
  - Catatan lingkup: fallback otomatis lintas provider (perlu konfirmasi izin §37) belum — fallback saat ini dalam provider yang sama; "bagikan sebagai gambar" §50 ditunda
- **Fase 4B — DANA+ (2026-08-01, Bagian IX):**
  - `DanaSplitService` (`lib/domain/services/dana_split_service.dart`, pure): **5 mode §87** — Smart Liquidity default (horizon min(7, hari tersisa, sampai top-up), kebutuhan = anggaranHorizon + terjadwal + buffer; kebutuhan>dana → semua Biasa/Plus Rp0), persentase (Biasa dari bp, Plus residual), nominal tetap Biasa/Plus (di-min ke dana), manual (jumlah≠dana = error, bukan penyesuaian)
  - Pembulatan §91: clamp plus → ruang batas pengguna → floor kelipatan → cek batas akhir → Biasa residual; `kelebihanDialihkan` dilaporkan + pesan §90
  - `DanaSplitValidator` §90 (total sama, non-negatif, plus=0 saat nonaktif, batas, akumulasi eksekusi ≤ bulanan); `DanaLedgerService` §94 (saldo akhir kedua kantong; realisasi = pemindahan KE DANA+, bukan saldo); `DanaPlusRewardSimulator` §95 (sederhana/majemuk; tingkat wajib input pengguna, nol → 0)
  - Skema **v5→v4** (migrasi createTable): DanaPlusConfigurations (availability 4 status §88, mode, strategi 3 §87, persen/buffer/target/batas/tingkat reward+satuan — tidak ada nilai produk di-hard-code) + DanaBalanceLedgers (unik per periode); `DanaPlusRepository`
  - UI `/dana-plus` dari Pengaturan: status penggunaan (nonaktif → info "seluruh dana ke Biasa"), mode+strategi, pratinjau split alokasi bulan aktif, simulasi reward (disclaimer §95), form ledger 8 field + tampilan saldo akhir/realisasi; card DANA di Hasil menampilkan Saldo Biasa/Plus target bulanan bila aktif (§92)
  - Test: 18 unit split/validator/ledger/reward + 2 widget flow — total **151/151 lulus**, analyze 0 issue, APK OK
  - Catatan lingkup: rekomendasi §89 tercermin lewat pratinjau Smart Liquidity (tombol Gunakan/Sesuaikan ditunda); checklist eksekusi §93 & status realisasi 5 tingkat §94 ditunda
- **Fase 4C — Stockbit (2026-08-01, Bagian X):**
  - `StockbitReconciliationService` §112 (`lib/domain/services/stockbit_reconciliation_service.dart`, pure): realisasi pendanaan = deposit eksternal TERVERIFIKASI saja; arus bersih = deposit − penarikan; 5 status (ambang 80/100/110); target nol / data null / belum terverifikasi → tidakDapatDibandingkan dgn persen null
  - `InvestmentContributionService` §113/§115: kontribusi gabungan = pembelian Bibit terverifikasi + deposit Stockbit terverifikasi; pembelian Stockbit TIDAK dijumlahkan; penjualan/dividen/penarikan/saldo/nilai portofolio bukan kontribusi — 9 unit test aturan anti double counting
  - Skema **v5**: InvestmentActuals (per platform+periode unik, semua nominal nullable §53, verifikasi, sumber manual §116); `InvestmentActualRepository` (upsert per periode)
  - UI `/investasi-aktual` dari card Progres: form per platform (field Stockbit lengkap: deposit/penarikan/pembelian/penjualan/saldo RDN/biaya/dividen/portofolio/modal; Bibit subset), toggle terverifikasi, label "Dimasukkan manual"
  - Dashboard §114 di Progres: card Investasi Gabungan — target per platform (rencana), realisasi kontribusi gabungan/Bibit/pendanaan Stockbit, **realisasi pembelian Stockbit ditampilkan terpisah sebagai penggunaan dana**, status rekonsiliasi + persen
  - Integrasi skor §115: komponen konsistensi investasi AKTIF — maks 3 bulan terakhir bertarget dgn realisasi terverifikasi (helper `_konsistensiInvestasi` di data_providers)
  - Test: 9 unit rekonsiliasi/anti-double-counting + 2 widget flow (dashboard deposit≠pembelian; form→status berubah) — total **162/162 lulus**, analyze 0 issue, APK OK
  - Catatan lingkup: impor laporan Stockbit §117–§119 (file/parser) ditunda ke fase modul 2 Stockbit; sub-alokasi Stockbit §107 (buffer RDN/estimasi biaya) ditunda
- **Fase 4A — Impor Laporan Bibit (2026-08-01, Bagian VIII MVP §84):**
  - `BibitStatementParser` (`lib/domain/services/bibit_statement_parser.dart`, pure): `normalisasiAngka` §68 (Rp/ribuan titik-koma/desimal dibuang/kurung & minus negatif), `deteksiPeriode` (bulan ID/EN + dd/mm/yyyy pakai tanggal akhir), classifier §67 (keyword bibit+statement/laporan; tak dikenal → peringatan, pengguna tetap bisa koreksi), label multi-varian utk portofolio/modal/pembelian/penjualan, confidence tinggi/rendah §71 (tanpa persen — belum terkalibrasi), nilai tak ditemukan = null (§66 jangan mengarang)
  - Fingerprint §73: sha256 isi file, unik di DB; duplikat → pesan + blokir
  - Skema **v6**: ImportedReports (hash unik, file asli TIDAK disimpan §78); `ImportRepository.konfirmasiImporBibit` transaksional → upsert InvestmentActuals Bibit terverifikasi (rekonsiliasi §72 otomatis lewat dashboard 4C yang sudah ada)
  - UI `/impor-bibit` (dari dashboard Investasi Gabungan): Pilih PDF (file_picker) → ekstraksi teks di isolate `compute` + syncfusion PdfTextExtractor (§81, tanpa OCR §63) → pratinjau editable + helper confidence per field §70 → periode wajib → Konfirmasi Impor → snackbar; riwayat impor + hapus catatan
  - Test: 12 unit parser/normalizer/periode/fingerprint + 2 widget flow (pratinjau→konfirmasi→aktual terverifikasi; duplikat ditolak; provider ekstraksi di-override teks contoh) — total **176/176 lulus**, analyze 0 issue, APK OK
  - Dep baru: syncfusion_flutter_pdf, file_picker; **share_plus diturunkan ke ^12** (konflik win32 dgn file_picker); catatan: file_picker 3.x gagal di AGP9 — wajib ≥10
  - APK dirilis: `uji-fase4`
  - Catatan lingkup (Bagian VIII versi 2/lanjutan): Transaction History, KSEI, CSV/XLSX, OCR, share intent, PDF terproteksi §69 — belum
- **Permintaan pemilik proyek (2026-08-01):**
  - Toggle "Alokasikan ke Stockbit bulan ini" di langkah Pembagian (§106): nonaktif → Bibit 100%/Stockbit 0% (§12 Tahap 3), input pembagian internal disembunyikan, sub-card Stockbit & item checklist RDN tidak muncul; pilih preset saat nonaktif tetap mempertahankan nonaktif
  - Card "Pindahkan dari DANA+ ke DANA Biasa" di halaman DANA+: catat cepat penarikan → menambah `pindahDariPlus` ledger bulan ini; ditolak bila melebihi saldo DANA+ tercatat (§90 tanpa negatif)
  - Test +2 — total **178/178 lulus**, analyze 0 issue; asset APK `uji-fase4` diperbarui
- **Polish visual + rilis 0.1.0 (2026-08-01):**
  - Visual: hero card gradien emerald di Beranda + ikon mini card; header 4 card Hasil dgn avatar ikon warna platform; skor kesehatan jadi ring melingkar berwarna kategori; splash & onboarding ikon dalam lingkaran gradien/soft; avatar bulan di daftar Riwayat
  - Audit: analyze 0 issue, 178/178 test, tanpa print/TODO; versi disamakan 0.1.0 (pubspec + Pengaturan)
  - **RILIS v0.1.0 (pre-release)**: `flutter build apk --release` (76 MB universal, signing debug — belum utk Play Store), https://github.com/andiakbararyaputra/Finara/releases/tag/v0.1.0 ; seluruh release uji-fase1..4 + tag DIHAPUS sesuai permintaan

### BELUM selesai (pending — kerjakan saat lanjut)
1. Menuju rilis produksi (v1.0.0 / Play Store): keystore & signing release sendiri, ikon aplikasi & splash native asli (bukan ikon Material), `--split-per-abi` atau app bundle, acceptance §61 penuh, uji perangkat menyeluruh.
2. Backlog fitur tunda: fallback lintas provider §37, bagikan gambar §50, checklist DANA+ §93, rekomendasi §89, sub-alokasi Stockbit §107, impor Stockbit §117–§119, impor Bibit versi 2 (Transaction History/KSEI/CSV), PDF terproteksi §69.

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
