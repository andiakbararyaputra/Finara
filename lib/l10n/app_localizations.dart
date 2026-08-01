import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('id')];

  /// No description provided for @appName.
  ///
  /// In id, this message translates to:
  /// **'Finara'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In id, this message translates to:
  /// **'Setiap rupiah punya arah.'**
  String get appTagline;

  /// No description provided for @appDescription.
  ///
  /// In id, this message translates to:
  /// **'Finara membantu mengatur penghasilan, pengeluaran, tabungan, investasi, dan tujuan keuangan dalam satu aplikasi.'**
  String get appDescription;

  /// No description provided for @navBeranda.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get navBeranda;

  /// No description provided for @navHitung.
  ///
  /// In id, this message translates to:
  /// **'Hitung'**
  String get navHitung;

  /// No description provided for @navFinaraAi.
  ///
  /// In id, this message translates to:
  /// **'Finara AI'**
  String get navFinaraAi;

  /// No description provided for @navProgres.
  ///
  /// In id, this message translates to:
  /// **'Progres'**
  String get navProgres;

  /// No description provided for @navRiwayat.
  ///
  /// In id, this message translates to:
  /// **'Riwayat'**
  String get navRiwayat;

  /// No description provided for @pengaturan.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get pengaturan;

  /// No description provided for @tema.
  ///
  /// In id, this message translates to:
  /// **'Tema'**
  String get tema;

  /// No description provided for @temaTerang.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get temaTerang;

  /// No description provided for @temaGelap.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get temaGelap;

  /// No description provided for @temaSistem.
  ///
  /// In id, this message translates to:
  /// **'Ikuti sistem'**
  String get temaSistem;

  /// No description provided for @belumTersedia.
  ///
  /// In id, this message translates to:
  /// **'Belum tersedia'**
  String get belumTersedia;

  /// No description provided for @tidakTersedia.
  ///
  /// In id, this message translates to:
  /// **'Tidak tersedia'**
  String get tidakTersedia;

  /// No description provided for @rencana.
  ///
  /// In id, this message translates to:
  /// **'Rencana'**
  String get rencana;

  /// No description provided for @aktual.
  ///
  /// In id, this message translates to:
  /// **'Aktual'**
  String get aktual;

  /// No description provided for @estimasi.
  ///
  /// In id, this message translates to:
  /// **'Estimasi'**
  String get estimasi;

  /// No description provided for @anggaran.
  ///
  /// In id, this message translates to:
  /// **'Anggaran'**
  String get anggaran;

  /// No description provided for @hitungAlokasi.
  ///
  /// In id, this message translates to:
  /// **'Hitung Alokasi'**
  String get hitungAlokasi;

  /// No description provided for @tanyaFinaraAi.
  ///
  /// In id, this message translates to:
  /// **'Tanya Finara AI'**
  String get tanyaFinaraAi;

  /// No description provided for @berandaKosongJudul.
  ///
  /// In id, this message translates to:
  /// **'Belum ada alokasi bulan ini'**
  String get berandaKosongJudul;

  /// No description provided for @berandaKosongPesan.
  ///
  /// In id, this message translates to:
  /// **'Mulai dengan menghitung alokasi penghasilan bulan ini agar setiap rupiah punya arah.'**
  String get berandaKosongPesan;

  /// No description provided for @hitungKosongJudul.
  ///
  /// In id, this message translates to:
  /// **'Siap menghitung alokasi'**
  String get hitungKosongJudul;

  /// No description provided for @hitungKosongPesan.
  ///
  /// In id, this message translates to:
  /// **'Masukkan penghasilan dan pengeluaran wajib untuk membagi dana secara otomatis. Fitur ini sedang disiapkan pada fase pengembangan berikutnya.'**
  String get hitungKosongPesan;

  /// No description provided for @progresKosongJudul.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data progres'**
  String get progresKosongJudul;

  /// No description provided for @progresKosongPesan.
  ///
  /// In id, this message translates to:
  /// **'Progres dana darurat dan checklist akan tampil setelah alokasi pertama dibuat.'**
  String get progresKosongPesan;

  /// No description provided for @riwayatKosongJudul.
  ///
  /// In id, this message translates to:
  /// **'Belum ada riwayat'**
  String get riwayatKosongJudul;

  /// No description provided for @riwayatKosongPesan.
  ///
  /// In id, this message translates to:
  /// **'Setiap alokasi yang disimpan akan tercatat di sini beserta revisinya.'**
  String get riwayatKosongPesan;

  /// No description provided for @cobaLagi.
  ///
  /// In id, this message translates to:
  /// **'Coba lagi'**
  String get cobaLagi;

  /// No description provided for @terjadiKesalahan.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan'**
  String get terjadiKesalahan;

  /// No description provided for @onboarding1Judul.
  ///
  /// In id, this message translates to:
  /// **'Atur penghasilan dengan lebih terarah'**
  String get onboarding1Judul;

  /// No description provided for @onboarding1Isi.
  ///
  /// In id, this message translates to:
  /// **'Finara membantu membagi penghasilan ke kebutuhan, tabungan, investasi, dan uang jajan.'**
  String get onboarding1Isi;

  /// No description provided for @onboarding2Judul.
  ///
  /// In id, this message translates to:
  /// **'Bangun dana darurat'**
  String get onboarding2Judul;

  /// No description provided for @onboarding2Isi.
  ///
  /// In id, this message translates to:
  /// **'Tentukan target dan pantau perkembangan dana darurat setiap bulan.'**
  String get onboarding2Isi;

  /// No description provided for @onboardingAiJudul.
  ///
  /// In id, this message translates to:
  /// **'Dapatkan bantuan dari AI'**
  String get onboardingAiJudul;

  /// No description provided for @onboardingAiIsi.
  ///
  /// In id, this message translates to:
  /// **'Tanyakan hasil alokasi dan pelajari strategi keuangan melalui Finara AI.'**
  String get onboardingAiIsi;

  /// No description provided for @onboarding3Judul.
  ///
  /// In id, this message translates to:
  /// **'Data tetap dalam kendali Anda'**
  String get onboarding3Judul;

  /// No description provided for @onboarding3Isi.
  ///
  /// In id, this message translates to:
  /// **'Data disimpan secara aman dan tidak terhubung langsung ke rekening bank.'**
  String get onboarding3Isi;

  /// No description provided for @lewati.
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get lewati;

  /// No description provided for @berikutnya.
  ///
  /// In id, this message translates to:
  /// **'Berikutnya'**
  String get berikutnya;

  /// No description provided for @mulaiGunakan.
  ///
  /// In id, this message translates to:
  /// **'Mulai Gunakan Finara'**
  String get mulaiGunakan;

  /// No description provided for @langkahPendapatan.
  ///
  /// In id, this message translates to:
  /// **'Pendapatan'**
  String get langkahPendapatan;

  /// No description provided for @langkahPengeluaran.
  ///
  /// In id, this message translates to:
  /// **'Pengeluaran Wajib'**
  String get langkahPengeluaran;

  /// No description provided for @langkahPembagian.
  ///
  /// In id, this message translates to:
  /// **'Pembagian'**
  String get langkahPembagian;

  /// No description provided for @penghasilanUtama.
  ///
  /// In id, this message translates to:
  /// **'Penghasilan Utama'**
  String get penghasilanUtama;

  /// No description provided for @penghasilanUtamaWajib.
  ///
  /// In id, this message translates to:
  /// **'Penghasilan utama wajib lebih dari nol'**
  String get penghasilanUtamaWajib;

  /// No description provided for @kasPeganganBrimo.
  ///
  /// In id, this message translates to:
  /// **'Kas Pegangan BRImo'**
  String get kasPeganganBrimo;

  /// No description provided for @penghasilanTambahan.
  ///
  /// In id, this message translates to:
  /// **'Penghasilan Tambahan'**
  String get penghasilanTambahan;

  /// No description provided for @tambahPenghasilan.
  ///
  /// In id, this message translates to:
  /// **'Tambah penghasilan'**
  String get tambahPenghasilan;

  /// No description provided for @namaItem.
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get namaItem;

  /// No description provided for @nominal.
  ///
  /// In id, this message translates to:
  /// **'Nominal'**
  String get nominal;

  /// No description provided for @disertakanBulanIni.
  ///
  /// In id, this message translates to:
  /// **'Sertakan pada bulan aktif'**
  String get disertakanBulanIni;

  /// No description provided for @totalPendapatan.
  ///
  /// In id, this message translates to:
  /// **'Total Pendapatan'**
  String get totalPendapatan;

  /// No description provided for @pengeluaranWajib.
  ///
  /// In id, this message translates to:
  /// **'Pengeluaran Wajib'**
  String get pengeluaranWajib;

  /// No description provided for @tambahPengeluaran.
  ///
  /// In id, this message translates to:
  /// **'Tambah pengeluaran'**
  String get tambahPengeluaran;

  /// No description provided for @totalPengeluaranWajib.
  ///
  /// In id, this message translates to:
  /// **'Total Pengeluaran Wajib'**
  String get totalPengeluaranWajib;

  /// No description provided for @kanalPembayaran.
  ///
  /// In id, this message translates to:
  /// **'Kanal pembayaran'**
  String get kanalPembayaran;

  /// No description provided for @kanalBankJago.
  ///
  /// In id, this message translates to:
  /// **'Bank Jago'**
  String get kanalBankJago;

  /// No description provided for @kanalDana.
  ///
  /// In id, this message translates to:
  /// **'DANA'**
  String get kanalDana;

  /// No description provided for @kanalTunai.
  ///
  /// In id, this message translates to:
  /// **'Tunai'**
  String get kanalTunai;

  /// No description provided for @kanalBankLain.
  ///
  /// In id, this message translates to:
  /// **'Transfer bank lain'**
  String get kanalBankLain;

  /// No description provided for @kanalLainnya.
  ///
  /// In id, this message translates to:
  /// **'Lainnya'**
  String get kanalLainnya;

  /// No description provided for @dasarDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Dihitung dalam dasar dana darurat'**
  String get dasarDanaDarurat;

  /// No description provided for @pilihPreset.
  ///
  /// In id, this message translates to:
  /// **'Pilih preset'**
  String get pilihPreset;

  /// No description provided for @presetStandardHybrid.
  ///
  /// In id, this message translates to:
  /// **'Standard Hybrid'**
  String get presetStandardHybrid;

  /// No description provided for @presetInvestorFokus.
  ///
  /// In id, this message translates to:
  /// **'Investor Fokus'**
  String get presetInvestorFokus;

  /// No description provided for @presetPelajar.
  ///
  /// In id, this message translates to:
  /// **'Pelajar/Mahasiswa'**
  String get presetPelajar;

  /// No description provided for @presetKonservatif.
  ///
  /// In id, this message translates to:
  /// **'Konservatif'**
  String get presetKonservatif;

  /// No description provided for @presetCustom.
  ///
  /// In id, this message translates to:
  /// **'Custom'**
  String get presetCustom;

  /// No description provided for @bagianJago.
  ///
  /// In id, this message translates to:
  /// **'Bank Jago'**
  String get bagianJago;

  /// No description provided for @bagianInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Total Alokasi Investasi'**
  String get bagianInvestasi;

  /// No description provided for @bagianDana.
  ///
  /// In id, this message translates to:
  /// **'DANA'**
  String get bagianDana;

  /// No description provided for @bagianBibit.
  ///
  /// In id, this message translates to:
  /// **'Bibit'**
  String get bagianBibit;

  /// No description provided for @bagianStockbit.
  ///
  /// In id, this message translates to:
  /// **'Stockbit'**
  String get bagianStockbit;

  /// No description provided for @aktifkanStockbit.
  ///
  /// In id, this message translates to:
  /// **'Alokasikan ke Stockbit bulan ini'**
  String get aktifkanStockbit;

  /// No description provided for @stockbitNonaktifInfo.
  ///
  /// In id, this message translates to:
  /// **'Seluruh Total Alokasi Investasi masuk ke Bibit.'**
  String get stockbitNonaktifInfo;

  /// No description provided for @totalPersen.
  ///
  /// In id, this message translates to:
  /// **'Total: {persen}'**
  String totalPersen(String persen);

  /// No description provided for @wajibSeratusPersen.
  ///
  /// In id, this message translates to:
  /// **'Total persentase wajib tepat 100%'**
  String get wajibSeratusPersen;

  /// No description provided for @pembulatan.
  ///
  /// In id, this message translates to:
  /// **'Pembulatan'**
  String get pembulatan;

  /// No description provided for @pembulatanTanpa.
  ///
  /// In id, this message translates to:
  /// **'Tanpa pembulatan'**
  String get pembulatanTanpa;

  /// No description provided for @pembulatanSeribu.
  ///
  /// In id, this message translates to:
  /// **'Kelipatan Rp1.000'**
  String get pembulatanSeribu;

  /// No description provided for @pembulatanLimaRibu.
  ///
  /// In id, this message translates to:
  /// **'Kelipatan Rp5.000'**
  String get pembulatanLimaRibu;

  /// No description provided for @pembulatanSepuluhRibu.
  ///
  /// In id, this message translates to:
  /// **'Kelipatan Rp10.000'**
  String get pembulatanSepuluhRibu;

  /// No description provided for @frekuensiTopUpDana.
  ///
  /// In id, this message translates to:
  /// **'Jadwal top-up DANA'**
  String get frekuensiTopUpDana;

  /// No description provided for @frekuensiHarian.
  ///
  /// In id, this message translates to:
  /// **'Harian'**
  String get frekuensiHarian;

  /// No description provided for @frekuensiMingguan.
  ///
  /// In id, this message translates to:
  /// **'Mingguan'**
  String get frekuensiMingguan;

  /// No description provided for @frekuensiSekaligus.
  ///
  /// In id, this message translates to:
  /// **'Sekaligus'**
  String get frekuensiSekaligus;

  /// No description provided for @lanjut.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get lanjut;

  /// No description provided for @kembali.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get kembali;

  /// No description provided for @hitung.
  ///
  /// In id, this message translates to:
  /// **'Hitung'**
  String get hitung;

  /// No description provided for @hapus.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get hapus;

  /// No description provided for @batal.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get batal;

  /// No description provided for @simpan.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get simpan;

  /// No description provided for @hasilAlokasi.
  ///
  /// In id, this message translates to:
  /// **'Hasil Alokasi'**
  String get hasilAlokasi;

  /// No description provided for @danaBersih.
  ///
  /// In id, this message translates to:
  /// **'Dana Bersih'**
  String get danaBersih;

  /// No description provided for @selisihBelumDialokasikan.
  ///
  /// In id, this message translates to:
  /// **'Selisih Belum Dialokasikan'**
  String get selisihBelumDialokasikan;

  /// No description provided for @kartuBrimo.
  ///
  /// In id, this message translates to:
  /// **'BRImo'**
  String get kartuBrimo;

  /// No description provided for @kartuJago.
  ///
  /// In id, this message translates to:
  /// **'Bank Jago'**
  String get kartuJago;

  /// No description provided for @kartuInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Investasi'**
  String get kartuInvestasi;

  /// No description provided for @kartuDana.
  ///
  /// In id, this message translates to:
  /// **'DANA'**
  String get kartuDana;

  /// No description provided for @kasPeganganRencana.
  ///
  /// In id, this message translates to:
  /// **'Kas Pegangan BRImo — Rencana'**
  String get kasPeganganRencana;

  /// No description provided for @totalTransferAwalJago.
  ///
  /// In id, this message translates to:
  /// **'Total Transfer Awal ke Bank Jago — Rencana'**
  String get totalTransferAwalJago;

  /// No description provided for @kantongPengeluaranWajib.
  ///
  /// In id, this message translates to:
  /// **'Kantong Pengeluaran Wajib'**
  String get kantongPengeluaranWajib;

  /// No description provided for @alokasiJagoDariDanaBersih.
  ///
  /// In id, this message translates to:
  /// **'Alokasi Bank Jago dari Dana Bersih'**
  String get alokasiJagoDariDanaBersih;

  /// No description provided for @kantongLangganan.
  ///
  /// In id, this message translates to:
  /// **'Langganan'**
  String get kantongLangganan;

  /// No description provided for @kantongDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Dana darurat'**
  String get kantongDanaDarurat;

  /// No description provided for @kantongOperasional.
  ///
  /// In id, this message translates to:
  /// **'Dana operasional tambahan'**
  String get kantongOperasional;

  /// No description provided for @totalAlokasiInvestasiRencana.
  ///
  /// In id, this message translates to:
  /// **'Total Alokasi Investasi — Rencana'**
  String get totalAlokasiInvestasiRencana;

  /// No description provided for @alokasiBibitRencana.
  ///
  /// In id, this message translates to:
  /// **'Alokasi Bibit — Rencana'**
  String get alokasiBibitRencana;

  /// No description provided for @alokasiStockbitRencana.
  ///
  /// In id, this message translates to:
  /// **'Alokasi Stockbit — Rencana'**
  String get alokasiStockbitRencana;

  /// No description provided for @targetTransferRdn.
  ///
  /// In id, this message translates to:
  /// **'Target transfer ke RDN'**
  String get targetTransferRdn;

  /// No description provided for @persenDariDanaBersih.
  ///
  /// In id, this message translates to:
  /// **'{persen} dari Dana Bersih'**
  String persenDariDanaBersih(String persen);

  /// No description provided for @persenDariTotalPendapatan.
  ///
  /// In id, this message translates to:
  /// **'{persen} dari Total Pendapatan'**
  String persenDariTotalPendapatan(String persen);

  /// No description provided for @persenDariInvestasi.
  ///
  /// In id, this message translates to:
  /// **'{persen} dari Total Alokasi Investasi'**
  String persenDariInvestasi(String persen);

  /// No description provided for @peringatanRisikoInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Investasi mengandung risiko. Nilai dapat naik atau turun.'**
  String get peringatanRisikoInvestasi;

  /// No description provided for @totalAlokasiDanaRencana.
  ///
  /// In id, this message translates to:
  /// **'Total Alokasi DANA — Rencana'**
  String get totalAlokasiDanaRencana;

  /// No description provided for @anggaranHarianDasar.
  ///
  /// In id, this message translates to:
  /// **'Anggaran harian dasar'**
  String get anggaranHarianDasar;

  /// No description provided for @anggaranPerTopUp.
  ///
  /// In id, this message translates to:
  /// **'Anggaran per top-up'**
  String get anggaranPerTopUp;

  /// No description provided for @jadwalTopUp.
  ///
  /// In id, this message translates to:
  /// **'Jadwal top-up'**
  String get jadwalTopUp;

  /// No description provided for @salinNominal.
  ///
  /// In id, this message translates to:
  /// **'Salin nominal'**
  String get salinNominal;

  /// No description provided for @nominalTersalin.
  ///
  /// In id, this message translates to:
  /// **'Nominal disalin'**
  String get nominalTersalin;

  /// No description provided for @simpanKeRiwayat.
  ///
  /// In id, this message translates to:
  /// **'Simpan ke Riwayat'**
  String get simpanKeRiwayat;

  /// No description provided for @tersimpanKeRiwayat.
  ///
  /// In id, this message translates to:
  /// **'Alokasi tersimpan ke riwayat'**
  String get tersimpanKeRiwayat;

  /// No description provided for @kategoriKebutuhan.
  ///
  /// In id, this message translates to:
  /// **'Kebutuhan'**
  String get kategoriKebutuhan;

  /// No description provided for @kategoriKasPegangan.
  ///
  /// In id, this message translates to:
  /// **'Kas Pegangan'**
  String get kategoriKasPegangan;

  /// No description provided for @kategoriTabungan.
  ///
  /// In id, this message translates to:
  /// **'Tabungan'**
  String get kategoriTabungan;

  /// No description provided for @kategoriInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Investasi'**
  String get kategoriInvestasi;

  /// No description provided for @kategoriUangJajan.
  ///
  /// In id, this message translates to:
  /// **'Uang Jajan'**
  String get kategoriUangJajan;

  /// No description provided for @kategoriOperasional.
  ///
  /// In id, this message translates to:
  /// **'Operasional Tambahan'**
  String get kategoriOperasional;

  /// No description provided for @statusDraf.
  ///
  /// In id, this message translates to:
  /// **'Draf'**
  String get statusDraf;

  /// No description provided for @statusDikonfirmasi.
  ///
  /// In id, this message translates to:
  /// **'Dikonfirmasi'**
  String get statusDikonfirmasi;

  /// No description provided for @statusDikunci.
  ///
  /// In id, this message translates to:
  /// **'Dikunci'**
  String get statusDikunci;

  /// No description provided for @statusDirevisi.
  ///
  /// In id, this message translates to:
  /// **'Direvisi'**
  String get statusDirevisi;

  /// No description provided for @revisiKe.
  ///
  /// In id, this message translates to:
  /// **'Revisi {nomor}'**
  String revisiKe(int nomor);

  /// No description provided for @konfirmasiAlokasi.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Alokasi'**
  String get konfirmasiAlokasi;

  /// No description provided for @checklistTransfer.
  ///
  /// In id, this message translates to:
  /// **'Checklist Transfer'**
  String get checklistTransfer;

  /// No description provided for @checklistSelesaiDari.
  ///
  /// In id, this message translates to:
  /// **'{selesai} dari {total} selesai'**
  String checklistSelesaiDari(int selesai, int total);

  /// No description provided for @hapusRiwayatJudul.
  ///
  /// In id, this message translates to:
  /// **'Hapus riwayat bulan ini?'**
  String get hapusRiwayatJudul;

  /// No description provided for @hapusRiwayatPesan.
  ///
  /// In id, this message translates to:
  /// **'Seluruh revisi dan checklist bulan ini akan dihapus permanen.'**
  String get hapusRiwayatPesan;

  /// No description provided for @ckSisakanKasPegangan.
  ///
  /// In id, this message translates to:
  /// **'Sisakan Kas Pegangan BRImo'**
  String get ckSisakanKasPegangan;

  /// No description provided for @ckTransferDanaMasukJago.
  ///
  /// In id, this message translates to:
  /// **'Transfer Total Dana Masuk ke Bank Jago dari BRImo'**
  String get ckTransferDanaMasukJago;

  /// No description provided for @ckPisahkanKantongWajib.
  ///
  /// In id, this message translates to:
  /// **'Pisahkan Total Pengeluaran Wajib ke Kantong Pengeluaran Wajib'**
  String get ckPisahkanKantongWajib;

  /// No description provided for @ckPisahkanAlokasiJago.
  ///
  /// In id, this message translates to:
  /// **'Pisahkan Alokasi Bank Jago ke kantong internal'**
  String get ckPisahkanAlokasiJago;

  /// No description provided for @ckIsiKantongLangganan.
  ///
  /// In id, this message translates to:
  /// **'Masukkan dana langganan ke Kantong Langganan'**
  String get ckIsiKantongLangganan;

  /// No description provided for @ckIsiKantongDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kontribusi dana darurat ke Kantong Dana Darurat'**
  String get ckIsiKantongDanaDarurat;

  /// No description provided for @ckIsiKantongOperasional.
  ///
  /// In id, this message translates to:
  /// **'Masukkan dana operasional ke Kantong Operasional'**
  String get ckIsiKantongOperasional;

  /// No description provided for @ckTopUpBibit.
  ///
  /// In id, this message translates to:
  /// **'Top-up investasi ke Bibit sesuai Alokasi Bibit'**
  String get ckTopUpBibit;

  /// No description provided for @ckTransferRdnStockbit.
  ///
  /// In id, this message translates to:
  /// **'Transfer kontribusi Stockbit ke RDN'**
  String get ckTransferRdnStockbit;

  /// No description provided for @ckVerifikasiRdnCatatTerpisah.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi transfer RDN dan catat pembelian saham terpisah'**
  String get ckVerifikasiRdnCatatTerpisah;

  /// No description provided for @ckTopUpDana.
  ///
  /// In id, this message translates to:
  /// **'Top-up Alokasi DANA sesuai jadwal'**
  String get ckTopUpDana;

  /// No description provided for @ckPindahkanWajibKeDana.
  ///
  /// In id, this message translates to:
  /// **'Pindahkan {nama} dari Kantong Pengeluaran Wajib ke DANA'**
  String ckPindahkanWajibKeDana(String nama);

  /// No description provided for @ckTarikWajibTunai.
  ///
  /// In id, this message translates to:
  /// **'Tarik tunai {nama} dari Kantong Pengeluaran Wajib'**
  String ckTarikWajibTunai(String nama);

  /// No description provided for @ckPindahkanWajibKeBankLain.
  ///
  /// In id, this message translates to:
  /// **'Pindahkan {nama} dari Kantong Pengeluaran Wajib ke rekening tujuan'**
  String ckPindahkanWajibKeBankLain(String nama);

  /// No description provided for @ckPeriksaSatuSumberAnggaran.
  ///
  /// In id, this message translates to:
  /// **'Pastikan tidak ada item dibiayai dua sumber anggaran'**
  String get ckPeriksaSatuSumberAnggaran;

  /// No description provided for @ckPeriksaPemindahanBukanPengeluaran.
  ///
  /// In id, this message translates to:
  /// **'Pastikan pemindahan antarplatform tidak dicatat sebagai pengeluaran'**
  String get ckPeriksaPemindahanBukanPengeluaran;

  /// No description provided for @progresDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Progres Dana Darurat'**
  String get progresDanaDarurat;

  /// No description provided for @skorKesehatan.
  ///
  /// In id, this message translates to:
  /// **'Financial Health Score'**
  String get skorKesehatan;

  /// No description provided for @skorTidakTersedia.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data untuk menghitung skor'**
  String get skorTidakTersedia;

  /// No description provided for @kelengkapanData.
  ///
  /// In id, this message translates to:
  /// **'Kelengkapan data {persen}'**
  String kelengkapanData(String persen);

  /// No description provided for @kategoriPerluPerhatian.
  ///
  /// In id, this message translates to:
  /// **'Perlu perhatian'**
  String get kategoriPerluPerhatian;

  /// No description provided for @kategoriCukupBerisiko.
  ///
  /// In id, this message translates to:
  /// **'Cukup berisiko'**
  String get kategoriCukupBerisiko;

  /// No description provided for @kategoriCukupSehat.
  ///
  /// In id, this message translates to:
  /// **'Cukup sehat'**
  String get kategoriCukupSehat;

  /// No description provided for @kategoriSangatSehat.
  ///
  /// In id, this message translates to:
  /// **'Sangat sehat'**
  String get kategoriSangatSehat;

  /// No description provided for @basisRencana.
  ///
  /// In id, this message translates to:
  /// **'Basis: rencana'**
  String get basisRencana;

  /// No description provided for @basisAktual.
  ///
  /// In id, this message translates to:
  /// **'Basis: aktual'**
  String get basisAktual;

  /// No description provided for @kompDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Kecukupan dana darurat'**
  String get kompDanaDarurat;

  /// No description provided for @kompRasioWajib.
  ///
  /// In id, this message translates to:
  /// **'Rasio pengeluaran wajib'**
  String get kompRasioWajib;

  /// No description provided for @kompRasioCicilan.
  ///
  /// In id, this message translates to:
  /// **'Rasio cicilan'**
  String get kompRasioCicilan;

  /// No description provided for @kompKonsistensiInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Konsistensi investasi'**
  String get kompKonsistensiInvestasi;

  /// No description provided for @kompRasioUangJajan.
  ///
  /// In id, this message translates to:
  /// **'Rasio uang jajan'**
  String get kompRasioUangJajan;

  /// No description provided for @kompChecklist.
  ///
  /// In id, this message translates to:
  /// **'Penyelesaian checklist'**
  String get kompChecklist;

  /// No description provided for @poinDariBobot.
  ///
  /// In id, this message translates to:
  /// **'{poin}/{bobot}'**
  String poinDariBobot(int poin, int bobot);

  /// No description provided for @savingsRateRencana.
  ///
  /// In id, this message translates to:
  /// **'Savings Rate — Rencana'**
  String get savingsRateRencana;

  /// No description provided for @savingsRateAktual.
  ///
  /// In id, this message translates to:
  /// **'Savings Rate — Aktual'**
  String get savingsRateAktual;

  /// No description provided for @perbandinganBulanan.
  ///
  /// In id, this message translates to:
  /// **'Perbandingan bulanan'**
  String get perbandinganBulanan;

  /// No description provided for @simulasi.
  ///
  /// In id, this message translates to:
  /// **'Simulasi'**
  String get simulasi;

  /// No description provided for @bagaimanaJika.
  ///
  /// In id, this message translates to:
  /// **'Bagaimana Jika'**
  String get bagaimanaJika;

  /// No description provided for @simulasiCatatan.
  ///
  /// In id, this message translates to:
  /// **'Perubahan simulasi tidak mengubah data utama.'**
  String get simulasiCatatan;

  /// No description provided for @sebelum.
  ///
  /// In id, this message translates to:
  /// **'Sebelum'**
  String get sebelum;

  /// No description provided for @sesudah.
  ///
  /// In id, this message translates to:
  /// **'Sesudah'**
  String get sesudah;

  /// No description provided for @investasiPerTahun.
  ///
  /// In id, this message translates to:
  /// **'Investasi per tahun'**
  String get investasiPerTahun;

  /// No description provided for @muatDariBulanAktif.
  ///
  /// In id, this message translates to:
  /// **'Dimuat dari alokasi bulan aktif'**
  String get muatDariBulanAktif;

  /// No description provided for @salinSebagaiTeks.
  ///
  /// In id, this message translates to:
  /// **'Salin sebagai teks'**
  String get salinSebagaiTeks;

  /// No description provided for @bagikan.
  ///
  /// In id, this message translates to:
  /// **'Bagikan'**
  String get bagikan;

  /// No description provided for @hasilTersalin.
  ///
  /// In id, this message translates to:
  /// **'Hasil disalin'**
  String get hasilTersalin;

  /// No description provided for @tambahProvider.
  ///
  /// In id, this message translates to:
  /// **'Tambah penyedia'**
  String get tambahProvider;

  /// No description provided for @pilihProvider.
  ///
  /// In id, this message translates to:
  /// **'Pilih penyedia'**
  String get pilihProvider;

  /// No description provided for @allowedModels.
  ///
  /// In id, this message translates to:
  /// **'Model yang diizinkan'**
  String get allowedModels;

  /// No description provided for @modeIzinkanSemua.
  ///
  /// In id, this message translates to:
  /// **'Izinkan semua model'**
  String get modeIzinkanSemua;

  /// No description provided for @modeHanyaTertentu.
  ///
  /// In id, this message translates to:
  /// **'Hanya model tertentu'**
  String get modeHanyaTertentu;

  /// No description provided for @modeHanyaFavorit.
  ///
  /// In id, this message translates to:
  /// **'Hanya model favorit'**
  String get modeHanyaFavorit;

  /// No description provided for @blokirModel.
  ///
  /// In id, this message translates to:
  /// **'Blokir model'**
  String get blokirModel;

  /// No description provided for @bukaBlokirModel.
  ///
  /// In id, this message translates to:
  /// **'Buka blokir'**
  String get bukaBlokirModel;

  /// No description provided for @masukkanAllowlist.
  ///
  /// In id, this message translates to:
  /// **'Masukkan daftar izin'**
  String get masukkanAllowlist;

  /// No description provided for @keluarkanAllowlist.
  ///
  /// In id, this message translates to:
  /// **'Keluarkan dari daftar izin'**
  String get keluarkanAllowlist;

  /// No description provided for @tesModel.
  ///
  /// In id, this message translates to:
  /// **'Tes Model'**
  String get tesModel;

  /// No description provided for @tesStreaming.
  ///
  /// In id, this message translates to:
  /// **'Tes Streaming'**
  String get tesStreaming;

  /// No description provided for @statusUnknown.
  ///
  /// In id, this message translates to:
  /// **'Belum terverifikasi'**
  String get statusUnknown;

  /// No description provided for @statusClaimed.
  ///
  /// In id, this message translates to:
  /// **'Diklaim'**
  String get statusClaimed;

  /// No description provided for @statusVerified.
  ///
  /// In id, this message translates to:
  /// **'Terverifikasi'**
  String get statusVerified;

  /// No description provided for @statusUnsupported.
  ///
  /// In id, this message translates to:
  /// **'Tidak didukung'**
  String get statusUnsupported;

  /// No description provided for @fallbackModel1.
  ///
  /// In id, this message translates to:
  /// **'Model cadangan pertama'**
  String get fallbackModel1;

  /// No description provided for @fallbackModel2.
  ///
  /// In id, this message translates to:
  /// **'Model cadangan kedua'**
  String get fallbackModel2;

  /// No description provided for @tanpaFallback.
  ///
  /// In id, this message translates to:
  /// **'Tanpa fallback'**
  String get tanpaFallback;

  /// No description provided for @beralihKeCadangan.
  ///
  /// In id, this message translates to:
  /// **'Beralih ke model cadangan {model}'**
  String beralihKeCadangan(String model);

  /// No description provided for @aturHarga.
  ///
  /// In id, this message translates to:
  /// **'Atur harga token'**
  String get aturHarga;

  /// No description provided for @hargaInputPerJuta.
  ///
  /// In id, this message translates to:
  /// **'Harga input per 1 juta token'**
  String get hargaInputPerJuta;

  /// No description provided for @hargaOutputPerJuta.
  ///
  /// In id, this message translates to:
  /// **'Harga output per 1 juta token'**
  String get hargaOutputPerJuta;

  /// No description provided for @estimasiBiayaTerakhir.
  ///
  /// In id, this message translates to:
  /// **'Estimasi permintaan terakhir: ±{token} token · {biaya}'**
  String estimasiBiayaTerakhir(int token, String biaya);

  /// No description provided for @disclaimerBiaya.
  ///
  /// In id, this message translates to:
  /// **'Estimasi dapat berbeda dari tagihan penyedia.'**
  String get disclaimerBiaya;

  /// No description provided for @retensiChat.
  ///
  /// In id, this message translates to:
  /// **'Retensi riwayat percakapan'**
  String get retensiChat;

  /// No description provided for @retensiSelamanya.
  ///
  /// In id, this message translates to:
  /// **'Simpan sampai dihapus'**
  String get retensiSelamanya;

  /// No description provided for @retensiHari.
  ///
  /// In id, this message translates to:
  /// **'Hapus otomatis setelah {hari} hari'**
  String retensiHari(int hari);

  /// No description provided for @hapusSemuaPercakapan.
  ///
  /// In id, this message translates to:
  /// **'Hapus semua percakapan'**
  String get hapusSemuaPercakapan;

  /// No description provided for @eksporCsv.
  ///
  /// In id, this message translates to:
  /// **'Ekspor CSV'**
  String get eksporCsv;

  /// No description provided for @eksporPdf.
  ///
  /// In id, this message translates to:
  /// **'Ekspor PDF'**
  String get eksporPdf;

  /// No description provided for @danaPlusJudul.
  ///
  /// In id, this message translates to:
  /// **'DANA dan DANA+'**
  String get danaPlusJudul;

  /// No description provided for @statusDanaPlus.
  ///
  /// In id, this message translates to:
  /// **'Status penggunaan DANA+'**
  String get statusDanaPlus;

  /// No description provided for @dpMenggunakan.
  ///
  /// In id, this message translates to:
  /// **'Saya menggunakan DANA+'**
  String get dpMenggunakan;

  /// No description provided for @dpBelumMenggunakan.
  ///
  /// In id, this message translates to:
  /// **'Saya belum menggunakan DANA+'**
  String get dpBelumMenggunakan;

  /// No description provided for @dpTidakTersedia.
  ///
  /// In id, this message translates to:
  /// **'Fitur DANA+ belum tersedia di akun saya'**
  String get dpTidakTersedia;

  /// No description provided for @dpTidakIngin.
  ///
  /// In id, this message translates to:
  /// **'Saya tidak ingin menggunakan DANA+'**
  String get dpTidakIngin;

  /// No description provided for @modePembagian.
  ///
  /// In id, this message translates to:
  /// **'Mode pembagian'**
  String get modePembagian;

  /// No description provided for @modeSmartLiquidity.
  ///
  /// In id, this message translates to:
  /// **'Smart Liquidity (disarankan)'**
  String get modeSmartLiquidity;

  /// No description provided for @modePersentase.
  ///
  /// In id, this message translates to:
  /// **'Persentase'**
  String get modePersentase;

  /// No description provided for @modeNominalBiasa.
  ///
  /// In id, this message translates to:
  /// **'Nominal tetap DANA Biasa'**
  String get modeNominalBiasa;

  /// No description provided for @modeNominalPlus.
  ///
  /// In id, this message translates to:
  /// **'Nominal tetap DANA+'**
  String get modeNominalPlus;

  /// No description provided for @modeManual.
  ///
  /// In id, this message translates to:
  /// **'Manual'**
  String get modeManual;

  /// No description provided for @strategiEksekusi.
  ///
  /// In id, this message translates to:
  /// **'Strategi eksekusi top-up'**
  String get strategiEksekusi;

  /// No description provided for @strategiSekaligus.
  ///
  /// In id, this message translates to:
  /// **'Top-up sekaligus lalu bagi'**
  String get strategiSekaligus;

  /// No description provided for @strategiPerTopUp.
  ///
  /// In id, this message translates to:
  /// **'Bagi setiap top-up'**
  String get strategiPerTopUp;

  /// No description provided for @strategiSmartPerTopUp.
  ///
  /// In id, this message translates to:
  /// **'Hitung ulang Smart Liquidity per top-up'**
  String get strategiSmartPerTopUp;

  /// No description provided for @persenBiasa.
  ///
  /// In id, this message translates to:
  /// **'Persentase DANA Biasa'**
  String get persenBiasa;

  /// No description provided for @bufferBiasa.
  ///
  /// In id, this message translates to:
  /// **'Nominal buffer DANA Biasa'**
  String get bufferBiasa;

  /// No description provided for @targetPlusLabel.
  ///
  /// In id, this message translates to:
  /// **'Target nominal DANA+'**
  String get targetPlusLabel;

  /// No description provided for @batasPlusLabel.
  ///
  /// In id, this message translates to:
  /// **'Batas saldo DANA+ (opsional)'**
  String get batasPlusLabel;

  /// No description provided for @tingkatReward.
  ///
  /// In id, this message translates to:
  /// **'Estimasi reward (%, opsional)'**
  String get tingkatReward;

  /// No description provided for @periodeReward.
  ///
  /// In id, this message translates to:
  /// **'Satuan tingkat'**
  String get periodeReward;

  /// No description provided for @perHari.
  ///
  /// In id, this message translates to:
  /// **'Per hari'**
  String get perHari;

  /// No description provided for @perBulan.
  ///
  /// In id, this message translates to:
  /// **'Per bulan'**
  String get perBulan;

  /// No description provided for @perTahun.
  ///
  /// In id, this message translates to:
  /// **'Per tahun'**
  String get perTahun;

  /// No description provided for @saldoDanaBiasa.
  ///
  /// In id, this message translates to:
  /// **'Saldo DANA Biasa'**
  String get saldoDanaBiasa;

  /// No description provided for @saldoDanaPlus.
  ///
  /// In id, this message translates to:
  /// **'Saldo DANA+'**
  String get saldoDanaPlus;

  /// No description provided for @danaPlusNonaktifInfo.
  ///
  /// In id, this message translates to:
  /// **'Seluruh dana DANA yang dieksekusi ditempatkan pada Saldo DANA Biasa.'**
  String get danaPlusNonaktifInfo;

  /// No description provided for @kelebihanBatasInfo.
  ///
  /// In id, this message translates to:
  /// **'Target pemindahan ke DANA+ melebihi ruang saldo berdasarkan batas yang Anda masukkan. Selisih tetap berada pada Saldo DANA Biasa.'**
  String get kelebihanBatasInfo;

  /// No description provided for @simulasiReward.
  ///
  /// In id, this message translates to:
  /// **'Simulasi pertumbuhan DANA+'**
  String get simulasiReward;

  /// No description provided for @estimasiPertumbuhan.
  ///
  /// In id, this message translates to:
  /// **'Estimasi pertumbuhan 12 periode'**
  String get estimasiPertumbuhan;

  /// No description provided for @disclaimerReward.
  ///
  /// In id, this message translates to:
  /// **'Perhitungan ini hanya simulasi berdasarkan tingkat yang Anda masukkan. Reward, ketentuan, batas saldo, dan ketersediaan DANA+ dapat berubah mengikuti kebijakan penyedia.'**
  String get disclaimerReward;

  /// No description provided for @catatLedgerDana.
  ///
  /// In id, this message translates to:
  /// **'Catat ledger DANA bulan ini'**
  String get catatLedgerDana;

  /// No description provided for @saldoAwal.
  ///
  /// In id, this message translates to:
  /// **'Saldo awal'**
  String get saldoAwal;

  /// No description provided for @topUpKeBiasa.
  ///
  /// In id, this message translates to:
  /// **'Top-up ke DANA Biasa'**
  String get topUpKeBiasa;

  /// No description provided for @pindahKePlus.
  ///
  /// In id, this message translates to:
  /// **'Pemindahan ke DANA+'**
  String get pindahKePlus;

  /// No description provided for @pindahDariPlus.
  ///
  /// In id, this message translates to:
  /// **'Pemindahan keluar dari DANA+'**
  String get pindahDariPlus;

  /// No description provided for @pengeluaranDari.
  ///
  /// In id, this message translates to:
  /// **'Pengeluaran dari {kantong}'**
  String pengeluaranDari(String kantong);

  /// No description provided for @rewardAktual.
  ///
  /// In id, this message translates to:
  /// **'Reward aktual'**
  String get rewardAktual;

  /// No description provided for @saldoAkhir.
  ///
  /// In id, this message translates to:
  /// **'Saldo akhir'**
  String get saldoAkhir;

  /// No description provided for @realisasiPindahPlus.
  ///
  /// In id, this message translates to:
  /// **'Realisasi pemindahan ke DANA+'**
  String get realisasiPindahPlus;

  /// No description provided for @tarikDariPlusJudul.
  ///
  /// In id, this message translates to:
  /// **'Pindahkan dari DANA+ ke DANA Biasa'**
  String get tarikDariPlusJudul;

  /// No description provided for @tarikDariPlusTolak.
  ///
  /// In id, this message translates to:
  /// **'Nominal melebihi saldo DANA+ tercatat. Catat saldo DANA+ pada ledger terlebih dahulu.'**
  String get tarikDariPlusTolak;

  /// No description provided for @catat.
  ///
  /// In id, this message translates to:
  /// **'Catat'**
  String get catat;

  /// No description provided for @pemindahanTercatat.
  ///
  /// In id, this message translates to:
  /// **'Pemindahan tercatat di ledger bulan ini'**
  String get pemindahanTercatat;

  /// No description provided for @investasiAktual.
  ///
  /// In id, this message translates to:
  /// **'Investasi Aktual'**
  String get investasiAktual;

  /// No description provided for @catatInvestasiAktual.
  ///
  /// In id, this message translates to:
  /// **'Catat Investasi Aktual'**
  String get catatInvestasiAktual;

  /// No description provided for @platformLabel.
  ///
  /// In id, this message translates to:
  /// **'Platform'**
  String get platformLabel;

  /// No description provided for @depositEksternal.
  ///
  /// In id, this message translates to:
  /// **'Deposit eksternal ke RDN'**
  String get depositEksternal;

  /// No description provided for @penarikanRdn.
  ///
  /// In id, this message translates to:
  /// **'Penarikan dari RDN'**
  String get penarikanRdn;

  /// No description provided for @pembelianBersih.
  ///
  /// In id, this message translates to:
  /// **'Total pembelian (bersih)'**
  String get pembelianBersih;

  /// No description provided for @penjualanBersih.
  ///
  /// In id, this message translates to:
  /// **'Total penjualan (bersih)'**
  String get penjualanBersih;

  /// No description provided for @saldoRdnAwal.
  ///
  /// In id, this message translates to:
  /// **'Saldo RDN awal'**
  String get saldoRdnAwal;

  /// No description provided for @saldoRdnAkhir.
  ///
  /// In id, this message translates to:
  /// **'Saldo RDN akhir'**
  String get saldoRdnAkhir;

  /// No description provided for @biayaTransaksi.
  ///
  /// In id, this message translates to:
  /// **'Biaya transaksi'**
  String get biayaTransaksi;

  /// No description provided for @dividen.
  ///
  /// In id, this message translates to:
  /// **'Dividen'**
  String get dividen;

  /// No description provided for @nilaiPortofolio.
  ///
  /// In id, this message translates to:
  /// **'Nilai portofolio'**
  String get nilaiPortofolio;

  /// No description provided for @modalInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Modal investasi'**
  String get modalInvestasi;

  /// No description provided for @tandaiTerverifikasi.
  ///
  /// In id, this message translates to:
  /// **'Tandai terverifikasi'**
  String get tandaiTerverifikasi;

  /// No description provided for @dimasukkanManual.
  ///
  /// In id, this message translates to:
  /// **'Dimasukkan manual'**
  String get dimasukkanManual;

  /// No description provided for @investasiGabungan.
  ///
  /// In id, this message translates to:
  /// **'Investasi Gabungan'**
  String get investasiGabungan;

  /// No description provided for @realisasiKontribusiGabungan.
  ///
  /// In id, this message translates to:
  /// **'Realisasi kontribusi gabungan'**
  String get realisasiKontribusiGabungan;

  /// No description provided for @realisasiKontribusiBibit.
  ///
  /// In id, this message translates to:
  /// **'Realisasi kontribusi Bibit'**
  String get realisasiKontribusiBibit;

  /// No description provided for @realisasiPendanaanStockbit.
  ///
  /// In id, this message translates to:
  /// **'Realisasi Pendanaan Stockbit'**
  String get realisasiPendanaanStockbit;

  /// No description provided for @realisasiPembelianStockbit.
  ///
  /// In id, this message translates to:
  /// **'Realisasi pembelian Stockbit (penggunaan dana)'**
  String get realisasiPembelianStockbit;

  /// No description provided for @statusBelumTercapai.
  ///
  /// In id, this message translates to:
  /// **'Belum tercapai'**
  String get statusBelumTercapai;

  /// No description provided for @statusMendekatiTarget.
  ///
  /// In id, this message translates to:
  /// **'Mendekati target'**
  String get statusMendekatiTarget;

  /// No description provided for @statusSesuaiTarget.
  ///
  /// In id, this message translates to:
  /// **'Sesuai target'**
  String get statusSesuaiTarget;

  /// No description provided for @statusMelebihiTarget.
  ///
  /// In id, this message translates to:
  /// **'Melebihi target'**
  String get statusMelebihiTarget;

  /// No description provided for @statusTidakDapatDibandingkan.
  ///
  /// In id, this message translates to:
  /// **'Tidak dapat dibandingkan'**
  String get statusTidakDapatDibandingkan;

  /// No description provided for @imporLaporanBibit.
  ///
  /// In id, this message translates to:
  /// **'Impor Laporan Bibit'**
  String get imporLaporanBibit;

  /// No description provided for @pilihPdf.
  ///
  /// In id, this message translates to:
  /// **'Pilih PDF'**
  String get pilihPdf;

  /// No description provided for @lihatRiwayatImpor.
  ///
  /// In id, this message translates to:
  /// **'Riwayat impor'**
  String get lihatRiwayatImpor;

  /// No description provided for @sedangMembacaDokumen.
  ///
  /// In id, this message translates to:
  /// **'Membaca dokumen…'**
  String get sedangMembacaDokumen;

  /// No description provided for @jenisTidakDikenali.
  ///
  /// In id, this message translates to:
  /// **'Finara belum dapat memastikan jenis laporan ini. Periksa nilai di bawah secara manual.'**
  String get jenisTidakDikenali;

  /// No description provided for @dokumenDuplikat.
  ///
  /// In id, this message translates to:
  /// **'Laporan atau transaksi serupa sudah pernah diimpor.'**
  String get dokumenDuplikat;

  /// No description provided for @periodeLaporan.
  ///
  /// In id, this message translates to:
  /// **'Periode laporan (bulan/tahun)'**
  String get periodeLaporan;

  /// No description provided for @confidenceTinggi.
  ///
  /// In id, this message translates to:
  /// **'Terbaca dengan baik'**
  String get confidenceTinggi;

  /// No description provided for @confidenceRendah.
  ///
  /// In id, this message translates to:
  /// **'Perlu diperiksa'**
  String get confidenceRendah;

  /// No description provided for @konfirmasiImpor.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Impor'**
  String get konfirmasiImpor;

  /// No description provided for @imporBerhasil.
  ///
  /// In id, this message translates to:
  /// **'Laporan tersimpan sebagai data aktual Bibit'**
  String get imporBerhasil;

  /// No description provided for @gagalMembacaPdf.
  ///
  /// In id, this message translates to:
  /// **'Dokumen tidak dapat dibaca. Coba file lain atau masukkan manual.'**
  String get gagalMembacaPdf;

  /// No description provided for @periodeWajib.
  ///
  /// In id, this message translates to:
  /// **'Periode laporan wajib diisi'**
  String get periodeWajib;

  /// No description provided for @belumAdaImpor.
  ///
  /// In id, this message translates to:
  /// **'Belum ada laporan diimpor'**
  String get belumAdaImpor;

  /// No description provided for @hapusCatatanImpor.
  ///
  /// In id, this message translates to:
  /// **'Hapus catatan impor'**
  String get hapusCatatanImpor;

  /// No description provided for @kontribusiBulanIni.
  ///
  /// In id, this message translates to:
  /// **'Kontribusi bulan ini'**
  String get kontribusiBulanIni;

  /// No description provided for @targetDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Target dana darurat'**
  String get targetDanaDarurat;

  /// No description provided for @saldoSaatIni.
  ///
  /// In id, this message translates to:
  /// **'Saldo saat ini'**
  String get saldoSaatIni;

  /// No description provided for @kekurangan.
  ///
  /// In id, this message translates to:
  /// **'Kekurangan'**
  String get kekurangan;

  /// No description provided for @aturTargetDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Atur target dana darurat'**
  String get aturTargetDanaDarurat;

  /// No description provided for @jumlahBulanTarget.
  ///
  /// In id, this message translates to:
  /// **'Jumlah bulan target'**
  String get jumlahBulanTarget;

  /// No description provided for @estimasiTercapai.
  ///
  /// In id, this message translates to:
  /// **'Estimasi tercapai {bulan} bulan lagi'**
  String estimasiTercapai(int bulan);

  /// No description provided for @progresChecklist.
  ///
  /// In id, this message translates to:
  /// **'Progres Checklist'**
  String get progresChecklist;

  /// No description provided for @catatPengeluaran.
  ///
  /// In id, this message translates to:
  /// **'Catat Pengeluaran'**
  String get catatPengeluaran;

  /// No description provided for @realisasiPengeluaran.
  ///
  /// In id, this message translates to:
  /// **'Realisasi Pengeluaran'**
  String get realisasiPengeluaran;

  /// No description provided for @sisaAnggaranDana.
  ///
  /// In id, this message translates to:
  /// **'Sisa Anggaran DANA'**
  String get sisaAnggaranDana;

  /// No description provided for @sumberAnggaran.
  ///
  /// In id, this message translates to:
  /// **'Sumber anggaran'**
  String get sumberAnggaran;

  /// No description provided for @sumberKantongWajib.
  ///
  /// In id, this message translates to:
  /// **'Kantong Pengeluaran Wajib'**
  String get sumberKantongWajib;

  /// No description provided for @sumberKantongLangganan.
  ///
  /// In id, this message translates to:
  /// **'Kantong Langganan Bank Jago'**
  String get sumberKantongLangganan;

  /// No description provided for @sumberAlokasiJago.
  ///
  /// In id, this message translates to:
  /// **'Alokasi Bank Jago'**
  String get sumberAlokasiJago;

  /// No description provided for @sumberAlokasiDana.
  ///
  /// In id, this message translates to:
  /// **'Alokasi DANA'**
  String get sumberAlokasiDana;

  /// No description provided for @tanggal.
  ///
  /// In id, this message translates to:
  /// **'Tanggal'**
  String get tanggal;

  /// No description provided for @catatanOpsional.
  ///
  /// In id, this message translates to:
  /// **'Catatan (opsional)'**
  String get catatanOpsional;

  /// No description provided for @belumAdaRealisasi.
  ///
  /// In id, this message translates to:
  /// **'Belum ada realisasi tercatat'**
  String get belumAdaRealisasi;

  /// No description provided for @kelolaLangganan.
  ///
  /// In id, this message translates to:
  /// **'Kelola Langganan'**
  String get kelolaLangganan;

  /// No description provided for @tambahLangganan.
  ///
  /// In id, this message translates to:
  /// **'Tambah langganan'**
  String get tambahLangganan;

  /// No description provided for @langgananKosong.
  ///
  /// In id, this message translates to:
  /// **'Belum ada langganan'**
  String get langgananKosong;

  /// No description provided for @siklus.
  ///
  /// In id, this message translates to:
  /// **'Siklus'**
  String get siklus;

  /// No description provided for @siklusBulanan.
  ///
  /// In id, this message translates to:
  /// **'Bulanan'**
  String get siklusBulanan;

  /// No description provided for @siklusTahunan.
  ///
  /// In id, this message translates to:
  /// **'Tahunan'**
  String get siklusTahunan;

  /// No description provided for @bulanTagihan.
  ///
  /// In id, this message translates to:
  /// **'Bulan tagihan (1–12)'**
  String get bulanTagihan;

  /// No description provided for @metodeTahunan.
  ///
  /// In id, this message translates to:
  /// **'Metode pendanaan tahunan'**
  String get metodeTahunan;

  /// No description provided for @metodeCadanganBulanan.
  ///
  /// In id, this message translates to:
  /// **'Cadangan bulanan'**
  String get metodeCadanganBulanan;

  /// No description provided for @metodeBayarJatuhTempo.
  ///
  /// In id, this message translates to:
  /// **'Bayar saat jatuh tempo'**
  String get metodeBayarJatuhTempo;

  /// No description provided for @statusAktif.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get statusAktif;

  /// No description provided for @metodeSubJago.
  ///
  /// In id, this message translates to:
  /// **'Sub-alokasi Bank Jago'**
  String get metodeSubJago;

  /// No description provided for @subJagoPersentaseTetap.
  ///
  /// In id, this message translates to:
  /// **'Persentase tetap (10/50/40)'**
  String get subJagoPersentaseTetap;

  /// No description provided for @subJagoBerdasarkanLangganan.
  ///
  /// In id, this message translates to:
  /// **'Berdasarkan langganan aktual'**
  String get subJagoBerdasarkanLangganan;

  /// No description provided for @langgananMelebihiAlokasi.
  ///
  /// In id, this message translates to:
  /// **'Kebutuhan langganan melebihi Alokasi Bank Jago. Ubah sumber anggaran, kurangi langganan, atau ubah persentase.'**
  String get langgananMelebihiAlokasi;

  /// No description provided for @duplikasiKeHitung.
  ///
  /// In id, this message translates to:
  /// **'Duplikasi ke Hitung'**
  String get duplikasiKeHitung;

  /// No description provided for @editDraf.
  ///
  /// In id, this message translates to:
  /// **'Edit draf'**
  String get editDraf;

  /// No description provided for @hapusBulanIni.
  ///
  /// In id, this message translates to:
  /// **'Hapus bulan ini'**
  String get hapusBulanIni;

  /// No description provided for @hapusSemuaData.
  ///
  /// In id, this message translates to:
  /// **'Hapus seluruh data'**
  String get hapusSemuaData;

  /// No description provided for @hapusSemuaDataPesan.
  ///
  /// In id, this message translates to:
  /// **'Seluruh alokasi, riwayat, langganan, dan pengaturan akan dihapus permanen. Tindakan ini tidak dapat dibatalkan.'**
  String get hapusSemuaDataPesan;

  /// No description provided for @dataTerhapus.
  ///
  /// In id, this message translates to:
  /// **'Seluruh data telah dihapus'**
  String get dataTerhapus;

  /// No description provided for @notifTopUpDanaJudul.
  ///
  /// In id, this message translates to:
  /// **'Waktunya top-up DANA'**
  String get notifTopUpDanaJudul;

  /// No description provided for @notifTopUpDanaIsi.
  ///
  /// In id, this message translates to:
  /// **'Top-up {nominal} sesuai jadwal alokasi bulan ini.'**
  String notifTopUpDanaIsi(String nominal);

  /// No description provided for @keamanan.
  ///
  /// In id, this message translates to:
  /// **'Keamanan'**
  String get keamanan;

  /// No description provided for @pinAplikasi.
  ///
  /// In id, this message translates to:
  /// **'PIN aplikasi'**
  String get pinAplikasi;

  /// No description provided for @aturPin.
  ///
  /// In id, this message translates to:
  /// **'Atur PIN (6 digit)'**
  String get aturPin;

  /// No description provided for @masukkanPin.
  ///
  /// In id, this message translates to:
  /// **'Masukkan PIN'**
  String get masukkanPin;

  /// No description provided for @ulangiPin.
  ///
  /// In id, this message translates to:
  /// **'Ulangi PIN'**
  String get ulangiPin;

  /// No description provided for @pinSalah.
  ///
  /// In id, this message translates to:
  /// **'PIN salah'**
  String get pinSalah;

  /// No description provided for @pinTidakSama.
  ///
  /// In id, this message translates to:
  /// **'PIN tidak sama, coba lagi'**
  String get pinTidakSama;

  /// No description provided for @nonaktifkanPin.
  ///
  /// In id, this message translates to:
  /// **'Nonaktifkan PIN'**
  String get nonaktifkanPin;

  /// No description provided for @bukaKunci.
  ///
  /// In id, this message translates to:
  /// **'Buka Kunci'**
  String get bukaKunci;

  /// No description provided for @biometrik.
  ///
  /// In id, this message translates to:
  /// **'Buka dengan biometrik'**
  String get biometrik;

  /// No description provided for @aplikasiTerkunci.
  ///
  /// In id, this message translates to:
  /// **'Finara terkunci'**
  String get aplikasiTerkunci;

  /// No description provided for @filterTahun.
  ///
  /// In id, this message translates to:
  /// **'Filter tahun'**
  String get filterTahun;

  /// No description provided for @semuaTahun.
  ///
  /// In id, this message translates to:
  /// **'Semua tahun'**
  String get semuaTahun;

  /// No description provided for @dibandingBulanLalu.
  ///
  /// In id, this message translates to:
  /// **'Dibanding bulan sebelumnya'**
  String get dibandingBulanLalu;

  /// No description provided for @tidakAdaBulanSebelumnya.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada data bulan sebelumnya'**
  String get tidakAdaBulanSebelumnya;

  /// No description provided for @aiBelumDikonfigurasi.
  ///
  /// In id, this message translates to:
  /// **'Finara AI belum dikonfigurasi'**
  String get aiBelumDikonfigurasi;

  /// No description provided for @aiBelumDikonfigurasiPesan.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan penyedia AI dan API key Anda sendiri untuk mulai bertanya.'**
  String get aiBelumDikonfigurasiPesan;

  /// No description provided for @penyediaDanModel.
  ///
  /// In id, this message translates to:
  /// **'Penyedia dan Model'**
  String get penyediaDanModel;

  /// No description provided for @namaKonfigurasi.
  ///
  /// In id, this message translates to:
  /// **'Nama konfigurasi'**
  String get namaKonfigurasi;

  /// No description provided for @baseUrl.
  ///
  /// In id, this message translates to:
  /// **'Base URL'**
  String get baseUrl;

  /// No description provided for @apiKey.
  ///
  /// In id, this message translates to:
  /// **'API key'**
  String get apiKey;

  /// No description provided for @apiKeyTersimpan.
  ///
  /// In id, this message translates to:
  /// **'API key tersimpan: {samaran}'**
  String apiKeyTersimpan(String samaran);

  /// No description provided for @ambilDaftarModel.
  ///
  /// In id, this message translates to:
  /// **'Ambil Daftar Model'**
  String get ambilDaftarModel;

  /// No description provided for @muatUlangModel.
  ///
  /// In id, this message translates to:
  /// **'Muat Ulang Model'**
  String get muatUlangModel;

  /// No description provided for @modelDitemukan.
  ///
  /// In id, this message translates to:
  /// **'{jumlah} model ditemukan'**
  String modelDitemukan(int jumlah);

  /// No description provided for @belumAdaModel.
  ///
  /// In id, this message translates to:
  /// **'Belum ada model. Ambil daftar model atau tambahkan manual.'**
  String get belumAdaModel;

  /// No description provided for @tesKoneksi.
  ///
  /// In id, this message translates to:
  /// **'Tes Koneksi'**
  String get tesKoneksi;

  /// No description provided for @koneksiBerhasil.
  ///
  /// In id, this message translates to:
  /// **'Koneksi berhasil'**
  String get koneksiBerhasil;

  /// No description provided for @modelDefault.
  ///
  /// In id, this message translates to:
  /// **'Model default'**
  String get modelDefault;

  /// No description provided for @jadikanDefault.
  ///
  /// In id, this message translates to:
  /// **'Jadikan default'**
  String get jadikanDefault;

  /// No description provided for @favorit.
  ///
  /// In id, this message translates to:
  /// **'Favorit'**
  String get favorit;

  /// No description provided for @tambahModelManual.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan Model Manual'**
  String get tambahModelManual;

  /// No description provided for @modelIdLabel.
  ///
  /// In id, this message translates to:
  /// **'Model ID'**
  String get modelIdLabel;

  /// No description provided for @namaTampilan.
  ///
  /// In id, this message translates to:
  /// **'Nama tampilan (opsional)'**
  String get namaTampilan;

  /// No description provided for @cariModel.
  ///
  /// In id, this message translates to:
  /// **'Cari model'**
  String get cariModel;

  /// No description provided for @pilihModel.
  ///
  /// In id, this message translates to:
  /// **'Pilih model'**
  String get pilihModel;

  /// No description provided for @izinDataAi.
  ///
  /// In id, this message translates to:
  /// **'Izin data keuangan'**
  String get izinDataAi;

  /// No description provided for @izinTanpaAkses.
  ///
  /// In id, this message translates to:
  /// **'Tanpa akses data keuangan'**
  String get izinTanpaAkses;

  /// No description provided for @izinBulanAktif.
  ///
  /// In id, this message translates to:
  /// **'Akses bulan aktif'**
  String get izinBulanAktif;

  /// No description provided for @izinTigaBulan.
  ///
  /// In id, this message translates to:
  /// **'Akses tiga bulan terakhir'**
  String get izinTigaBulan;

  /// No description provided for @izinEnamBulan.
  ///
  /// In id, this message translates to:
  /// **'Akses enam bulan terakhir'**
  String get izinEnamBulan;

  /// No description provided for @hapusProvider.
  ///
  /// In id, this message translates to:
  /// **'Hapus penyedia'**
  String get hapusProvider;

  /// No description provided for @hapusProviderPesan.
  ///
  /// In id, this message translates to:
  /// **'Konfigurasi, model, API key, dan seluruh percakapan penyedia ini akan dihapus.'**
  String get hapusProviderPesan;

  /// No description provided for @percakapanBaru.
  ///
  /// In id, this message translates to:
  /// **'Percakapan Baru'**
  String get percakapanBaru;

  /// No description provided for @belumAdaPercakapan.
  ///
  /// In id, this message translates to:
  /// **'Belum ada percakapan'**
  String get belumAdaPercakapan;

  /// No description provided for @ketikPesan.
  ///
  /// In id, this message translates to:
  /// **'Tulis pertanyaan…'**
  String get ketikPesan;

  /// No description provided for @hentikan.
  ///
  /// In id, this message translates to:
  /// **'Hentikan'**
  String get hentikan;

  /// No description provided for @salinJawaban.
  ///
  /// In id, this message translates to:
  /// **'Salin jawaban'**
  String get salinJawaban;

  /// No description provided for @jawabanTersalin.
  ///
  /// In id, this message translates to:
  /// **'Jawaban disalin'**
  String get jawabanTersalin;

  /// No description provided for @hapusPercakapan.
  ///
  /// In id, this message translates to:
  /// **'Hapus percakapan'**
  String get hapusPercakapan;

  /// No description provided for @disclaimerAi.
  ///
  /// In id, this message translates to:
  /// **'Jawaban AI dapat tidak akurat. Periksa kembali informasi penting sebelum mengambil keputusan. Penggunaan API dan biaya mengikuti penyedia AI yang dipilih pengguna.'**
  String get disclaimerAi;

  /// No description provided for @chipAnalisisAlokasi.
  ///
  /// In id, this message translates to:
  /// **'Analisis alokasi bulan ini'**
  String get chipAnalisisAlokasi;

  /// No description provided for @chipUangJajan.
  ///
  /// In id, this message translates to:
  /// **'Apakah uang jajan saya terlalu besar?'**
  String get chipUangJajan;

  /// No description provided for @chipDanaDarurat.
  ///
  /// In id, this message translates to:
  /// **'Bagaimana mempercepat dana darurat?'**
  String get chipDanaDarurat;

  /// No description provided for @chipInvestasi.
  ///
  /// In id, this message translates to:
  /// **'Bagaimana membagi investasi antara Bibit dan Stockbit?'**
  String get chipInvestasi;

  /// No description provided for @tanyakanHasilIniKeAi.
  ///
  /// In id, this message translates to:
  /// **'Tanyakan Hasil Ini ke AI'**
  String get tanyakanHasilIniKeAi;

  /// No description provided for @konteksAkanDikirim.
  ///
  /// In id, this message translates to:
  /// **'Data berikut akan dikirim ke penyedia AI yang Anda konfigurasi. Lanjutkan?'**
  String get konteksAkanDikirim;

  /// No description provided for @kirimDanTanya.
  ///
  /// In id, this message translates to:
  /// **'Kirim dan Tanya'**
  String get kirimDanTanya;

  /// No description provided for @izinDataDiperlukan.
  ///
  /// In id, this message translates to:
  /// **'Penyedia ini belum diberi izin akses data keuangan. Ubah di Pengaturan Finara AI.'**
  String get izinDataDiperlukan;

  /// No description provided for @errApiKeyKosong.
  ///
  /// In id, this message translates to:
  /// **'API key belum diisi'**
  String get errApiKeyKosong;

  /// No description provided for @errApiKeyDitolak.
  ///
  /// In id, this message translates to:
  /// **'API key ditolak penyedia'**
  String get errApiKeyDitolak;

  /// No description provided for @errEndpointSalah.
  ///
  /// In id, this message translates to:
  /// **'Endpoint tidak ditemukan — periksa Base URL'**
  String get errEndpointSalah;

  /// No description provided for @errModelTidakTersedia.
  ///
  /// In id, this message translates to:
  /// **'Model tidak tersedia'**
  String get errModelTidakTersedia;

  /// No description provided for @errTidakAdaInternet.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada koneksi internet'**
  String get errTidakAdaInternet;

  /// No description provided for @errTimeout.
  ///
  /// In id, this message translates to:
  /// **'Waktu tunggu habis'**
  String get errTimeout;

  /// No description provided for @errRateLimit.
  ///
  /// In id, this message translates to:
  /// **'Terlalu banyak permintaan — coba lagi nanti'**
  String get errRateLimit;

  /// No description provided for @errKuotaHabis.
  ///
  /// In id, this message translates to:
  /// **'Kuota penyedia habis'**
  String get errKuotaHabis;

  /// No description provided for @errResponsTidakValid.
  ///
  /// In id, this message translates to:
  /// **'Respons penyedia tidak valid'**
  String get errResponsTidakValid;

  /// No description provided for @errResponsKosong.
  ///
  /// In id, this message translates to:
  /// **'Respons kosong dari penyedia'**
  String get errResponsKosong;

  /// No description provided for @errKonteksTerlaluPanjang.
  ///
  /// In id, this message translates to:
  /// **'Konteks terlalu panjang — kurangi konteks'**
  String get errKonteksTerlaluPanjang;

  /// No description provided for @errStreamingTerputus.
  ///
  /// In id, this message translates to:
  /// **'Streaming terputus'**
  String get errStreamingTerputus;

  /// No description provided for @errParameterTidakDidukung.
  ///
  /// In id, this message translates to:
  /// **'Parameter tidak didukung penyedia'**
  String get errParameterTidakDidukung;

  /// No description provided for @errModelOverload.
  ///
  /// In id, this message translates to:
  /// **'Penyedia sedang sibuk — coba lagi'**
  String get errModelOverload;

  /// No description provided for @errTidakDiketahui.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan pada penyedia AI'**
  String get errTidakDiketahui;

  /// No description provided for @tentang.
  ///
  /// In id, this message translates to:
  /// **'Tentang'**
  String get tentang;

  /// No description provided for @versiAplikasi.
  ///
  /// In id, this message translates to:
  /// **'Versi aplikasi'**
  String get versiAplikasi;

  /// No description provided for @lihatOnboarding.
  ///
  /// In id, this message translates to:
  /// **'Lihat pengenalan aplikasi'**
  String get lihatOnboarding;

  /// No description provided for @disclaimerUtama.
  ///
  /// In id, this message translates to:
  /// **'Finara membantu melakukan simulasi dan perencanaan keuangan. Finara bukan bank, bukan penasihat keuangan, dan tidak menjamin keuntungan investasi. Selalu periksa kembali informasi sebelum mengambil keputusan keuangan.'**
  String get disclaimerUtama;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
