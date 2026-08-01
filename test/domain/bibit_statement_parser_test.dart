import 'package:finara/domain/services/bibit_statement_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalisasiAngka (§68)', () {
    test('format Rupiah dan ribuan', () {
      expect(normalisasiAngka('Rp1.000.000'), 1000000);
      expect(normalisasiAngka('Rp 1.000.000'), 1000000);
      expect(normalisasiAngka('1,000,000'), 1000000);
      expect(normalisasiAngka('1.000.000'), 1000000);
    });

    test('desimal 2 digit dibuang', () {
      expect(normalisasiAngka('Rp1.234.567,89'), 1234567);
      expect(normalisasiAngka('1,234,567.89'), 1234567);
    });

    test('negatif: kurung dan minus', () {
      expect(normalisasiAngka('(123.456)'), -123456);
      expect(normalisasiAngka('-123.456'), -123456);
    });

    test('tanpa digit → null, bukan 0', () {
      expect(normalisasiAngka(''), isNull);
      expect(normalisasiAngka('Rp'), isNull);
    });
  });

  group('deteksiPeriode (§65)', () {
    test('nama bulan Indonesia + tahun', () {
      expect(deteksiPeriode('Laporan Periode Juli 2026'),
          (tahun: 2026, bulan: 7));
      expect(deteksiPeriode('per 31 Agustus 2025'),
          (tahun: 2025, bulan: 8));
    });

    test('format tanggal dd/mm/yyyy memakai tanggal akhir', () {
      expect(deteksiPeriode('Periode: 01/07/2026 - 31/07/2026'),
          (tahun: 2026, bulan: 7));
    });

    test('tidak ditemukan → null', () {
      expect(deteksiPeriode('tanpa periode di sini'), isNull);
    });
  });

  group('BibitStatementParser (§66–§67)', () {
    const parser = BibitStatementParser();
    const contoh = '''
Bibit — Statement of Account
Periode: 01/07/2026 - 31/07/2026

Ringkasan Portofolio
Total Nilai Investasi Rp12.345.678
Total Modal Investasi Rp10.000.000
Keuntungan Rp2.345.678

Transaksi
Total Pembelian Rp1.500.000
Total Penjualan Rp250.000
''';

    test('mengekstrak seluruh nilai dgn confidence tinggi', () {
      final hasil = parser.parse(contoh);
      expect(hasil.dikenaliSebagaiBibit, isTrue);
      expect((hasil.tahun, hasil.bulan), (2026, 7));
      expect(hasil.nilaiPortofolio.nilai, 12345678);
      expect(hasil.modalInvestasi.nilai, 10000000);
      expect(hasil.totalPembelian.nilai, 1500000);
      expect(hasil.totalPenjualan.nilai, 250000);
      expect(hasil.nilaiPortofolio.confidence, ParseConfidence.tinggi);
    });

    test('label tidak ada → null + confidence rendah (§66: jangan mengarang)',
        () {
      final hasil = parser.parse('Bibit Statement\nJuli 2026\nhanya teks');
      expect(hasil.nilaiPortofolio.nilai, isNull);
      expect(hasil.nilaiPortofolio.confidence, ParseConfidence.rendah);
      expect(hasil.totalPembelian.nilai, isNull);
    });

    test('dokumen bukan Bibit → classifier tidak mengenali (§67)', () {
      final hasil = parser.parse('Rekening Koran Bank Lain 2026');
      expect(hasil.dikenaliSebagaiBibit, isFalse);
    });
  });

  group('Fingerprint (§73)', () {
    test('byte sama → hash sama; beda → hash beda', () {
      final a = fingerprintDokumen([1, 2, 3]);
      expect(a, fingerprintDokumen([1, 2, 3]));
      expect(a, isNot(fingerprintDokumen([1, 2, 4])));
    });

    test('kunci duplikat menggabungkan jenis + hash + periode', () {
      final kunci = kunciDuplikat(
          fileHash: 'abc', jenis: 'statementBibit', tahun: 2026, bulan: 7);
      expect(kunci, 'statementBibit|abc|2026|7');
      expect(
        kunciDuplikat(fileHash: 'abc', jenis: 'statementBibit'),
        'statementBibit|abc|-|-',
      );
    });
  });
}
