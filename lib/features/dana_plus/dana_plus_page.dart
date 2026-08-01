import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/services/dana_split_service.dart';
import '../../l10n/app_localizations.dart';

final danaPlusConfigProvider =
    FutureProvider<DanaPlusConfiguration?>((ref) {
  return ref.watch(danaPlusRepositoryProvider).konfigurasiAktif();
});

final _ledgerBulanIniProvider = FutureProvider<DanaBalanceLedger?>((ref) {
  final kini = DateTime.now();
  return ref
      .watch(danaPlusRepositoryProvider)
      .ledgerPeriode(kini.year, kini.month);
});

/// Pengaturan & pemantauan DANA+ (Bagian IX §86–§95).
class DanaPlusPage extends ConsumerStatefulWidget {
  const DanaPlusPage({super.key});

  @override
  ConsumerState<DanaPlusPage> createState() => _DanaPlusPageState();
}

class _DanaPlusPageState extends ConsumerState<DanaPlusPage> {
  DanaPlusAvailability _availability = DanaPlusAvailability.belumMenggunakan;
  DanaSplitMode _mode = DanaSplitMode.smartLiquidity;
  DanaExecutionStrategy _strategi = DanaExecutionStrategy.sekaligusLaluBagi;
  int _persenBiasa = 50;
  int _bufferBiasa = 0;
  int _targetPlus = 0;
  int? _batasPlus;
  int? _tingkatRewardBp;
  RewardRatePeriod _periodeReward = RewardRatePeriod.perTahun;
  bool _dimuat = false;

  bool get _aktif => _availability == DanaPlusAvailability.menggunakan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final tersimpan = ref.watch(danaPlusConfigProvider).value;
    if (!_dimuat && tersimpan != null) {
      _dimuat = true;
      _availability = tersimpan.availability;
      _mode = tersimpan.defaultSplitMode;
      _strategi = tersimpan.executionStrategy;
      _persenBiasa = tersimpan.persenBiasaBp ~/ 100;
      _bufferBiasa = tersimpan.bufferBiasa;
      _targetPlus = tersimpan.targetPlus;
      _batasPlus = tersimpan.batasPlus;
      _tingkatRewardBp = tersimpan.tingkatRewardBp;
      _periodeReward = tersimpan.periodeReward;
    }

