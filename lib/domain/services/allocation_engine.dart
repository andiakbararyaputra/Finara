/// Mesin alokasi Finara — Tahap 0–5 (§12) dengan pembulatan floor+residual
/// (§18). Pure Dart, deterministik, tanpa dependensi UI.
///
/// Prasyarat: input harus lolos [AllocationValidator.validasiInput];
/// jika tidak, [hitung] melempar [StateError].
library;

import '../../core/basis_points.dart';
import '../models/allocation_input.dart';
import '../models/allocation_result.dart';
import 'allocation_validator.dart';
import 'dana_schedule_service.dart';
import 'emergency_fund_service.dart';
import 'subscription_reserve_service.dart';

class AllocationEngine {
  const AllocationEngine({
    this.validator = const AllocationValidator(),
    this.langgananService = const SubscriptionReserveService(),
    this.danaDaruratService = const EmergencyFundService(),
    this.jadwalDanaService = const DanaScheduleService(),
  });

  final AllocationValidator validator;
  final SubscriptionReserveService langgananService;
  final EmergencyFundService danaDaruratService;
  final DanaScheduleService jadwalDanaService;

  AllocationResult hitung(AllocationInput input) {
    final pelanggaranInput = validator.validasiInput(input);
    if (pelanggaranInput.isNotEmpty) {
      throw StateError('Input tidak valid: $pelanggaranInput');
    }

    // Tahap 0 — Total Pendapatan.
    final totalPendapatan = totalPendapatanDari(input);

    // Tahap 1 — Dana Bersih.
    final totalWajib = totalPengeluaranWajibDari(input);
    final danaBersih =
        totalPendapatan - input.kasPeganganBrimo - totalWajib;

    // Tahap 2 — bagi Dana Bersih; floor Investasi & DANA, Jago residual (§18).
    final r = input.pembulatan;
    final investasiFinal =
        r.floorKe(applyBasisPoints(danaBersih, input.investasiBp));
    final danaFinal = r.floorKe(applyBasisPoints(danaBersih, input.danaBp));
    final jagoFinal = danaBersih - investasiFinal - danaFinal;

    // Tahap 3 — bagi internal investasi; floor Stockbit, Bibit residual (§18).
    final int stockbitFinal;
    final int bibitFinal;
    if (investasiFinal == 0) {
      stockbitFinal = 0;
      bibitFinal = 0;
    } else {
      stockbitFinal =
          r.floorKe(applyBasisPoints(investasiFinal, input.stockbitBp));
      bibitFinal = investasiFinal - stockbitFinal;
    }

    // Tahap 4 — Total Dana Masuk ke Bank Jago.
    final totalDanaMasukJago = totalWajib + jagoFinal;

    final selisih = totalPendapatan -
        (input.kasPeganganBrimo +
            totalDanaMasukJago +
            investasiFinal +
            danaFinal);

    final rencanaLangganan = langgananService.hitungBulanAktif(
      langganan: input.langganan,
      bulan: input.bulan,
    );

    final subJago = _hitungSubAlokasiJago(
      input: input,
      alokasiJago: jagoFinal,
      kebutuhanKantongLangganan: rencanaLangganan.kebutuhanKantongLangganan,
    );

    final danaDarurat = danaDaruratService.hitung(
      input: input.danaDarurat,
      pengeluaranWajib: input.pengeluaranWajib,
      kontribusiBulanIni: subJago.danaDarurat,
    );

    final jadwalDana = jadwalDanaService.hitung(
      totalAlokasiDana: danaFinal,
      tahun: input.tahun,
      bulan: input.bulan,
      frekuensi: input.frekuensiTopUpDana,
      hariTopUpMingguan: input.hariTopUpMingguan,
    );

    return AllocationResult(
      totalPendapatan: totalPendapatan,
      kasPeganganBrimo: input.kasPeganganBrimo,
      totalPengeluaranWajib: totalWajib,
      danaBersih: danaBersih,
      alokasiJago: jagoFinal,
      totalAlokasiInvestasi: investasiFinal,
      alokasiDana: danaFinal,
      alokasiBibit: bibitFinal,
      alokasiStockbit: stockbitFinal,
      totalDanaMasukJago: totalDanaMasukJago,
      selisihBelumDialokasikan: selisih,
      subAlokasiJago: subJago,
      rencanaLangganan: rencanaLangganan,
      jadwalDana: jadwalDana,
      rencanaDanaDarurat: danaDarurat,
    );
  }

  /// Tahap 0 (§12): utama + tambahan yang disertakan pada bulan aktif.
  static int totalPendapatanDari(AllocationInput input) {
    return input.penghasilanUtama +
        input.penghasilanTambahan
            .where((s) => s.disertakanBulanAktif)
            .fold<int>(0, (sum, s) => sum + s.nominal);
  }

  static int totalPengeluaranWajibDari(AllocationInput input) {
    return input.pengeluaranWajib.fold<int>(0, (sum, e) => sum + e.nominal);
  }

  JagoSubAllocationResult _hitungSubAlokasiJago({
    required AllocationInput input,
    required int alokasiJago,
    required int kebutuhanKantongLangganan,
  }) {
    final r = input.pembulatan;
    switch (input.metodeSubJago) {
      case JagoSubAllocationMethod.persentaseTetap:
        // Floor langganan & darurat; operasional residual (§18).
        final langganan =
            r.floorKe(applyBasisPoints(alokasiJago, input.subJagoLanggananBp));
        final darurat =
            r.floorKe(applyBasisPoints(alokasiJago, input.subJagoDaruratBp));
        final operasional = alokasiJago - langganan - darurat;
        return JagoSubAllocationResult(
          metode: input.metodeSubJago,
          kebutuhanLangganan: langganan,
          sisaSetelahLangganan: alokasiJago - langganan,
          danaDarurat: darurat,
          danaOperasional: operasional,
        );
      case JagoSubAllocationMethod.berdasarkanLangganan:
        // Rasio darurat:operasional = 5:4 dari sisa (§14).
        final sisa = alokasiJago - kebutuhanKantongLangganan;
        if (sisa < 0) {
          // Hasil diblokir oleh validator; jangan sembunyikan defisit.
          return JagoSubAllocationResult(
            metode: input.metodeSubJago,
            kebutuhanLangganan: kebutuhanKantongLangganan,
            sisaSetelahLangganan: sisa,
            danaDarurat: 0,
            danaOperasional: 0,
          );
        }
        final darurat = r.floorKe((sisa * 5) ~/ 9);
        final operasional = sisa - darurat;
        return JagoSubAllocationResult(
          metode: input.metodeSubJago,
          kebutuhanLangganan: kebutuhanKantongLangganan,
          sisaSetelahLangganan: sisa,
          danaDarurat: darurat,
          danaOperasional: operasional,
        );
    }
  }
}
