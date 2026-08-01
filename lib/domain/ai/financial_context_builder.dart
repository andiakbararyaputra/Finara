/// Membangun konteks keuangan terstruktur utk Finara AI (§43–§44).
/// Hanya nilai RENCANA dari revisi yang dipilih; data dikirim setelah
/// persetujuan pengguna dan melewati DataSanitizer.
library;

import '../../core/basis_points.dart';
import '../../core/money.dart';
import 'data_sanitizer.dart';

class FinancialContextBuilder {
  const FinancialContextBuilder({this.sanitizer = const DataSanitizer()});

  final DataSanitizer sanitizer;

  /// System prompt dasar Finara AI (§46).
  static const systemPrompt = '''
Anda adalah Finara AI, asisten keuangan di dalam aplikasi Finara. Gunakan Bahasa Indonesia yang jelas, sederhana, objektif, dan mudah dipahami.

Bantu pengguna memahami penghasilan, pengeluaran, dana darurat, tabungan, investasi, langganan, dan uang jajan.

Jangan menjanjikan keuntungan investasi. Jangan menyatakan investasi pasti naik atau bebas risiko. Jangan meminta PIN, OTP, password, CVV, API key, nomor kartu lengkap, atau kredensial perbankan.

Ketika memberikan rekomendasi, jelaskan dasar perhitungan, asumsi, risiko, dan alternatifnya. Prioritaskan kebutuhan wajib dan dana darurat sebelum menyarankan peningkatan investasi.

Gunakan format Rupiah Indonesia. Jangan menyajikan asumsi sebagai fakta. Jika data tidak cukup, jelaskan data yang belum tersedia.

Jawaban bersifat edukasi dan informasi, bukan nasihat keuangan profesional atau jaminan hasil.''';

  /// Konteks alokasi bulan (§43): seluruh nilai adalah rencana.
  String bangunKonteksAlokasi({
    required int tahun,
    required int bulan,
    required int totalPendapatan,
    required int kasPeganganBrimo,
    required int totalPengeluaranWajib,
    required int totalDanaMasukJago,
    required int danaBersih,
    required int alokasiJago,
    required int totalAlokasiInvestasi,
    required int alokasiBibit,
    required int alokasiStockbit,
    required int alokasiDana,
    required int subJagoLangganan,
    required int subJagoDanaDarurat,
    required int subJagoOperasional,
    String? namaPreset,
  }) {
    String persen(int nominal, int basis) {
      final bp = basis == 0 ? null : (nominal * totalBasisPoints) ~/ basis;
      return bp == null ? '-' : formatBasisPoints(bp);
    }

    final teks = '''
Data rencana alokasi bulan $bulan/$tahun (seluruh nilai adalah RENCANA, bukan realisasi):
- Total Pendapatan: ${formatRupiah(totalPendapatan)}
- Kas Pegangan BRImo: ${formatRupiah(kasPeganganBrimo)}
- Total Pengeluaran Wajib (Kantong Pengeluaran Wajib Bank Jago): ${formatRupiah(totalPengeluaranWajib)}
- Dana Bersih: ${formatRupiah(danaBersih)}
- Preset: ${namaPreset ?? 'Custom'}
- Total Dana Masuk ke Bank Jago: ${formatRupiah(totalDanaMasukJago)}
- Alokasi Bank Jago dari Dana Bersih: ${formatRupiah(alokasiJago)} (${persen(alokasiJago, danaBersih)} dari Dana Bersih)
  - Kantong Langganan: ${formatRupiah(subJagoLangganan)}
  - Kantong Dana Darurat: ${formatRupiah(subJagoDanaDarurat)}
  - Kantong Operasional: ${formatRupiah(subJagoOperasional)}
- Total Alokasi Investasi: ${formatRupiah(totalAlokasiInvestasi)} (${persen(totalAlokasiInvestasi, danaBersih)} dari Dana Bersih)
  - Alokasi Bibit: ${formatRupiah(alokasiBibit)} (${persen(alokasiBibit, totalAlokasiInvestasi)} dari Total Alokasi Investasi)
  - Alokasi Stockbit (target transfer ke RDN): ${formatRupiah(alokasiStockbit)} (${persen(alokasiStockbit, totalAlokasiInvestasi)} dari Total Alokasi Investasi)
- Alokasi DANA (uang jajan): ${formatRupiah(alokasiDana)} (${persen(alokasiDana, danaBersih)} dari Dana Bersih)''';
    return sanitizer.bersihkan(teks);
  }
}
