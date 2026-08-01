/// Rencana langganan bulan aktif + ledger cadangan tahunan (§15).
/// Deterministik: `biayaTahunan ~/ 12`, sisa integer ke kontribusi terakhir
/// sebelum jatuh tempo (kontribusi pada bulan tagihan itu sendiri).
library;

import '../models/allocation_input.dart';
import '../models/allocation_result.dart';

class SubscriptionReserveService {
  const SubscriptionReserveService();

  SubscriptionPlanResult hitungBulanAktif({
    required List<SubscriptionInput> langganan,
    required int bulan,
  }) {
    final rencana = <SubscriptionMonthlyPlan>[];
    var totalKontribusi = 0;
    var totalTagihan = 0;
    var totalKekurangan = 0;
    var kebutuhanKantongLangganan = 0;

    for (final item in langganan) {
      if (!item.aktif) continue;
      final plan = _hitungSatuLangganan(item, bulan);
      rencana.add(plan);
      totalKontribusi += plan.kontribusiBulanIni;
      totalTagihan += plan.tagihanJatuhTempoBulanIni;
      totalKekurangan += plan.kekuranganCadangan;
      if (item.sumberAnggaran ==
          SubscriptionFundingSource.kantongLanggananJago) {
        kebutuhanKantongLangganan +=
            plan.kontribusiBulanIni + plan.tagihanJatuhTempoBulanIni;
      }
    }

    return SubscriptionPlanResult(
      rencanaPerLangganan: List.unmodifiable(rencana),
      totalKontribusiBulanIni: totalKontribusi,
      totalTagihanJatuhTempo: totalTagihan,
      totalKekuranganCadangan: totalKekurangan,
      kebutuhanKantongLangganan: kebutuhanKantongLangganan,
    );
  }

  SubscriptionMonthlyPlan _hitungSatuLangganan(
    SubscriptionInput item,
    int bulan,
  ) {
    switch (item.siklus) {
      case SubscriptionCycle.bulanan:
        return SubscriptionMonthlyPlan(
          id: item.id,
          nama: item.nama,
          sumberAnggaran: item.sumberAnggaran,
          kontribusiBulanIni: item.nominal,
          tagihanJatuhTempoBulanIni: 0,
          saldoCadanganAwal: item.saldoCadanganAwal,
          pembayaranDariCadangan: 0,
          saldoCadanganAkhir: item.saldoCadanganAwal,
          kekuranganCadangan: 0,
        );
      case SubscriptionCycle.tahunan:
        switch (item.metodeTahunan) {
          case AnnualFundingMethod.cadanganBulanan:
            return _hitungCadanganBulanan(item, bulan);
          case AnnualFundingMethod.bayarSaatJatuhTempo:
            final jatuhTempo = bulan == item.bulanTagihan;
            return SubscriptionMonthlyPlan(
              id: item.id,
              nama: item.nama,
              sumberAnggaran: item.sumberAnggaran,
              kontribusiBulanIni: 0,
              tagihanJatuhTempoBulanIni: jatuhTempo ? item.nominal : 0,
              saldoCadanganAwal: item.saldoCadanganAwal,
              pembayaranDariCadangan: 0,
              saldoCadanganAkhir: item.saldoCadanganAwal,
              kekuranganCadangan: 0,
            );
        }
    }
  }

  SubscriptionMonthlyPlan _hitungCadanganBulanan(
    SubscriptionInput item,
    int bulan,
  ) {
    final dasar = item.nominal ~/ 12;
    final sisa = item.nominal % 12;
    final bulanJatuhTempo = bulan == item.bulanTagihan;
    final kontribusi = dasar + (bulanJatuhTempo ? sisa : 0);

    var pembayaran = 0;
    var kekurangan = 0;
    var saldoAkhir = item.saldoCadanganAwal + kontribusi;
    if (bulanJatuhTempo) {
      final tersedia = saldoAkhir;
      pembayaran = tersedia >= item.nominal ? item.nominal : tersedia;
      kekurangan = item.nominal - pembayaran;
      saldoAkhir = tersedia - pembayaran;
    }

    return SubscriptionMonthlyPlan(
      id: item.id,
      nama: item.nama,
      sumberAnggaran: item.sumberAnggaran,
      kontribusiBulanIni: kontribusi,
      tagihanJatuhTempoBulanIni: 0,
      saldoCadanganAwal: item.saldoCadanganAwal,
      pembayaranDariCadangan: pembayaran,
      saldoCadanganAkhir: saldoAkhir,
      kekuranganCadangan: kekurangan,
    );
  }
}
