/// State alur Hitung multi-step (§10–§13). Controller hanya menampung
/// input dan mendelegasikan perhitungan ke AllocationEngine (domain).
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/basis_points.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/allocation_preset.dart';
import '../../domain/models/allocation_result.dart';
import '../../domain/models/allocation_violation.dart';
import '../../domain/services/allocation_engine.dart';
import '../../domain/services/allocation_validator.dart';

class HitungState {
  const HitungState({
    this.penghasilanUtama,
    this.kasPeganganBrimo = 300000,
    this.penghasilanTambahan = const [],
    this.pengeluaranWajib = const [],
    this.preset = AllocationPreset.standardHybrid,
    this.jagoBp = 4000,
    this.investasiBp = 3000,
    this.danaBp = 3000,
    this.bibitBp = 7000,
    this.stockbitBp = 3000,
    this.pembulatan = RoundingOption.tanpa,
    this.frekuensiTopUpDana = DanaTopUpFrequency.mingguan,
    this.metodeSubJago = JagoSubAllocationMethod.persentaseTetap,
  });

  final int? penghasilanUtama;
  final int kasPeganganBrimo;
  final List<IncomeSourceInput> penghasilanTambahan;
  final List<MandatoryExpenseInput> pengeluaranWajib;

  /// Null = mode Custom.
  final AllocationPreset? preset;
  final int jagoBp;
  final int investasiBp;
  final int danaBp;
  final int bibitBp;
  final int stockbitBp;
  final RoundingOption pembulatan;
  final DanaTopUpFrequency frekuensiTopUpDana;
  final JagoSubAllocationMethod metodeSubJago;

  int get totalPendapatan =>
      (penghasilanUtama ?? 0) +
      penghasilanTambahan
          .where((s) => s.disertakanBulanAktif)
          .fold<int>(0, (sum, s) => sum + s.nominal);

  int get totalPengeluaranWajib =>
      pengeluaranWajib.fold<int>(0, (sum, e) => sum + e.nominal);

  bool get persentaseUtamaValid =>
      isFullAllocation([jagoBp, investasiBp, danaBp]);

  bool get persentaseInvestasiValid =>
      investasiBp == 0 || isFullAllocation([bibitBp, stockbitBp]);

  bool get pendapatanValid =>
      (penghasilanUtama ?? 0) > 0 &&
      kasPeganganBrimo <= totalPendapatan &&
      kasPeganganBrimo + totalPengeluaranWajib <= totalPendapatan;

  bool get siapHitung =>
      pendapatanValid && persentaseUtamaValid && persentaseInvestasiValid;

  HitungState copyWith({
    int? penghasilanUtama,
    int? kasPeganganBrimo,
    List<IncomeSourceInput>? penghasilanTambahan,
    List<MandatoryExpenseInput>? pengeluaranWajib,
    AllocationPreset? preset,
    bool hapusPreset = false,
    int? jagoBp,
    int? investasiBp,
    int? danaBp,
    int? bibitBp,
    int? stockbitBp,
    RoundingOption? pembulatan,
    DanaTopUpFrequency? frekuensiTopUpDana,
    JagoSubAllocationMethod? metodeSubJago,
  }) {
    return HitungState(
      penghasilanUtama: penghasilanUtama ?? this.penghasilanUtama,
      kasPeganganBrimo: kasPeganganBrimo ?? this.kasPeganganBrimo,
      penghasilanTambahan: penghasilanTambahan ?? this.penghasilanTambahan,
      pengeluaranWajib: pengeluaranWajib ?? this.pengeluaranWajib,
      preset: hapusPreset ? null : (preset ?? this.preset),
      jagoBp: jagoBp ?? this.jagoBp,
      investasiBp: investasiBp ?? this.investasiBp,
      danaBp: danaBp ?? this.danaBp,
      bibitBp: bibitBp ?? this.bibitBp,
      stockbitBp: stockbitBp ?? this.stockbitBp,
      pembulatan: pembulatan ?? this.pembulatan,
      frekuensiTopUpDana: frekuensiTopUpDana ?? this.frekuensiTopUpDana,
      metodeSubJago: metodeSubJago ?? this.metodeSubJago,
    );
  }

  AllocationInput keInput({
    required int tahun,
    required int bulan,
    List<SubscriptionInput> langganan = const [],
  }) {
    return AllocationInput(
      tahun: tahun,
      bulan: bulan,
      penghasilanUtama: penghasilanUtama ?? 0,
      penghasilanTambahan: penghasilanTambahan,
      kasPeganganBrimo: kasPeganganBrimo,
      pengeluaranWajib: pengeluaranWajib,
      jagoBp: jagoBp,
      investasiBp: investasiBp,
      danaBp: danaBp,
      bibitBp: bibitBp,
      stockbitBp: stockbitBp,
      pembulatan: pembulatan,
      metodeSubJago: metodeSubJago,
      langganan: langganan,
      frekuensiTopUpDana: frekuensiTopUpDana,
    );
  }
}

