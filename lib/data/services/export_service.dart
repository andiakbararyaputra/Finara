/// Ekspor riwayat (§50): CSV seluruh bulan dan PDF satu revisi.
/// Tidak pernah menyertakan kredensial. Branding Finara.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/money.dart';
import '../db/app_database.dart';

class ExportService {
  const ExportService();

  /// CSV riwayat: satu baris per bulan (revisi aktif).
  String buatCsv(List<(MonthlyAllocation, MonthlyAllocationRevision)> data) {
    final buffer = StringBuffer(
      'tahun;bulan;revisi;status;totalPendapatan;kasPeganganBrimo;'
      'totalPengeluaranWajib;danaBersih;alokasiJago;totalAlokasiInvestasi;'
      'alokasiBibit;alokasiStockbit;alokasiDana;totalDanaMasukJago\n',
    );
    for (final (bulan, r) in data) {
      buffer.writeln(
        '${bulan.tahun};${bulan.bulan};${r.nomorRevisi};${r.status.name};'
        '${r.totalPendapatan};${r.kasPeganganBrimo};'
        '${r.totalPengeluaranWajib};${r.danaBersih};${r.alokasiJago};'
        '${r.totalAlokasiInvestasi};${r.alokasiBibit};${r.alokasiStockbit};'
        '${r.alokasiDana};${r.totalDanaMasukJago}',
      );
    }
    return buffer.toString();
  }

  /// PDF ringkasan satu revisi (§50), branding Finara.
  Future<Uint8List> buatPdf({
    required String judulBulan,
    required MonthlyAllocationRevision revisi,
  }) async {
    final doc = pw.Document();
    pw.Widget baris(String label, int nominal) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(label, style: const pw.TextStyle(fontSize: 11)),
            pw.Text(formatRupiah(nominal),
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold)),
          ],
        );

    doc.addPage(pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Finara',
              style: pw.TextStyle(
                  fontSize: 22, fontWeight: pw.FontWeight.bold)),
          pw.Text('Setiap rupiah punya arah.',
              style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 12),
          pw.Text(
              'Hasil Alokasi $judulBulan — Revisi ${revisi.nomorRevisi} (Rencana)',
              style: const pw.TextStyle(fontSize: 13)),
          pw.Divider(),
          baris('Total Pendapatan', revisi.totalPendapatan),
          baris('Kas Pegangan BRImo', revisi.kasPeganganBrimo),
          baris('Total Pengeluaran Wajib', revisi.totalPengeluaranWajib),
          baris('Dana Bersih', revisi.danaBersih),
          baris('Total Dana Masuk ke Bank Jago', revisi.totalDanaMasukJago),
          baris('Alokasi Bank Jago dari Dana Bersih', revisi.alokasiJago),
          baris('Total Alokasi Investasi', revisi.totalAlokasiInvestasi),
          baris('  Alokasi Bibit', revisi.alokasiBibit),
          baris('  Alokasi Stockbit', revisi.alokasiStockbit),
          baris('Alokasi DANA', revisi.alokasiDana),
          pw.SizedBox(height: 16),
          pw.Text(
            'Seluruh nilai adalah rencana. Finara bukan bank, bukan penasihat '
            'keuangan, dan tidak menjamin keuntungan investasi.',
            style: const pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
    ));
    return doc.save();
  }

  /// Tulis berkas ke direktori temp untuk dibagikan; kembalikan path-nya.
  Future<String> simpanSementara(String namaFile, List<int> bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path, namaFile));
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}