    final revisi = ref.watch(revisiBulanAktifProvider).value;
    final ledger = ref.watch(_ledgerBulanIniProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.danaPlusJudul)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              DropdownButtonFormField<DanaPlusAvailability>(
                initialValue: _availability,
                isExpanded: true,
                decoration:
                    InputDecoration(labelText: l10n.statusDanaPlus),
                items: [
                  DropdownMenuItem(
                      value: DanaPlusAvailability.menggunakan,
                      child: Text(l10n.dpMenggunakan)),
                  DropdownMenuItem(
                      value: DanaPlusAvailability.belumMenggunakan,
                      child: Text(l10n.dpBelumMenggunakan)),
                  DropdownMenuItem(
                      value: DanaPlusAvailability.tidakTersedia,
                      child: Text(l10n.dpTidakTersedia)),
                  DropdownMenuItem(
                      value: DanaPlusAvailability.tidakIngin,
                      child: Text(l10n.dpTidakIngin)),
                ],
                onChanged: (v) => setState(() => _availability =
                    v ?? DanaPlusAvailability.belumMenggunakan),
              ),
              if (!_aktif)
                Padding(
                  padding: const EdgeInsets.only(top: FinaraSpacing.sm),
                  child: Text(l10n.danaPlusNonaktifInfo,
                      style: theme.textTheme.bodySmall),
                ),
              if (_aktif) ...[
                const SizedBox(height: FinaraSpacing.lg),
                DropdownButtonFormField<DanaSplitMode>(
                  initialValue: _mode,
                  isExpanded: true,
                  decoration:
                      InputDecoration(labelText: l10n.modePembagian),
                  items: [
                    DropdownMenuItem(
                        value: DanaSplitMode.smartLiquidity,
                        child: Text(l10n.modeSmartLiquidity)),
                    DropdownMenuItem(
                        value: DanaSplitMode.persentase,
                        child: Text(l10n.modePersentase)),
                    DropdownMenuItem(
                        value: DanaSplitMode.nominalTetapBiasa,
                        child: Text(l10n.modeNominalBiasa)),
                    DropdownMenuItem(
                        value: DanaSplitMode.nominalTetapPlus,
                        child: Text(l10n.modeNominalPlus)),
                  ],
                  onChanged: (v) => setState(
                      () => _mode = v ?? DanaSplitMode.smartLiquidity),
                ),
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<DanaExecutionStrategy>(
                  initialValue: _strategi,
                  isExpanded: true,
                  decoration:
                      InputDecoration(labelText: l10n.strategiEksekusi),
                  items: [
                    DropdownMenuItem(
                        value: DanaExecutionStrategy.sekaligusLaluBagi,
                        child: Text(l10n.strategiSekaligus)),
                    DropdownMenuItem(
                        value: DanaExecutionStrategy.bagiSetiapTopUp,
                        child: Text(l10n.strategiPerTopUp)),
                    DropdownMenuItem(
                        value: DanaExecutionStrategy.smartPerTopUp,
                        child: Text(l10n.strategiSmartPerTopUp)),
                  ],
                  onChanged: (v) => setState(() => _strategi =
                      v ?? DanaExecutionStrategy.sekaligusLaluBagi),
                ),
                if (_mode == DanaSplitMode.persentase) ...[
                  const SizedBox(height: FinaraSpacing.md),
                  Row(
                    children: [
                      Expanded(child: Text(l10n.persenBiasa)),
                      Expanded(
                        child: Slider(
                          value: _persenBiasa.toDouble(),
                          max: 100,
                          divisions: 100,
                          label: '$_persenBiasa%',
                          onChanged: (v) =>
                              setState(() => _persenBiasa = v.round()),
                        ),
                      ),
                      Text('$_persenBiasa%'),
                    ],
                  ),
                ],
                if (_mode == DanaSplitMode.nominalTetapBiasa) ...[
                  const SizedBox(height: FinaraSpacing.md),
                  _InputNominal(
                    label: l10n.bufferBiasa,
                    nilai: _bufferBiasa,
                    onChanged: (v) => setState(() => _bufferBiasa = v ?? 0),
                  ),
                ],
                if (_mode == DanaSplitMode.nominalTetapPlus) ...[
                  const SizedBox(height: FinaraSpacing.md),
                  _InputNominal(
                    label: l10n.targetPlusLabel,
                    nilai: _targetPlus,
                    onChanged: (v) => setState(() => _targetPlus = v ?? 0),
                  ),
                ],
                const SizedBox(height: FinaraSpacing.md),
                _InputNominal(
                  label: l10n.batasPlusLabel,
                  nilai: _batasPlus,
                  onChanged: (v) => setState(() => _batasPlus = v),
                ),
                const SizedBox(height: FinaraSpacing.lg),
                if (revisi != null)
                  _PratinjauSplit(
                    alokasiDana: revisi.alokasiDana,
                    input: _bangunInput(revisi.alokasiDana),
                  ),
                const SizedBox(height: FinaraSpacing.lg),
                _SimulasiReward(
                  tingkatRewardBp: _tingkatRewardBp,
                  periode: _periodeReward,
                  saldoAwal: ledger?.saldoAkhirPlus ?? 0,
                  onTingkatChanged: (bp) =>
                      setState(() => _tingkatRewardBp = bp),
                  onPeriodeChanged: (p) =>
                      setState(() => _periodeReward = p),
                ),
                const SizedBox(height: FinaraSpacing.lg),
                _CardLedger(ledger: ledger),
                const SizedBox(height: FinaraSpacing.lg),
                _CardTarikDariPlus(ledger: ledger),
              ],
              const SizedBox(height: FinaraSpacing.lg),
              FilledButton(
                onPressed: _simpan,
                child: Text(l10n.simpan),
              ),
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  DanaSplitInput _bangunInput(int alokasiDana) {
    final kini = DateTime.now();
    final hariDalamBulan = DateTime(kini.year, kini.month + 1, 0).day;
    return DanaSplitInput(
      danaDasarPembagian: alokasiDana,
      mode: _mode,
      danaPlusAktif: _aktif,
      persenBiasaBp: _persenBiasa * 100,
      nominalBufferBiasa: _bufferBiasa,
      targetNominalPlus: _targetPlus,
      sisaAnggaranAktual: alokasiDana,
      hariTersisaPeriode: hariDalamBulan - kini.day + 1,
      batasDanaPlus: _batasPlus,
    );
  }

  Future<void> _simpan() async {
    await ref.read(danaPlusRepositoryProvider).simpanKonfigurasi(
          availability: _availability,
          mode: _mode,
          strategi: _strategi,
          persenBiasaBp: _persenBiasa * 100,
          bufferBiasa: _bufferBiasa,
          targetPlus: _targetPlus,
          batasPlus: _batasPlus,
          tingkatRewardBp: _tingkatRewardBp,
          periodeReward: _periodeReward,
        );
    ref.invalidate(danaPlusConfigProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.tersimpanKeRiwayat)));
  }
}

class _PratinjauSplit extends StatelessWidget {
  const _PratinjauSplit({required this.alokasiDana, required this.input});

