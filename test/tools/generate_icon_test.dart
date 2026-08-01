// Generator ikon peluncur: jalankan manual dgn
//   flutter test test/tools/generate_icon_test.dart
// Merender ulang ikon referensi (dompet + uang + koin) dengan simbol "Rp",
// lalu menulis PNG ke android/app/src/main/res/mipmap-*.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

const _slate = Color(0xFF5D6D7E);
const _slateDash = Color(0xFF95A5A6);
const _hijau = Color(0xFF1ABC9C);
const _emas = Color(0xFFF5A623);

class _IkonFinaraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 512; // desain pada grid 512

    // Uang kertas hijau (dua lembar miring) di belakang dompet.
    final uang = Paint()
      ..color = _hijau
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22 * s
      ..strokeJoin = StrokeJoin.round;
    canvas.save();
    canvas.translate(300 * s, 130 * s);
    canvas.rotate(-0.35);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(-90 * s, -45 * s, 180 * s, 110 * s),
            Radius.circular(10 * s)),
        uang);
    canvas.restore();
    canvas.save();
    canvas.translate(360 * s, 165 * s);
    canvas.rotate(-0.15);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(-80 * s, -40 * s, 160 * s, 100 * s),
            Radius.circular(10 * s)),
        uang);
    canvas.restore();

    // Badan dompet.
    final dompet = Paint()
      ..color = _slate
      ..style = PaintingStyle.stroke
      ..strokeWidth = 26 * s
      ..strokeJoin = StrokeJoin.round;
    final badan = RRect.fromRectAndRadius(
        Rect.fromLTWH(90 * s, 175 * s, 340 * s, 250 * s),
        Radius.circular(36 * s));
    // Tutupi bagian bawah uang dgn isi putih dompet agar tampak di belakang.
    canvas.drawRRect(badan, Paint()..color = Colors.white);
    canvas.drawRRect(badan, dompet);

    // Border dash kotak kecil di dalam badan.
    final dash = Paint()..color = _slateDash;
    void kotak(double x, double y) => canvas.drawRect(
        Rect.fromLTWH(x * s, y * s, 14 * s, 14 * s), dash);
    for (var x = 140.0; x <= 380.0; x += 40) {
      kotak(x, 215);
      kotak(x, 372);
    }
    for (var y = 255.0; y <= 340.0; y += 40) {
      kotak(140, y);
      kotak(380, y);
    }

    // Kantong/gesper kanan.
    final gesper = RRect.fromRectAndCorners(
      Rect.fromLTWH(330 * s, 262 * s, 122 * s, 78 * s),
      topLeft: Radius.circular(39 * s),
      bottomLeft: Radius.circular(39 * s),
    );
    canvas.drawRRect(gesper, Paint()..color = Colors.white);
    canvas.drawRRect(gesper, dompet);
    canvas.drawRect(
        Rect.fromLTWH(372 * s, 293 * s, 16 * s, 16 * s), dash);

    // Koin emas dengan "Rp".
    final pusatKoin = Offset(150 * s, 145 * s);
    canvas.drawCircle(pusatKoin, 92 * s, Paint()..color = Colors.white);
    canvas.drawCircle(
        pusatKoin,
        92 * s,
        Paint()
          ..color = _emas
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20 * s);
    final teks = TextPainter(
      text: TextSpan(
        text: 'Rp',
        style: TextStyle(
          color: _emas,
          fontSize: 88 * s,
          fontWeight: FontWeight.w700,
          fontFamily: 'InterIcon',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    teks.paint(
        canvas,
        pusatKoin -
            Offset(teks.width / 2, teks.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Future<void> main() async {
  testWidgets('generate ikon peluncur', (tester) async {
    const ukuranMaster = 1024.0;
    final kunci = GlobalKey();

    tester.view.physicalSize = const Size(1024, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    // Font asli agar "Rp" tidak dirender sbg balok Ahem.
    await tester.runAsync(() async {
      final bytes =
          File('assets/fonts/Inter-Bold.ttf').readAsBytesSync();
      final loader = FontLoader('InterIcon')
        ..addFont(Future.value(ByteData.view(bytes.buffer)));
      await loader.load();
    });

    await tester.pumpWidget(
      Center(
        child: RepaintBoundary(
          key: kunci,
          child: SizedBox(
            width: ukuranMaster,
            height: ukuranMaster,
            child: CustomPaint(painter: _IkonFinaraPainter()),
          ),
        ),
      ),
    );

    await tester.runAsync(() async {
      final boundary = kunci.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      final gambar = await boundary.toImage();
      final byteData =
          await gambar.toByteData(format: ui.ImageByteFormat.png);
      final master = img.decodePng(byteData!.buffer.asUint8List())!;

      const resDir = 'android/app/src/main/res';
      final ukuranMipmap = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192,
      };
      for (final entri in ukuranMipmap.entries) {
        final kecil = img.copyResize(master,
            width: entri.value,
            height: entri.value,
            interpolation: img.Interpolation.cubic);
        File('$resDir/${entri.key}/ic_launcher.png')
            .writeAsBytesSync(img.encodePng(kecil));
      }

      // Adaptive foreground: artwork diperkecil ke safe zone 66%.
      final kanvasFg = img.Image(width: 1024, height: 1024, numChannels: 4);
      final artworkKecil = img.copyResize(master,
          width: 680, height: 680, interpolation: img.Interpolation.cubic);
      img.compositeImage(kanvasFg, artworkKecil, dstX: 172, dstY: 172);
      const ukuranFg = {
        'mipmap-mdpi': 108,
        'mipmap-hdpi': 162,
        'mipmap-xhdpi': 216,
        'mipmap-xxhdpi': 324,
        'mipmap-xxxhdpi': 432,
      };
      for (final entri in ukuranFg.entries) {
        final fg = img.copyResize(kanvasFg,
            width: entri.value,
            height: entri.value,
            interpolation: img.Interpolation.cubic);
        File('$resDir/${entri.key}/ic_launcher_foreground.png')
            .writeAsBytesSync(img.encodePng(fg));
      }

      // Master 1024 utk kebutuhan store/dokumentasi.
      File('finara-icon-1024.png')
          .writeAsBytesSync(img.encodePng(master));
    });
  });
}
