/// Parser Statement of Account Bibit (§66–§68, MVP §84). Pure Dart —
/// bekerja pada lapisan teks PDF yang sudah diekstraksi. Nilai yang tidak
/// ditemukan = null; jangan mengarang angka (§66).
library;

import 'package:crypto/crypto.dart';

/// Keyakinan hasil ekstraksi (§71) — tanpa angka persen karena parser
/// belum terkalibrasi.
enum ParseConfidence { tinggi, rendah }

class BibitParseField {
  const BibitParseField(this.nilai, this.confidence);

  final int? nilai;
  final ParseConfidence confidence;
}

class BibitParseResult {
  const BibitParseResult({
    required this.dikenaliSebagaiBibit,
    this.tahun,
    this.bulan,
    required this.nilaiPortofolio,
    required this.modalInvestasi,
    required this.totalPembelian,
    required this.totalPenjualan,
  });

  /// Classifier §67: keyakinan rendah → pengguna memilih jenis manual.
  final bool dikenaliSebagaiBibit;
  final int? tahun;
  final int? bulan;
  final BibitParseField nilaiPortofolio;
  final BibitParseField modalInvestasi;
  final BibitParseField totalPembelian;
  final BibitParseField totalPenjualan;
}

/// Normalisasi angka Rupiah (§68): Rp1.000.000, Rp 1.000.000, 1,000,000,
/// desimal ",xx" dibuang, tanda kurung/minus = negatif.
int? normalisasiAngka(String mentah) {
  var teks = mentah.trim();
  if (teks.isEmpty) return null;
  var negatif = false;
  if (teks.startsWith('(') && teks.endsWith(')')) {
    negatif = true;
    teks = teks.substring(1, teks.length - 1);
  }
  if (teks.startsWith('-')) {
    negatif = true;
    teks = teks.substring(1);
  }
  teks = teks.replaceFirst(RegExp(r'Rp\s*', caseSensitive: false), '');
  // Buang bagian desimal ",dd" atau ".dd" di ujung (2 digit).
  teks = teks.replaceFirst(RegExp(r'[.,]\d{1,2}$'), '');
  final digits = teks.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return null;
  final nilai = int.parse(digits);
  return negatif ? -nilai : nilai;
}

const _namaBulan = {
  'januari': 1, 'january': 1, 'jan': 1,
  'februari': 2, 'february': 2, 'feb': 2,
  'maret': 3, 'march': 3, 'mar': 3,
  'april': 4, 'apr': 4,
  'mei': 5, 'may': 5,
  'juni': 6, 'june': 6, 'jun': 6,
  'juli': 7, 'july': 7, 'jul': 7,
  'agustus': 8, 'august': 8, 'aug': 8, 'agu': 8,
  'september': 9, 'sep': 9,
  'oktober': 10, 'october': 10, 'okt': 10, 'oct': 10,
  'november': 11, 'nov': 11,
  'desember': 12, 'december': 12, 'des': 12, 'dec': 12,
};

/// Deteksi periode laporan (§65 langkah 6): nama bulan Indonesia/Inggris
/// + tahun, atau format dd/mm/yyyy (dipakai tanggal akhir).
({int tahun, int bulan})? deteksiPeriode(String teks) {
  final rendah = teks.toLowerCase();
  // Format "31/07/2026" — ambil kemunculan terakhir (tanggal akhir periode).
  final tanggal = RegExp(r'\b\d{1,2}/(\d{1,2})/(\d{4})\b')
      .allMatches(rendah)
      .toList();
  if (tanggal.isNotEmpty) {
    final akhir = tanggal.last;
    final bulan = int.parse(akhir.group(1)!);
    if (bulan >= 1 && bulan <= 12) {
      return (tahun: int.parse(akhir.group(2)!), bulan: bulan);
    }
  }
  // Format "Juli 2026" / "31 Jul 2026".
  for (final entri in _namaBulan.entries) {
    final m = RegExp('\\b${entri.key}\\b\\s+(\\d{4})').firstMatch(rendah);
    if (m != null) {
      return (tahun: int.parse(m.group(1)!), bulan: entri.value);
    }
  }
  return null;
}

class BibitStatementParser {
  const BibitStatementParser();

  static const _labelPortofolio = [
    'total nilai investasi',
    'nilai portofolio',
    'total portofolio',
    'portfolio value',
  ];
  static const _labelModal = [
    'total modal investasi',
    'total modal',
    'modal investasi',
    'invested capital',
    'total investment',
  ];
  static const _labelPembelian = [
    'total pembelian',
    'total purchase',
    'total buy',
  ];
  static const _labelPenjualan = [
    'total penjualan',
    'total pencairan',
    'total sell',
    'total redemption',
  ];

  BibitParseResult parse(String teks) {
    final rendah = teks.toLowerCase();
    final dikenal = rendah.contains('bibit') &&
        (rendah.contains('statement') || rendah.contains('laporan'));
    final periode = deteksiPeriode(teks);

    return BibitParseResult(
      dikenaliSebagaiBibit: dikenal,
      tahun: periode?.tahun,
      bulan: periode?.bulan,
      nilaiPortofolio: _cariNilai(rendah, _labelPortofolio),
      modalInvestasi: _cariNilai(rendah, _labelModal),
      totalPembelian: _cariNilai(rendah, _labelPembelian),
      totalPenjualan: _cariNilai(rendah, _labelPenjualan),
    );
  }

  /// Cari angka pertama setelah salah satu label (baris sama atau berikutnya).
  BibitParseField _cariNilai(String teksRendah, List<String> labels) {
    for (final label in labels) {
      final posisi = teksRendah.indexOf(label);
      if (posisi < 0) continue;
      final setelah = teksRendah.substring(
          posisi + label.length,
          (posisi + label.length + 80).clamp(0, teksRendah.length));
      final m = RegExp(r'\(?-?\s*(rp\s*)?[\d.,]{4,}\)?').firstMatch(setelah);
      if (m == null) continue;
      final nilai = normalisasiAngka(m.group(0)!);
      if (nilai != null) {
        return BibitParseField(nilai, ParseConfidence.tinggi);
      }
    }
    return const BibitParseField(null, ParseConfidence.rendah);
  }
}

/// Fingerprint dokumen anti-duplikat (§73): hash isi berkas.
String fingerprintDokumen(List<int> bytes) =>
    sha256.convert(bytes).toString();

/// Kunci duplikat gabungan §73: hash + jenis + periode.
String kunciDuplikat({
  required String fileHash,
  required String jenis,
  int? tahun,
  int? bulan,
}) =>
    '$jenis|$fileHash|${tahun ?? '-'}|${bulan ?? '-'}';

/// Sanitasi ringkas utk pesan — jangan sertakan isi laporan (§78).
String ringkasNamaFile(String nama) =>
    nama.length <= 40 ? nama : '${nama.substring(0, 37)}…';