  final int alokasiDana;
  final DanaSplitInput input;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hasil = const DanaSplitService().hitung(input);

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${l10n.totalAlokasiDanaRencana}: ${formatRupiah(alokasiDana)}',
              style: theme.textTheme.titleSmall),
          const SizedBox(height: FinaraSpacing.sm),
          _Baris(l10n.saldoDanaBiasa, hasil.saldoBiasa),
          _Baris(l10n.saldoDanaPlus, hasil.saldoPlus),
          if (hasil.kelebihanDialihkan > 0)
            Padding(
              padding: const EdgeInsets.only(top: FinaraSpacing.sm),
              child: Text(l10n.kelebihanBatasInfo,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.tertiary)),
            ),
        ],
      ),
    );
  }
}

class _SimulasiReward extends StatelessWidget {
  const _SimulasiReward({
    required this.tingkatRewardBp,
    required this.periode,
    required this.saldoAwal,
    required this.onTingkatChanged,
    required this.onPeriodeChanged,
  });

  final int? tingkatRewardBp;
  final RewardRatePeriod periode;
  final int saldoAwal;
  final ValueChanged<int?> onTingkatChanged;
  final ValueChanged<RewardRatePeriod> onPeriodeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bp = tingkatRewardBp;
    final pertumbuhan = (bp == null || saldoAwal <= 0)
        ? null
        : const DanaPlusRewardSimulator().estimasiPertumbuhan(
            saldoAwal: saldoAwal, tingkatBp: bp, jumlahPeriode: 12);

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.simulasiReward, style: theme.textTheme.titleSmall),
          const SizedBox(height: FinaraSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: bp == null ? '' : formatBasisPoints(bp)
                      .replaceAll('%', ''),
                  decoration:
                      InputDecoration(labelText: l10n.tingkatReward),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    final persen =
                        double.tryParse(v.replaceAll(',', '.'));
                    onTingkatChanged(
                        persen == null ? null : (persen * 100).round());
                  },
                ),
              ),
              const SizedBox(width: FinaraSpacing.md),
              Expanded(
                child: DropdownButtonFormField<RewardRatePeriod>(
                  initialValue: periode,
                  decoration:
                      InputDecoration(labelText: l10n.periodeReward),
                  items: [
                    DropdownMenuItem(
                        value: RewardRatePeriod.perHari,
                        child: Text(l10n.perHari)),
                    DropdownMenuItem(
                        value: RewardRatePeriod.perBulan,
                        child: Text(l10n.perBulan)),
                    DropdownMenuItem(
                        value: RewardRatePeriod.perTahun,
                        child: Text(l10n.perTahun)),
                  ],
                  onChanged: (v) =>
                      onPeriodeChanged(v ?? RewardRatePeriod.perTahun),
                ),
              ),
            ],
          ),
          const SizedBox(height: FinaraSpacing.sm),
          _Baris(l10n.saldoAwal, saldoAwal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(l10n.estimasiPertumbuhan)),
              Text(
                pertumbuhan == null
                    ? l10n.tidakTersedia
                    : '+${formatRupiah(pertumbuhan)}',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: FinaraSpacing.sm),
          Text(l10n.disclaimerReward,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _CardLedger extends ConsumerWidget {
  const _CardLedger({required this.ledger});

  final DanaBalanceLedger? ledger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final l = ledger;

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(l10n.catatLedgerDana,
                    style: theme.textTheme.titleSmall),
              ),
              TextButton.icon(
                icon: const Icon(Icons.edit_note_rounded),
                label: Text(l10n.catatLedgerDana.split(' ').first),
                onPressed: () => _dialogLedger(context, ref),
              ),
            ],
          ),
          if (l != null) ...[
            _Baris('${l10n.saldoAkhir} — ${l10n.saldoDanaBiasa}',
                l.saldoAkhirBiasa),
            _Baris('${l10n.saldoAkhir} — ${l10n.saldoDanaPlus}',
                l.saldoAkhirPlus),
            _Baris(l10n.realisasiPindahPlus, l.pindahKePlus),
            _Baris(l10n.rewardAktual, l.rewardAktual),
          ] else
            Text(l10n.tidakTersedia, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  Future<void> _dialogLedger(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = List.generate(8, (_) => TextEditingController());
    final label = [
      '${l10n.saldoAwal} — ${l10n.saldoDanaBiasa}',
      '${l10n.saldoAwal} — ${l10n.saldoDanaPlus}',
      l10n.topUpKeBiasa,
      l10n.pindahKePlus,
      l10n.pindahDariPlus,
      l10n.pengeluaranDari(l10n.saldoDanaBiasa),
      l10n.pengeluaranDari(l10n.saldoDanaPlus),
      l10n.rewardAktual,
    ];
    final l = ledger;
    if (l != null) {
      final nilai = [
        l.saldoAwalBiasa,
        l.saldoAwalPlus,
        l.topUpKeBiasa,
        l.pindahKePlus,
        l.pindahDariPlus,
        l.pengeluaranBiasa,
        l.pengeluaranPlus,
        l.rewardAktual,
      ];
      for (var i = 0; i < 8; i++) {
        ctrl[i].text = formatRupiah(nilai[i]).substring(2);
      }
    }

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.catatLedgerDana),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 8; i++)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: FinaraSpacing.sm),
                  child: TextField(
                    controller: ctrl[i],
                    decoration: InputDecoration(
                        labelText: label[i],
                        prefixText: 'Rp',
                        isDense: true),
                    keyboardType: TextInputType.number,
                    inputFormatters: const [RupiahInputFormatter()],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.batal),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.simpan),
          ),
        ],
      ),
    );

    if (simpan == true) {
      int nilai(int i) => parseRupiah(ctrl[i].text) ?? 0;
      final kini = DateTime.now();
      await ref.read(danaPlusRepositoryProvider).catatLedger(
            tahun: kini.year,
            bulan: kini.month,
            saldoAwalBiasa: nilai(0),
            saldoAwalPlus: nilai(1),
            topUpKeBiasa: nilai(2),
            pindahKePlus: nilai(3),
            pindahDariPlus: nilai(4),
            pengeluaranBiasa: nilai(5),
            pengeluaranPlus: nilai(6),
            rewardAktual: nilai(7),
          );
      ref.invalidate(_ledgerBulanIniProvider);
    }
  }
}

