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
