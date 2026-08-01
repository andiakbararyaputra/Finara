/// Target dan progres dana darurat (§16).
library;

import '../models/allocation_input.dart';
import '../models/allocation_result.dart';

class EmergencyFundService {
  const EmergencyFundService();

  EmergencyFundPlan? hitung({
    required EmergencyFundInput? input,
    required List<MandatoryExpenseInput> pengeluaranWajib,
    required int kontribusiBulanIni,
  }) {
    if (input == null) return null;

    final pokokOtomatis = pengeluaranWajib
        .where((e) => e.dihitungDasarDanaDarurat)
        .fold<int>(0, (sum, e) => sum + e.nominal);
    final pokok = input.pengeluaranPokokManual ?? pokokOtomatis;
    final target = pokok * input.targetJumlahBulan;
    final kekurangan =
        target > input.saldoSaatIni ? target - input.saldoSaatIni : 0;

    int? estimasiBulan;
    if (kekurangan == 0) {
      estimasiBulan = 0;
    } else if (kontribusiBulanIni > 0) {
      // Ceiling division: bulan terakhir boleh kontribusi parsial.
      estimasiBulan = (kekurangan + kontribusiBulanIni - 1) ~/ kontribusiBulanIni;
    }

    return EmergencyFundPlan(
      pengeluaranPokok: pokok,
      pengeluaranPokokDariManual: input.pengeluaranPokokManual != null,
      targetJumlahBulan: input.targetJumlahBulan,
      targetNominal: target,
      saldoSaatIni: input.saldoSaatIni,
      kekurangan: kekurangan,
      kontribusiBulanIni: kontribusiBulanIni,
      estimasiBulanTercapai: estimasiBulan,
    );
  }
}
