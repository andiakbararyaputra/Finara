// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Finara';

  @override
  String get appTagline => 'Setiap rupiah punya arah.';

  @override
  String get appDescription =>
      'Finara membantu mengatur penghasilan, pengeluaran, tabungan, investasi, dan tujuan keuangan dalam satu aplikasi.';

  @override
  String get navBeranda => 'Beranda';

  @override
  String get navHitung => 'Hitung';

  @override
  String get navFinaraAi => 'Finara AI';

  @override
  String get navProgres => 'Progres';

  @override
  String get navRiwayat => 'Riwayat';

  @override
  String get pengaturan => 'Pengaturan';

  @override
  String get tema => 'Tema';

  @override
  String get temaTerang => 'Terang';

  @override
  String get temaGelap => 'Gelap';

  @override
  String get temaSistem => 'Ikuti sistem';

  @override
  String get belumTersedia => 'Belum tersedia';

  @override
  String get tidakTersedia => 'Tidak tersedia';

  @override
  String get rencana => 'Rencana';

  @override
  String get aktual => 'Aktual';

  @override
  String get estimasi => 'Estimasi';

  @override
  String get anggaran => 'Anggaran';

  @override
  String get hitungAlokasi => 'Hitung Alokasi';

  @override
  String get tanyaFinaraAi => 'Tanya Finara AI';

  @override
  String get berandaKosongJudul => 'Belum ada alokasi bulan ini';

  @override
  String get berandaKosongPesan =>
      'Mulai dengan menghitung alokasi penghasilan bulan ini agar setiap rupiah punya arah.';

  @override
  String get hitungKosongJudul => 'Siap menghitung alokasi';

  @override
  String get hitungKosongPesan =>
      'Masukkan penghasilan dan pengeluaran wajib untuk membagi dana secara otomatis. Fitur ini sedang disiapkan pada fase pengembangan berikutnya.';

  @override
  String get progresKosongJudul => 'Belum ada data progres';

  @override
  String get progresKosongPesan =>
      'Progres dana darurat dan checklist akan tampil setelah alokasi pertama dibuat.';

  @override
  String get riwayatKosongJudul => 'Belum ada riwayat';

  @override
  String get riwayatKosongPesan =>
      'Setiap alokasi yang disimpan akan tercatat di sini beserta revisinya.';

  @override
  String get cobaLagi => 'Coba lagi';

  @override
  String get terjadiKesalahan => 'Terjadi kesalahan';

  @override
  String get onboarding1Judul => 'Atur penghasilan dengan lebih terarah';

  @override
  String get onboarding1Isi =>
      'Finara membantu membagi penghasilan ke kebutuhan, tabungan, investasi, dan uang jajan.';

  @override
  String get onboarding2Judul => 'Bangun dana darurat';

  @override
  String get onboarding2Isi =>
      'Tentukan target dan pantau perkembangan dana darurat setiap bulan.';

  @override
  String get onboarding3Judul => 'Data tetap dalam kendali Anda';

  @override
  String get onboarding3Isi =>
      'Data disimpan secara aman dan tidak terhubung langsung ke rekening bank.';

  @override
  String get lewati => 'Lewati';

  @override
  String get berikutnya => 'Berikutnya';

  @override
  String get mulaiGunakan => 'Mulai Gunakan Finara';

  @override
  String get langkahPendapatan => 'Pendapatan';

  @override
  String get langkahPengeluaran => 'Pengeluaran Wajib';

  @override
  String get langkahPembagian => 'Pembagian';

  @override
  String get penghasilanUtama => 'Penghasilan Utama';

  @override
  String get penghasilanUtamaWajib => 'Penghasilan utama wajib lebih dari nol';

  @override
  String get kasPeganganBrimo => 'Kas Pegangan BRImo';

  @override
  String get penghasilanTambahan => 'Penghasilan Tambahan';

  @override
  String get tambahPenghasilan => 'Tambah penghasilan';

  @override
  String get namaItem => 'Nama';

  @override
  String get nominal => 'Nominal';

  @override
  String get disertakanBulanIni => 'Sertakan pada bulan aktif';

  @override
  String get totalPendapatan => 'Total Pendapatan';

  @override
  String get pengeluaranWajib => 'Pengeluaran Wajib';

  @override
  String get tambahPengeluaran => 'Tambah pengeluaran';

  @override
  String get totalPengeluaranWajib => 'Total Pengeluaran Wajib';

  @override
  String get kanalPembayaran => 'Kanal pembayaran';

  @override
  String get kanalBankJago => 'Bank Jago';

  @override
  String get kanalDana => 'DANA';

  @override
  String get kanalTunai => 'Tunai';

  @override
  String get kanalBankLain => 'Transfer bank lain';

  @override
  String get kanalLainnya => 'Lainnya';

  @override
  String get dasarDanaDarurat => 'Dihitung dalam dasar dana darurat';

  @override
  String get pilihPreset => 'Pilih preset';

  @override
  String get presetStandardHybrid => 'Standard Hybrid';

  @override
  String get presetInvestorFokus => 'Investor Fokus';

  @override
  String get presetPelajar => 'Pelajar/Mahasiswa';

  @override
  String get presetKonservatif => 'Konservatif';

  @override
  String get presetCustom => 'Custom';

  @override
  String get bagianJago => 'Bank Jago';

  @override
  String get bagianInvestasi => 'Total Alokasi Investasi';

  @override
  String get bagianDana => 'DANA';

  @override
  String get bagianBibit => 'Bibit';

  @override
  String get bagianStockbit => 'Stockbit';

  @override
  String totalPersen(String persen) {
    return 'Total: $persen';
  }

  @override
  String get wajibSeratusPersen => 'Total persentase wajib tepat 100%';

  @override
  String get pembulatan => 'Pembulatan';

  @override
  String get pembulatanTanpa => 'Tanpa pembulatan';

  @override
  String get pembulatanSeribu => 'Kelipatan Rp1.000';

  @override
  String get pembulatanLimaRibu => 'Kelipatan Rp5.000';

  @override
  String get pembulatanSepuluhRibu => 'Kelipatan Rp10.000';

  @override
  String get frekuensiTopUpDana => 'Jadwal top-up DANA';

  @override
  String get frekuensiHarian => 'Harian';

  @override
  String get frekuensiMingguan => 'Mingguan';

  @override
  String get frekuensiSekaligus => 'Sekaligus';

  @override
  String get lanjut => 'Lanjut';

  @override
  String get kembali => 'Kembali';

  @override
  String get hitung => 'Hitung';

  @override
  String get hapus => 'Hapus';

  @override
  String get batal => 'Batal';

  @override
  String get simpan => 'Simpan';

  @override
  String get hasilAlokasi => 'Hasil Alokasi';

  @override
  String get danaBersih => 'Dana Bersih';

  @override
  String get selisihBelumDialokasikan => 'Selisih Belum Dialokasikan';

  @override
  String get kartuBrimo => 'BRImo';

  @override
  String get kartuJago => 'Bank Jago';

  @override
  String get kartuInvestasi => 'Investasi';

  @override
  String get kartuDana => 'DANA';

  @override
  String get kasPeganganRencana => 'Kas Pegangan BRImo — Rencana';

  @override
  String get totalTransferAwalJago =>
      'Total Transfer Awal ke Bank Jago — Rencana';

  @override
  String get kantongPengeluaranWajib => 'Kantong Pengeluaran Wajib';

  @override
  String get alokasiJagoDariDanaBersih => 'Alokasi Bank Jago dari Dana Bersih';

  @override
  String get kantongLangganan => 'Langganan';

  @override
  String get kantongDanaDarurat => 'Dana darurat';

  @override
  String get kantongOperasional => 'Dana operasional tambahan';

  @override
  String get totalAlokasiInvestasiRencana =>
      'Total Alokasi Investasi — Rencana';

  @override
  String get alokasiBibitRencana => 'Alokasi Bibit — Rencana';

  @override
  String get alokasiStockbitRencana => 'Alokasi Stockbit — Rencana';

  @override
  String get targetTransferRdn => 'Target transfer ke RDN';

  @override
  String persenDariDanaBersih(String persen) {
    return '$persen dari Dana Bersih';
  }

  @override
  String persenDariTotalPendapatan(String persen) {
    return '$persen dari Total Pendapatan';
  }

  @override
  String persenDariInvestasi(String persen) {
    return '$persen dari Total Alokasi Investasi';
  }

  @override
  String get peringatanRisikoInvestasi =>
      'Investasi mengandung risiko. Nilai dapat naik atau turun.';

  @override
  String get totalAlokasiDanaRencana => 'Total Alokasi DANA — Rencana';

  @override
  String get anggaranHarianDasar => 'Anggaran harian dasar';

  @override
  String get anggaranPerTopUp => 'Anggaran per top-up';

  @override
  String get jadwalTopUp => 'Jadwal top-up';

  @override
  String get salinNominal => 'Salin nominal';

  @override
  String get nominalTersalin => 'Nominal disalin';

  @override
  String get simpanKeRiwayat => 'Simpan ke Riwayat';

  @override
  String get tersimpanKeRiwayat => 'Alokasi tersimpan ke riwayat';

  @override
  String get kategoriKebutuhan => 'Kebutuhan';

  @override
  String get kategoriKasPegangan => 'Kas Pegangan';

  @override
  String get kategoriTabungan => 'Tabungan';

  @override
  String get kategoriInvestasi => 'Investasi';

  @override
  String get kategoriUangJajan => 'Uang Jajan';

  @override
  String get kategoriOperasional => 'Operasional Tambahan';

  @override
  String get statusDraf => 'Draf';

  @override
  String get statusDikonfirmasi => 'Dikonfirmasi';

  @override
  String get statusDikunci => 'Dikunci';

  @override
  String get statusDirevisi => 'Direvisi';

  @override
  String revisiKe(int nomor) {
    return 'Revisi $nomor';
  }

  @override
  String get konfirmasiAlokasi => 'Konfirmasi Alokasi';

  @override
  String get checklistTransfer => 'Checklist Transfer';

  @override
  String checklistSelesaiDari(int selesai, int total) {
    return '$selesai dari $total selesai';
  }

  @override
  String get hapusRiwayatJudul => 'Hapus riwayat bulan ini?';

  @override
  String get hapusRiwayatPesan =>
      'Seluruh revisi dan checklist bulan ini akan dihapus permanen.';

  @override
  String get ckSisakanKasPegangan => 'Sisakan Kas Pegangan BRImo';

  @override
  String get ckTransferDanaMasukJago =>
      'Transfer Total Dana Masuk ke Bank Jago dari BRImo';

  @override
  String get ckPisahkanKantongWajib =>
      'Pisahkan Total Pengeluaran Wajib ke Kantong Pengeluaran Wajib';

  @override
  String get ckPisahkanAlokasiJago =>
      'Pisahkan Alokasi Bank Jago ke kantong internal';

  @override
  String get ckIsiKantongLangganan =>
      'Masukkan dana langganan ke Kantong Langganan';

  @override
  String get ckIsiKantongDanaDarurat =>
      'Masukkan kontribusi dana darurat ke Kantong Dana Darurat';

  @override
  String get ckIsiKantongOperasional =>
      'Masukkan dana operasional ke Kantong Operasional';

  @override
  String get ckTopUpBibit => 'Top-up investasi ke Bibit sesuai Alokasi Bibit';

  @override
  String get ckTransferRdnStockbit => 'Transfer kontribusi Stockbit ke RDN';

  @override
  String get ckVerifikasiRdnCatatTerpisah =>
      'Verifikasi transfer RDN dan catat pembelian saham terpisah';

  @override
  String get ckTopUpDana => 'Top-up Alokasi DANA sesuai jadwal';

  @override
  String ckPindahkanWajibKeDana(String nama) {
    return 'Pindahkan $nama dari Kantong Pengeluaran Wajib ke DANA';
  }

  @override
  String ckTarikWajibTunai(String nama) {
    return 'Tarik tunai $nama dari Kantong Pengeluaran Wajib';
  }

  @override
  String ckPindahkanWajibKeBankLain(String nama) {
    return 'Pindahkan $nama dari Kantong Pengeluaran Wajib ke rekening tujuan';
  }

  @override
  String get ckPeriksaSatuSumberAnggaran =>
      'Pastikan tidak ada item dibiayai dua sumber anggaran';

  @override
  String get ckPeriksaPemindahanBukanPengeluaran =>
      'Pastikan pemindahan antarplatform tidak dicatat sebagai pengeluaran';

  @override
  String get progresDanaDarurat => 'Progres Dana Darurat';

  @override
  String get kontribusiBulanIni => 'Kontribusi bulan ini';

  @override
  String get targetDanaDarurat => 'Target dana darurat';

  @override
  String get saldoSaatIni => 'Saldo saat ini';

  @override
  String get kekurangan => 'Kekurangan';

  @override
  String get aturTargetDanaDarurat => 'Atur target dana darurat';

  @override
  String get jumlahBulanTarget => 'Jumlah bulan target';

  @override
  String estimasiTercapai(int bulan) {
    return 'Estimasi tercapai $bulan bulan lagi';
  }

  @override
  String get progresChecklist => 'Progres Checklist';

  @override
  String get catatPengeluaran => 'Catat Pengeluaran';

  @override
  String get realisasiPengeluaran => 'Realisasi Pengeluaran';

  @override
  String get sisaAnggaranDana => 'Sisa Anggaran DANA';

  @override
  String get sumberAnggaran => 'Sumber anggaran';

  @override
  String get sumberKantongWajib => 'Kantong Pengeluaran Wajib';

  @override
  String get sumberKantongLangganan => 'Kantong Langganan Bank Jago';

  @override
  String get sumberAlokasiJago => 'Alokasi Bank Jago';

  @override
  String get sumberAlokasiDana => 'Alokasi DANA';

  @override
  String get tanggal => 'Tanggal';

  @override
  String get catatanOpsional => 'Catatan (opsional)';

  @override
  String get belumAdaRealisasi => 'Belum ada realisasi tercatat';

  @override
  String get kelolaLangganan => 'Kelola Langganan';

  @override
  String get tambahLangganan => 'Tambah langganan';

  @override
  String get langgananKosong => 'Belum ada langganan';

  @override
  String get siklus => 'Siklus';

  @override
  String get siklusBulanan => 'Bulanan';

  @override
  String get siklusTahunan => 'Tahunan';

  @override
  String get bulanTagihan => 'Bulan tagihan (1–12)';

  @override
  String get metodeTahunan => 'Metode pendanaan tahunan';

  @override
  String get metodeCadanganBulanan => 'Cadangan bulanan';

  @override
  String get metodeBayarJatuhTempo => 'Bayar saat jatuh tempo';

  @override
  String get statusAktif => 'Aktif';

  @override
  String get metodeSubJago => 'Sub-alokasi Bank Jago';

  @override
  String get subJagoPersentaseTetap => 'Persentase tetap (10/50/40)';

  @override
  String get subJagoBerdasarkanLangganan => 'Berdasarkan langganan aktual';

  @override
  String get langgananMelebihiAlokasi =>
      'Kebutuhan langganan melebihi Alokasi Bank Jago. Ubah sumber anggaran, kurangi langganan, atau ubah persentase.';

  @override
  String get duplikasiKeHitung => 'Duplikasi ke Hitung';

  @override
  String get editDraf => 'Edit draf';

  @override
  String get hapusBulanIni => 'Hapus bulan ini';

  @override
  String get hapusSemuaData => 'Hapus seluruh data';

  @override
  String get hapusSemuaDataPesan =>
      'Seluruh alokasi, riwayat, langganan, dan pengaturan akan dihapus permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get dataTerhapus => 'Seluruh data telah dihapus';

  @override
  String get notifTopUpDanaJudul => 'Waktunya top-up DANA';

  @override
  String notifTopUpDanaIsi(String nominal) {
    return 'Top-up $nominal sesuai jadwal alokasi bulan ini.';
  }

  @override
  String get keamanan => 'Keamanan';

  @override
  String get pinAplikasi => 'PIN aplikasi';

  @override
  String get aturPin => 'Atur PIN (6 digit)';

  @override
  String get masukkanPin => 'Masukkan PIN';

  @override
  String get ulangiPin => 'Ulangi PIN';

  @override
  String get pinSalah => 'PIN salah';

  @override
  String get pinTidakSama => 'PIN tidak sama, coba lagi';

  @override
  String get nonaktifkanPin => 'Nonaktifkan PIN';

  @override
  String get bukaKunci => 'Buka Kunci';

  @override
  String get biometrik => 'Buka dengan biometrik';

  @override
  String get aplikasiTerkunci => 'Finara terkunci';

  @override
  String get filterTahun => 'Filter tahun';

  @override
  String get semuaTahun => 'Semua tahun';

  @override
  String get dibandingBulanLalu => 'Dibanding bulan sebelumnya';

  @override
  String get tidakAdaBulanSebelumnya => 'Tidak ada data bulan sebelumnya';

  @override
  String get tentang => 'Tentang';

  @override
  String get versiAplikasi => 'Versi aplikasi';

  @override
  String get lihatOnboarding => 'Lihat pengenalan aplikasi';

  @override
  String get disclaimerUtama =>
      'Finara membantu melakukan simulasi dan perencanaan keuangan. Finara bukan bank, bukan penasihat keuangan, dan tidak menjamin keuntungan investasi. Selalu periksa kembali informasi sebelum mengambil keputusan keuangan.';
}
