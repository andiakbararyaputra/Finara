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
