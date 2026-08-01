import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/emergency_fund_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = EmergencyFundService();

  const wajib = [
    MandatoryExpenseInput(
        nama: 'Kos', nominal: 1500000, dihitungDasarDanaDarurat: true),
    MandatoryExpenseInput(
        nama: 'Makan', nominal: 900000, dihitungDasarDanaDarurat: true),
    MandatoryExpenseInput(nama: 'Internet', nominal: 300000),
  ];

  test('pengeluaran pokok otomatis dari kategori bertanda (§16)', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(targetJumlahBulan: 6),
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 500000,
    )!;
    expect(plan.pengeluaranPokok, 2400000);
    expect(plan.pengeluaranPokokDariManual, isFalse);
    expect(plan.targetNominal, 14400000);
    expect(plan.kekurangan, 14400000);
  });

  test('koreksi manual menimpa otomatis tapi ditandai', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(
          targetJumlahBulan: 6, pengeluaranPokokManual: 2000000),
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 0,
    )!;
    expect(plan.pengeluaranPokok, 2000000);
    expect(plan.pengeluaranPokokDariManual, isTrue);
  });

  test('estimasi bulan tercapai: ceiling division', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(
          targetJumlahBulan: 6, saldoSaatIni: 400000),
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 1000000,
    )!;
    expect(plan.kekurangan, 14000000);
    expect(plan.estimasiBulanTercapai, 14);
  });

  test('target tercapai: kekurangan 0, estimasi 0', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(
          targetJumlahBulan: 6, saldoSaatIni: 20000000),
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 0,
    )!;
    expect(plan.kekurangan, 0);
    expect(plan.estimasiBulanTercapai, 0);
    expect(plan.progresBp, 10000); // dibatasi 100%
  });

  test('kontribusi nol dan masih kurang: estimasi null', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(targetJumlahBulan: 6),
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 0,
    )!;
    expect(plan.estimasiBulanTercapai, isNull);
  });

  test('input null: rencana null, bukan nol (§53 null vs 0)', () {
    final plan = service.hitung(
      input: null,
      pengeluaranWajib: wajib,
      kontribusiBulanIni: 100,
    );
    expect(plan, isNull);
  });

  test('target nol: progres null', () {
    final plan = service.hitung(
      input: const EmergencyFundInput(targetJumlahBulan: 0),
      pengeluaranWajib: const [],
      kontribusiBulanIni: 0,
    )!;
    expect(plan.progresBp, isNull);
  });
}
