import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/dana_recommendation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = DanaRecommendationService();

  test('rekomendasi smart liquidity: biasa = kebutuhan horizon (§89)', () {
    final r = service.rekomendasikan(
      danaDasarPembagian: 400000,
      danaPlusAktif: true,
      sisaAnggaranAktual: 300000,
      hariTersisaPeriode: 30,
      hariSampaiTopUpBerikutnya: 5,
      transaksiTerjadwalBelumTermasuk: 50000,
      bufferKeamanan: 20000,
    );
    expect(r, isNotNull);
    // Horizon = min(7, 30, 5) = 5; anggaran horizon = 300000~/30*5 = 50000.
    expect(r!.hariHorizon, 5);
    expect(r.anggaranHorizon, 50000);
    expect(r.tagihanBelumTermasuk, 50000);
    expect(r.buffer, 20000);
    // Kebutuhan biasa = 50000+50000+20000 = 120000 → plus = 280000.
    expect(r.keBiasa, 120000);
    expect(r.kePlus, 280000);
    expect(r.danaBelumDiperlukan, 280000);
    expect(r.keBiasa + r.kePlus, 400000);
  });

  test('null saat DANA+ nonaktif atau dana nol', () {
    expect(
        service.rekomendasikan(
            danaDasarPembagian: 100000, danaPlusAktif: false),
        isNull);
    expect(
        service.rekomendasikan(danaDasarPembagian: 0, danaPlusAktif: true),
        isNull);
  });

  test('menghormati batas DANA+ pengguna (§90)', () {
    final r = service.rekomendasikan(
      danaDasarPembagian: 500000,
      danaPlusAktif: true,
      sisaAnggaranAktual: 0,
      hariTersisaPeriode: 30,
      batasDanaPlus: 150000,
      saldoAwalDanaPlus: 100000,
    );
    // Ruang batas hanya 50000 → sisanya ke Biasa.
    expect(r!.kePlus, 50000);
    expect(r.keBiasa, 450000);
  });

  test('pembulatan floor pada DANA+; Biasa residual (§91)', () {
    final r = service.rekomendasikan(
      danaDasarPembagian: 400000,
      danaPlusAktif: true,
      sisaAnggaranAktual: 123456,
      hariTersisaPeriode: 30,
      pembulatan: RoundingOption.limaRibu,
    );
    expect(r!.kePlus % 5000, 0);
    expect(r.keBiasa + r.kePlus, 400000);
  });

  group('DanaChecklistBuilder (§93)', () {
    const builder = DanaChecklistBuilder();

    test('urutan 5 langkah lengkap saat DANA+ aktif', () {
      final entri = builder.susun(
        nominalTopUp: 400000,
        keBiasa: 250000,
        kePlus: 150000,
        danaPlusAktif: true,
      );
      expect(entri.map((e) => e.step), [
        DanaChecklistStep.topUp,
        DanaChecklistStep.pertahankanBiasa,
        DanaChecklistStep.pindahkanKePlus,
        DanaChecklistStep.periksaTotal,
        DanaChecklistStep.catatAktual,
      ]);
      expect(entri[0].nominal, 400000);
      expect(entri[1].nominal, 250000);
      expect(entri[2].nominal, 150000);
    });

    test('tanpa langkah pindah ke Plus saat nonaktif atau Rp0', () {
      final entri = builder.susun(
        nominalTopUp: 400000,
        keBiasa: 400000,
        kePlus: 0,
        danaPlusAktif: true,
      );
      expect(entri.map((e) => e.step),
          isNot(contains(DanaChecklistStep.pindahkanKePlus)));
    });

    test('kosong saat nominal top-up nol', () {
      expect(
          builder.susun(
              nominalTopUp: 0,
              keBiasa: 0,
              kePlus: 0,
              danaPlusAktif: true),
          isEmpty);
    });
  });
}
