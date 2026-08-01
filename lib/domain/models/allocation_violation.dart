/// Pelanggaran validasi alokasi (§53). Kode dipetakan ke pesan ARB di
/// lapisan presentasi; [detail] hanya untuk debugging dan pengujian.
library;

enum AllocationViolationCode {
  penghasilanUtamaTidakPositif,
  nominalNegatif,
  kasPeganganMelebihiTotalPendapatan,
  danaBersihNegatif,
  persentaseUtamaTidakSeratus,
  persentaseInvestasiTidakSeratus,
  persentaseSubJagoTidakSeratus,
  kebutuhanLanggananMelebihiAlokasiJago,
  invarianTotalPendapatanGagal,
  invarianDanaBersihGagal,
  invarianInvestasiGagal,
  invarianDanaMasukJagoGagal,
  selisihBelumDialokasikanTidakNol,
  subAlokasiJagoTidakKonsisten,
  jadwalDanaTidakKonsisten,
  komponenHasilNegatif,
}

class AllocationViolation {
  const AllocationViolation(this.code, [this.detail = '']);

  final AllocationViolationCode code;
  final String detail;

  @override
  String toString() => 'AllocationViolation(${code.name}: $detail)';
}
