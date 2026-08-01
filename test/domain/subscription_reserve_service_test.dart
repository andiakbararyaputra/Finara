import 'package:finara/domain/models/allocation_input.dart';
import 'package:finara/domain/services/subscription_reserve_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = SubscriptionReserveService();

  test('langganan bulanan: kontribusi = nominal, tanpa cadangan', () {
    final hasil = service.hitungBulanAktif(
      langganan: const [
        SubscriptionInput(
          id: 's1',
          nama: 'Streaming',
          siklus: SubscriptionCycle.bulanan,
          nominal: 54000,
        ),
      ],
      bulan: 3,
    );
    expect(hasil.totalKontribusiBulanIni, 54000);
    expect(hasil.totalTagihanJatuhTempo, 0);
    expect(hasil.kebutuhanKantongLangganan, 54000);
  });

  test('langganan nonaktif diabaikan', () {
    final hasil = service.hitungBulanAktif(
      langganan: const [
        SubscriptionInput(
          id: 's1',
          nama: 'Off',
          siklus: SubscriptionCycle.bulanan,
          nominal: 50000,
          aktif: false,
        ),
      ],
      bulan: 1,
    );
    expect(hasil.rencanaPerLangganan, isEmpty);
    expect(hasil.kebutuhanKantongLangganan, 0);
  });

  test('sumber Kantong Pengeluaran Wajib tidak masuk kebutuhan kantong '
      'langganan (§14)', () {
    final hasil = service.hitungBulanAktif(
      langganan: const [
        SubscriptionInput(
          id: 's1',
          nama: 'Internet',
          siklus: SubscriptionCycle.bulanan,
          nominal: 300000,
          sumberAnggaran: SubscriptionFundingSource.kantongPengeluaranWajib,
        ),
      ],
      bulan: 5,
    );
    expect(hasil.totalKontribusiBulanIni, 300000);
    expect(hasil.kebutuhanKantongLangganan, 0);
  });

  group('cadangan bulanan tahunan (§15)', () {
    const tahunan = SubscriptionInput(
      id: 'y1',
      nama: 'Domain',
      siklus: SubscriptionCycle.tahunan,
      nominal: 1000000,
      bulanTagihan: 12,
    );

    test('kontribusi dasar = biayaTahunan ~/ 12', () {
      final hasil = service.hitungBulanAktif(langganan: const [tahunan], bulan: 3);
      expect(hasil.totalKontribusiBulanIni, 1000000 ~/ 12); // 83333
    });

    test('sisa integer masuk ke kontribusi bulan jatuh tempo', () {
      final hasil =
          service.hitungBulanAktif(langganan: const [tahunan], bulan: 12);
      final plan = hasil.rencanaPerLangganan.single;
      expect(plan.kontribusiBulanIni, 83333 + 1000000 % 12); // 83333 + 4
      // 12 bulan penuh: 11×83333 + 83337 = 1000000.
      expect(11 * 83333 + plan.kontribusiBulanIni, 1000000);
    });

    test('bulan jatuh tempo: bayar dari cadangan, kekurangan eksplisit', () {
      const dgnSaldo = SubscriptionInput(
        id: 'y1',
        nama: 'Domain',
        siklus: SubscriptionCycle.tahunan,
        nominal: 1000000,
        bulanTagihan: 12,
        saldoCadanganAwal: 916663, // 11 bulan × 83333
      );
      final hasil =
          service.hitungBulanAktif(langganan: const [dgnSaldo], bulan: 12);
      final plan = hasil.rencanaPerLangganan.single;
      expect(plan.pembayaranDariCadangan, 1000000);
      expect(plan.kekuranganCadangan, 0);
      expect(plan.saldoCadanganAkhir, 0);
    });

    test('cadangan kurang: kekurangan tidak disembunyikan', () {
      final hasil =
          service.hitungBulanAktif(langganan: const [tahunan], bulan: 12);
      final plan = hasil.rencanaPerLangganan.single;
      // Tanpa saldo awal, hanya kontribusi bulan ini yang tersedia.
      expect(plan.pembayaranDariCadangan, plan.kontribusiBulanIni);
      expect(plan.kekuranganCadangan,
          1000000 - plan.kontribusiBulanIni);
    });
  });

  test('bayar saat jatuh tempo: tagihan penuh hanya di bulan tagihan', () {
    const item = SubscriptionInput(
      id: 'y2',
      nama: 'Lisensi',
      siklus: SubscriptionCycle.tahunan,
      nominal: 600000,
      bulanTagihan: 7,
      metodeTahunan: AnnualFundingMethod.bayarSaatJatuhTempo,
    );
    final luar = service.hitungBulanAktif(langganan: const [item], bulan: 6);
    expect(luar.totalTagihanJatuhTempo, 0);
    expect(luar.totalKontribusiBulanIni, 0);

    final pas = service.hitungBulanAktif(langganan: const [item], bulan: 7);
    expect(pas.totalTagihanJatuhTempo, 600000);
    expect(pas.kebutuhanKantongLangganan, 600000);
  });
}
