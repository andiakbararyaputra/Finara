/// Ekspor riwayat (§50): CSV seluruh bulan, PDF & gambar satu revisi.
/// Tidak pernah menyertakan kredensial. Branding Finara.
library;

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
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

  /// Gambar PNG ringkasan satu revisi (§50) — dirender via Canvas,
  /// branding Finara, tanpa kredensial.
  Future<Uint8List> buatGambar({
    required String judulBulan,
    required MonthlyAllocationRevision revisi,
  }) async {
    const lebar = 900.0;
    const tepi = 48.0;
    const emerald = ui.Color(0xFF059669);
    const gelap = ui.Color(0xFF1F2937);
    const abu = ui.Color(0xFF6B7280);

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    double y = tepi;
    TextPainter teks(String isi,
        {double ukuran = 22,
        ui.Color warna = gelap,
        FontWeight tebal = FontWeight.w400}) {
      return TextPainter(
        text: TextSpan(
            text: isi,
            style: TextStyle(
                fontSize: ukuran, color: warna, fontWeight: tebal)),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: lebar - tepi * 2);
    }

    final baris = <(String, int, bool)>[
      ('Total Pendapatan', revisi.totalPendapatan, false),
      ('Kas Pegangan BRImo', revisi.kasPeganganBrimo, false),
      ('Total Pengeluaran Wajib', revisi.totalPengeluaranWajib, false),
      ('Dana Bersih', revisi.danaBersih, true),
      ('Total Dana Masuk ke Bank Jago', revisi.totalDanaMasukJago, false),
      ('Total Alokasi Investasi', revisi.totalAlokasiInvestasi, false),
      ('   Alokasi Bibit', revisi.alokasiBibit, false),
      ('   Alokasi Stockbit', revisi.alokasiStockbit, false),
      ('Alokasi DANA', revisi.alokasiDana, false),
    ];
    final tinggi =
        tepi * 2 + 150 + baris.length * 44 + 90; // header + baris + footer

    canvas.drawRect(ui.Rect.fromLTWH(0, 0, lebar, tinggi),
        ui.Paint()..color = const ui.Color(0xFFFFFFFF));
    canvas.drawRect(const ui.Rect.fromLTWH(0, 0, lebar, 12),
        ui.Paint()..color = emerald);

    final judul = teks('Finara',
        ukuran: 40, warna: emerald, tebal: FontWeight.w800);
    judul.paint(canvas, ui.Offset(tepi, y));
    y += judul.height + 4;
    final tagline = teks('Setiap rupiah punya arah.', ukuran: 16, warna: abu);
    tagline.paint(canvas, ui.Offset(tepi, y));
    y += tagline.height + 24;
    final sub = teks(
        'Hasil Alokasi $judulBulan — Revisi ${revisi.nomorRevisi} (Rencana)',
        ukuran: 20,
        tebal: FontWeight.w600);
    sub.paint(canvas, ui.Offset(tepi, y));
    y += sub.height + 16;
    canvas.drawRect(ui.Rect.fromLTWH(tepi, y, lebar - tepi * 2, 2),
        ui.Paint()..color = const ui.Color(0xFFE5E7EB));
    y += 18;

    for (final (label, nominal, tebal) in baris) {
      final kiri = teks(label,
          ukuran: 19,
          warna: tebal ? gelap : abu,
          tebal: tebal ? FontWeight.w700 : FontWeight.w400);
      final kanan = teks(formatRupiah(nominal),
          ukuran: 19,
          tebal: tebal ? FontWeight.w800 : FontWeight.w600);
      kiri.paint(canvas, ui.Offset(tepi, y));
      kanan.paint(
          canvas, ui.Offset(lebar - tepi - kanan.width, y));
      y += 44;
    }

    y += 12;
    final footer = teks(
        'Seluruh nilai adalah rencana. Finara bukan bank, bukan penasihat '
        'keuangan, dan tidak menjamin keuntungan investasi.',
        ukuran: 13,
        warna: abu);
    footer.paint(canvas, ui.Offset(tepi, y));

    final gambar = await recorder
        .endRecording()
        .toImage(lebar.toInt(), tinggi.toInt());
    final data = await gambar.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
