import 'package:finara/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FinaraApp()));
    await tester.pumpAndSettle();
  }

  testWidgets('menampilkan 4 menu navigasi Fase 1 tanpa Finara AI',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Beranda'), findsWidgets);
    expect(find.text('Hitung'), findsWidgets);
    expect(find.text('Progres'), findsWidgets);
    expect(find.text('Riwayat'), findsWidgets);
    expect(find.text('Finara AI'), findsNothing);
  });

  testWidgets('beranda menampilkan empty state dan tombol Hitung Alokasi',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('Finara'), findsWidgets);
    expect(find.text('Belum ada alokasi bulan ini'), findsOneWidget);
    expect(find.text('Hitung Alokasi'), findsOneWidget);
  });

  testWidgets('tombol Hitung Alokasi membuka halaman Hitung', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Hitung Alokasi'));
    await tester.pumpAndSettle();

    expect(find.text('Siap menghitung alokasi'), findsOneWidget);
  });

  testWidgets('navigasi bawah berpindah antarhalaman', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Riwayat'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada riwayat'), findsOneWidget);

    await tester.tap(find.text('Progres'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada data progres'), findsOneWidget);
  });

  testWidgets('pengaturan tema mengganti mode gelap', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Tema'), findsOneWidget);

    await tester.tap(find.text('Gelap'));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });
}