class _CardTarikDariPlus extends ConsumerStatefulWidget {
  const _CardTarikDariPlus({required this.ledger});

  final DanaBalanceLedger? ledger;

  @override
  ConsumerState<_CardTarikDariPlus> createState() =>
      _CardTarikDariPlusState();
}

class _CardTarikDariPlusState extends ConsumerState<_CardTarikDariPlus> {
  final _nominalCtrl = TextEditingController();
  String? _pesan;

  @override
  void dispose() {
    _nominalCtrl.dispose();
    super.dispose();
  }

  Future<void> _catat() async {
    final l10n = AppLocalizations.of(context)!;
    final nominal = parseRupiah(_nominalCtrl.text) ?? 0;
    if (nominal <= 0) return;
    final l = widget.ledger;
    // §90: saldo DANA+ tidak boleh negatif — wajib ada saldo tercatat.
    if (l == null || l.saldoAkhirPlus < nominal) {
      setState(() => _pesan = l10n.tarikDariPlusTolak);
      return;
    }
    final kini = DateTime.now();
    await ref.read(danaPlusRepositoryProvider).catatLedger(
          tahun: kini.year,
          bulan: kini.month,
          saldoAwalBiasa: l.saldoAwalBiasa,
          saldoAwalPlus: l.saldoAwalPlus,
          topUpKeBiasa: l.topUpKeBiasa,
          pindahKePlus: l.pindahKePlus,
          pindahDariPlus: l.pindahDariPlus + nominal,
          pengeluaranBiasa: l.pengeluaranBiasa,
          pengeluaranPlus: l.pengeluaranPlus,
          rewardAktual: l.rewardAktual,
        );
    ref.invalidate(_ledgerBulanIniProvider);
    if (!mounted) return;
    _nominalCtrl.clear();
    setState(() => _pesan = null);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.pemindahanTercatat)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.tarikDariPlusJudul, style: theme.textTheme.titleSmall),
          const SizedBox(height: FinaraSpacing.sm),
          TextField(
            controller: _nominalCtrl,
            decoration: InputDecoration(
              labelText: l10n.nominal,
              prefixText: 'Rp',
              isDense: true,
              errorText: _pesan,
              errorMaxLines: 3,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: const [RupiahInputFormatter()],
          ),
          const SizedBox(height: FinaraSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonal(
              onPressed: _catat,
              child: Text(l10n.catat),
            ),
          ),
          if (widget.ledger != null)
            Padding(
              padding: const EdgeInsets.only(top: FinaraSpacing.sm),
              child: Text(
                '${l10n.saldoDanaPlus}: ${formatRupiah(widget.ledger!.saldoAkhirPlus)}',
                style: theme.textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}

class _Baris extends StatelessWidget {
  const _Baris(this.label, this.nominal);

  final String label;
  final int nominal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label)),
          Text(formatRupiah(nominal),
              style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}

class _InputNominal extends StatelessWidget {
  const _InputNominal({
    required this.label,
    required this.nilai,
    required this.onChanged,
  });

  final String label;
  final int? nilai;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue:
          nilai == null || nilai == 0 ? '' : formatRupiah(nilai!).substring(2),
      decoration: InputDecoration(labelText: label, prefixText: 'Rp'),
      keyboardType: TextInputType.number,
      inputFormatters: const [RupiahInputFormatter()],
      onChanged: (v) => onChanged(parseRupiah(v)),
    );
  }
}
