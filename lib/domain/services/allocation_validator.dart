/// Validator alokasi (§53): pemeriksaan input sebelum hitung dan pemeriksaan
/// seluruh invarian setelah pembulatan. Hasil dengan pelanggaran tidak boleh
/// disimpan; Selisih Belum Dialokasikan wajib Rp0.
library;

import '../../core/basis_points.dart';
import '../models/allocation_input.dart';
import '../models/allocation_result.dart';
import '../models/allocation_violation.dart';
import 'allocation_engine.dart';

class AllocationValidator {
  const AllocationValidator();

  List<AllocationViolation> validasiInput(AllocationInput input) {
    final v = <AllocationViolation>[];

    if (input.penghasilanUtama <= 0) {
      v.add(AllocationViolation(
        AllocationViolationCode.penghasilanUtamaTidakPositif,
        'penghasilanUtama=${input.penghasilanUtama}',
      ));
    }

    final adaNominalNegatif = input.kasPeganganBrimo < 0 ||
        input.penghasilanTambahan.any((s) => s.nominal < 0) ||
        input.pengeluaranWajib.any((e) => e.nominal < 0) ||
        input.langganan.any((s) => s.nominal < 0 || s.saldoCadanganAwal < 0) ||
        (input.danaDarurat != null &&
            (input.danaDarurat!.saldoSaatIni < 0 ||
                input.danaDarurat!.targetJumlahBulan < 0 ||
                (input.danaDarurat!.pengeluaranPokokManual ?? 0) < 0));
    if (adaNominalNegatif) {
      v.add(const AllocationViolation(AllocationViolationCode.nominalNegatif));
    }

    final totalPendapatan = AllocationEngine.totalPendapatanDari(input);
    final totalWajib = AllocationEngine.totalPengeluaranWajibDari(input);
    if (input.kasPeganganBrimo > totalPendapatan) {
      v.add(AllocationViolation(
        AllocationViolationCode.kasPeganganMelebihiTotalPendapatan,
        'kas=${input.kasPeganganBrimo} > pendapatan=$totalPendapatan',
      ));
    } else if (input.kasPeganganBrimo + totalWajib > totalPendapatan) {
      v.add(AllocationViolation(
        AllocationViolationCode.danaBersihNegatif,
        'kas+wajib=${input.kasPeganganBrimo + totalWajib} > '
        'pendapatan=$totalPendapatan',
      ));
    }

    if (!isFullAllocation([input.jagoBp, input.investasiBp, input.danaBp])) {
      v.add(AllocationViolation(
        AllocationViolationCode.persentaseUtamaTidakSeratus,
        'jago=${input.jagoBp} investasi=${input.investasiBp} '
        'dana=${input.danaBp}',
      ));
    }

    if (input.investasiBp > 0 &&
        !isFullAllocation([input.bibitBp, input.stockbitBp])) {
      v.add(AllocationViolation(
        AllocationViolationCode.persentaseInvestasiTidakSeratus,
        'bibit=${input.bibitBp} stockbit=${input.stockbitBp}',
      ));
    }

    if (input.metodeSubJago == JagoSubAllocationMethod.persentaseTetap &&
        !isFullAllocation([
          input.subJagoLanggananBp,
          input.subJagoDaruratBp,
          input.subJagoOperasionalBp,
        ])) {
      v.add(AllocationViolation(
        AllocationViolationCode.persentaseSubJagoTidakSeratus,
        'langganan=${input.subJagoLanggananBp} '
        'darurat=${input.subJagoDaruratBp} '
        'operasional=${input.subJagoOperasionalBp}',
      ));
    }

    return v;
  }

  /// Jalankan ulang semua invarian setelah pembulatan (§18, §53).
  List<AllocationViolation> validasiHasil(
    AllocationInput input,
    AllocationResult hasil,
  ) {
    final v = <AllocationViolation>[];

    final komponen = <int>[
      hasil.alokasiJago,
      hasil.totalAlokasiInvestasi,
      hasil.alokasiDana,
      hasil.alokasiBibit,
      hasil.alokasiStockbit,
      hasil.totalDanaMasukJago,
      hasil.subAlokasiJago.danaDarurat,
      hasil.subAlokasiJago.danaOperasional,
    ];
    if (komponen.any((n) => n < 0)) {
      v.add(AllocationViolation(
        AllocationViolationCode.komponenHasilNegatif,
        komponen.toString(),
      ));
    }

    if (hasil.kasPeganganBrimo +
            hasil.totalDanaMasukJago +
            hasil.totalAlokasiInvestasi +
            hasil.alokasiDana !=
        hasil.totalPendapatan) {
      v.add(const AllocationViolation(
        AllocationViolationCode.invarianTotalPendapatanGagal,
      ));
    }

    if (hasil.alokasiJago + hasil.totalAlokasiInvestasi + hasil.alokasiDana !=
        hasil.danaBersih) {
      v.add(const AllocationViolation(
        AllocationViolationCode.invarianDanaBersihGagal,
      ));
    }

    if (hasil.alokasiBibit + hasil.alokasiStockbit !=
        hasil.totalAlokasiInvestasi) {
      v.add(const AllocationViolation(
        AllocationViolationCode.invarianInvestasiGagal,
      ));
    }

    if (hasil.totalDanaMasukJago !=
        hasil.totalPengeluaranWajib + hasil.alokasiJago) {
      v.add(const AllocationViolation(
        AllocationViolationCode.invarianDanaMasukJagoGagal,
      ));
    }

    if (hasil.selisihBelumDialokasikan != 0) {
      v.add(AllocationViolation(
        AllocationViolationCode.selisihBelumDialokasikanTidakNol,
        'selisih=${hasil.selisihBelumDialokasikan}',
      ));
    }

    // Kebutuhan langganan tidak boleh melebihi Alokasi Bank Jago (§14) —
    // peringatan saja tidak cukup, hasil diblokir.
    if (hasil.subAlokasiJago.sisaSetelahLangganan < 0) {
      v.add(AllocationViolation(
        AllocationViolationCode.kebutuhanLanggananMelebihiAlokasiJago,
        'sisa=${hasil.subAlokasiJago.sisaSetelahLangganan}',
      ));
    } else if (hasil.subAlokasiJago.total != hasil.alokasiJago) {
      v.add(AllocationViolation(
        AllocationViolationCode.subAlokasiJagoTidakKonsisten,
        'total=${hasil.subAlokasiJago.total} '
        'alokasiJago=${hasil.alokasiJago}',
      ));
    }

    final totalJadwal = hasil.jadwalDana.jadwalTopUp
        .fold<int>(0, (sum, e) => sum + e.nominal);
    if (totalJadwal != hasil.alokasiDana) {
      v.add(AllocationViolation(
        AllocationViolationCode.jadwalDanaTidakKonsisten,
        'totalJadwal=$totalJadwal alokasiDana=${hasil.alokasiDana}',
      ));
    }

    return v;
  }
}