/// Argumen halaman Hasil.
class HasilArgs {
  const HasilArgs({
    required this.input,
    required this.hasil,
    this.namaPreset,
  });

  final AllocationInput input;
  final AllocationResult hasil;
  final String? namaPreset;
}

class HitungController extends Notifier<HitungState> {
  static const _engine = AllocationEngine();
  static const _validator = AllocationValidator();

  @override
  HitungState build() => const HitungState();

  void setPenghasilanUtama(int? nilai) =>
      state = state.copyWith(penghasilanUtama: nilai);

  void setKasPegangan(int nilai) =>
      state = state.copyWith(kasPeganganBrimo: nilai);

  void tambahPenghasilan(IncomeSourceInput item) => state = state.copyWith(
      penghasilanTambahan: [...state.penghasilanTambahan, item]);

  void hapusPenghasilan(int index) => state = state.copyWith(
      penghasilanTambahan: [...state.penghasilanTambahan]..removeAt(index));

  void tambahPengeluaran(MandatoryExpenseInput item) => state =
      state.copyWith(pengeluaranWajib: [...state.pengeluaranWajib, item]);

  void hapusPengeluaran(int index) => state = state.copyWith(
      pengeluaranWajib: [...state.pengeluaranWajib]..removeAt(index));

  void pilihPreset(AllocationPreset preset) => state = state.copyWith(
        preset: preset,
        jagoBp: preset.jagoBp,
        investasiBp: preset.investasiBp,
        danaBp: preset.danaBp,
        bibitBp: preset.bibitBp,
        stockbitBp: preset.stockbitBp,
      );

  void setCustomUtama({int? jagoBp, int? investasiBp, int? danaBp}) =>
      state = state.copyWith(
        hapusPreset: true,
        jagoBp: jagoBp,
        investasiBp: investasiBp,
        danaBp: danaBp,
      );

  void setCustomInvestasi({int? bibitBp, int? stockbitBp}) =>
      state = state.copyWith(
        hapusPreset: true,
        bibitBp: bibitBp,
        stockbitBp: stockbitBp,
      );

  void setPembulatan(RoundingOption opsi) =>
      state = state.copyWith(pembulatan: opsi);

  void setFrekuensiDana(DanaTopUpFrequency frekuensi) =>
      state = state.copyWith(frekuensiTopUpDana: frekuensi);

  void setMetodeSubJago(JagoSubAllocationMethod metode) =>
      state = state.copyWith(metodeSubJago: metode);

  void reset() => state = const HitungState();

  /// Prefill dari revisi tersimpan (edit draf / duplikasi §22).
  void prefill({
    required int penghasilanUtama,
    required int kasPeganganBrimo,
    required List<IncomeSourceInput> penghasilanTambahan,
    required List<MandatoryExpenseInput> pengeluaranWajib,
    required String? namaPreset,
    required int jagoBp,
    required int investasiBp,
    required int danaBp,
    required int bibitBp,
    required int stockbitBp,
    required RoundingOption pembulatan,
    required JagoSubAllocationMethod metodeSubJago,
    required DanaTopUpFrequency frekuensiTopUpDana,
  }) {
    AllocationPreset? preset;
    for (final p in AllocationPreset.values) {
      if (p.name == namaPreset) preset = p;
    }
    state = HitungState(
      penghasilanUtama: penghasilanUtama,
      kasPeganganBrimo: kasPeganganBrimo,
      penghasilanTambahan: penghasilanTambahan,
      pengeluaranWajib: pengeluaranWajib,
      preset: preset,
      jagoBp: jagoBp,
      investasiBp: investasiBp,
      danaBp: danaBp,
      bibitBp: bibitBp,
      stockbitBp: stockbitBp,
      pembulatan: pembulatan,
      metodeSubJago: metodeSubJago,
      frekuensiTopUpDana: frekuensiTopUpDana,
    );
  }

  /// Hitung untuk bulan berjalan; hasil valid dijamin validator.
  /// [diblokirLangganan] true jika kebutuhan langganan > Alokasi Jago (§14).
  (HasilArgs?, {bool diblokirLangganan}) hitung({
    List<SubscriptionInput> langganan = const [],
    DateTime? sekarang,
  }) {
    final kini = sekarang ?? DateTime.now();
    final input = state.keInput(
        tahun: kini.year, bulan: kini.month, langganan: langganan);
    if (_validator.validasiInput(input).isNotEmpty) {
      return (null, diblokirLangganan: false);
    }
    final hasil = _engine.hitung(input);
    final pelanggaran = _validator.validasiHasil(input, hasil);
    if (pelanggaran.isEmpty) {
      return (
        HasilArgs(input: input, hasil: hasil, namaPreset: state.preset?.name),
        diblokirLangganan: false,
      );
    }
    final hanyaBlokirLangganan = pelanggaran.every((p) =>
        p.code ==
        AllocationViolationCode.kebutuhanLanggananMelebihiAlokasiJago);
    return (null, diblokirLangganan: hanyaBlokirLangganan);
  }
}

final hitungControllerProvider =
    NotifierProvider<HitungController, HitungState>(HitungController.new);
