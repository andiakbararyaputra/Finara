import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/amount_text.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../design_system/widgets/layout_widgets.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/models/allocation_preset.dart';
import '../../l10n/app_localizations.dart';
import 'hitung_controller.dart';

/// Alur Hitung 3 langkah: Pendapatan → Pengeluaran Wajib → Pembagian.
class HitungPage extends ConsumerStatefulWidget {
  const HitungPage({super.key});

  @override
  ConsumerState<HitungPage> createState() => _HitungPageState();
}

class _HitungPageState extends ConsumerState<HitungPage> {
  int _langkah = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(hitungControllerProvider);

    final judulLangkah = [
      l10n.langkahPendapatan,
      l10n.langkahPengeluaran,
      l10n.langkahPembagian,
    ];

    final bolehLanjut = switch (_langkah) {
      0 => state.pendapatanValid,
      1 => state.pendapatanValid,
      _ => state.siapHitung,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.navHitung} — ${judulLangkah[_langkah]}'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(FinaraSpacing.lg,
                    FinaraSpacing.md, FinaraSpacing.lg, FinaraSpacing.sm),
                child: LinearProgressIndicator(
                  value: (_langkah + 1) / 3,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                  semanticsLabel: judulLangkah[_langkah],
                ),
              ),
              Expanded(
                child: switch (_langkah) {
                  0 => _LangkahPendapatan(state: state),
                  1 => _LangkahPengeluaran(state: state),
                  _ => _LangkahPembagian(state: state),
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StickyActionBar(
        child: Row(
          children: [
            if (_langkah > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _langkah--),
                  child: Text(l10n.kembali),
                ),
              ),
            if (_langkah > 0) const SizedBox(width: FinaraSpacing.md),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: bolehLanjut
                    ? () {
                        if (_langkah < 2) {
                          setState(() => _langkah++);
                        } else {
                          unawaited(_hitung(context));
                        }
                      }
                    : null,
                child: Text(_langkah < 2 ? l10n.lanjut : l10n.hitung),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _hitung(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    // Langganan aktif dari DB ikut diperhitungkan (§14–§15).
    final tersimpan =
        await ref.read(subscriptionRepositoryProvider).semua(hanyaAktif: true);
    final langganan = [
      for (final s in tersimpan)
        SubscriptionInput(
          id: '${s.id}',
          nama: s.nama,
          siklus: s.siklus,
          nominal: s.nominal,
          bulanTagihan: s.bulanTagihan,
          metodeTahunan: s.metodeTahunan,
          sumberAnggaran: s.sumberAnggaran,
          saldoCadanganAwal: s.saldoCadangan,
        ),
    ];
    final (args, :diblokirLangganan) = ref
        .read(hitungControllerProvider.notifier)
        .hitung(langganan: langganan);
    if (!context.mounted) return;
    if (args == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(diblokirLangganan
            ? l10n.langgananMelebihiAlokasi
            : l10n.terjadiKesalahan),
      ));
      return;
    }
    unawaited(context.push(FinaraRoutes.hasil, extra: args));
  }
}

class _LangkahPendapatan extends ConsumerWidget {
  const _LangkahPendapatan({required this.state});

  final HitungState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = ref.read(hitungControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(FinaraSpacing.lg),
      children: [
        _InputRupiah(
          label: l10n.penghasilanUtama,
          nilaiAwal: state.penghasilanUtama,
          helper: l10n.descPenghasilanUtama,
          errorText: state.penghasilanUtama != null &&
                  (state.penghasilanUtama ?? 0) <= 0
              ? l10n.penghasilanUtamaWajib
              : null,
          onChanged: ctrl.setPenghasilanUtama,
        ),
        const SizedBox(height: FinaraSpacing.lg),
        _InputRupiah(
          label: l10n.kasPeganganBrimo,
          nilaiAwal: state.kasPeganganBrimo,
          helper: l10n.descKasPegangan,
          onChanged: (v) => ctrl.setKasPegangan(v ?? 0),
        ),
        const SizedBox(height: FinaraSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(l10n.penghasilanTambahan,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            TextButton.icon(
              onPressed: () => _dialogTambahPenghasilan(context, ctrl),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.tambahPenghasilan),
            ),
          ],
        ),
        Text(l10n.descPenghasilanTambahan,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: FinaraSpacing.sm),
        for (var i = 0; i < state.penghasilanTambahan.length; i++)
          _ItemTile(
            nama: state.penghasilanTambahan[i].nama,
            nominal: state.penghasilanTambahan[i].nominal,
            subtitle: state.penghasilanTambahan[i].disertakanBulanAktif
                ? l10n.disertakanBulanIni
                : l10n.tidakTersedia,
            onHapus: () => ctrl.hapusPenghasilan(i),
          ),
        const SizedBox(height: FinaraSpacing.lg),
        FinaraCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.totalPendapatan),
              AmountText(state.totalPendapatan,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _dialogTambahPenghasilan(
    BuildContext context,
    HitungController ctrl,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final namaCtrl = TextEditingController();
    final nominalCtrl = TextEditingController();
    var disertakan = true;

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.tambahPenghasilan),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaCtrl,
                decoration: InputDecoration(labelText: l10n.namaItem),
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: FinaraSpacing.md),
              TextField(
                controller: nominalCtrl,
                decoration: InputDecoration(
                    labelText: l10n.nominal, prefixText: 'Rp'),
                keyboardType: TextInputType.number,
                inputFormatters: const [RupiahInputFormatter()],
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.disertakanBulanIni),
                value: disertakan,
                onChanged: (v) => setState(() => disertakan = v),
              ),
            ],
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
      ),
    );

    if (simpan == true) {
      final nominal = parseRupiah(nominalCtrl.text) ?? 0;
      if (namaCtrl.text.trim().isNotEmpty && nominal > 0) {
        ctrl.tambahPenghasilan(IncomeSourceInput(
          nama: namaCtrl.text.trim(),
          nominal: nominal,
          disertakanBulanAktif: disertakan,
        ));
      }
    }
  }
}

class _LangkahPengeluaran extends ConsumerWidget {
  const _LangkahPengeluaran({required this.state});

  final HitungState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ctrl = ref.read(hitungControllerProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(FinaraSpacing.lg),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(l10n.pengeluaranWajib,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            TextButton.icon(
              onPressed: () => _dialogTambahPengeluaran(context, ctrl),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.tambahPengeluaran),
            ),
          ],
        ),
        Text(l10n.descPengeluaranWajib,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: FinaraSpacing.sm),
        for (var i = 0; i < state.pengeluaranWajib.length; i++)
          _ItemTile(
            nama: state.pengeluaranWajib[i].nama,
            nominal: state.pengeluaranWajib[i].nominal,
            subtitle: _labelKanal(l10n, state.pengeluaranWajib[i].kanalPembayaran),
            onHapus: () => ctrl.hapusPengeluaran(i),
          ),
        const SizedBox(height: FinaraSpacing.lg),
        FinaraCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.totalPengeluaranWajib),
              AmountText(state.totalPengeluaranWajib,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _dialogTambahPengeluaran(
    BuildContext context,
    HitungController ctrl,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final namaCtrl = TextEditingController();
    final nominalCtrl = TextEditingController();
    var kanal = PaymentChannel.bankJago;
    var dasarDarurat = false;

    final simpan = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.tambahPengeluaran),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaCtrl,
                  decoration: InputDecoration(labelText: l10n.namaItem),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: FinaraSpacing.md),
                TextField(
                  controller: nominalCtrl,
                  decoration: InputDecoration(
                      labelText: l10n.nominal, prefixText: 'Rp'),
                  keyboardType: TextInputType.number,
                  inputFormatters: const [RupiahInputFormatter()],
                ),
                const SizedBox(height: FinaraSpacing.md),
                DropdownButtonFormField<PaymentChannel>(
                  initialValue: kanal,
                  decoration:
                      InputDecoration(labelText: l10n.kanalPembayaran),
                  items: [
                    for (final k in PaymentChannel.values)
                      DropdownMenuItem(
                          value: k, child: Text(_labelKanal(l10n, k))),
                  ],
                  onChanged: (v) =>
                      setState(() => kanal = v ?? PaymentChannel.bankJago),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.dasarDanaDarurat),
                  value: dasarDarurat,
                  onChanged: (v) => setState(() => dasarDarurat = v),
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
      ),
    );

    if (simpan == true) {
      final nominal = parseRupiah(nominalCtrl.text) ?? 0;
      if (namaCtrl.text.trim().isNotEmpty && nominal > 0) {
        ctrl.tambahPengeluaran(MandatoryExpenseInput(
          nama: namaCtrl.text.trim(),
          nominal: nominal,
          kanalPembayaran: kanal,
          dihitungDasarDanaDarurat: dasarDarurat,
        ));
      }
    }
  }
}

class _LangkahPembagian extends ConsumerWidget {
  const _LangkahPembagian({required this.state});

  final HitungState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final ctrl = ref.read(hitungControllerProvider.notifier);

    final labelPreset = {
      AllocationPreset.standardHybrid: l10n.presetStandardHybrid,
      AllocationPreset.investorFokus: l10n.presetInvestorFokus,
      AllocationPreset.pelajar: l10n.presetPelajar,
      AllocationPreset.konservatif: l10n.presetKonservatif,
    };

    final totalUtamaBp = state.jagoBp + state.investasiBp + state.danaBp;
    final totalInvestasiBp = state.bibitBp + state.stockbitBp;

    return ListView(
      padding: const EdgeInsets.all(FinaraSpacing.lg),
      children: [
        Text(l10n.pilihPreset, style: theme.textTheme.titleMedium),
        const SizedBox(height: FinaraSpacing.xs),
        Text(l10n.descPilihPreset,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: FinaraSpacing.sm),
        Wrap(
          spacing: FinaraSpacing.sm,
          runSpacing: FinaraSpacing.sm,
          children: [
            for (final p in AllocationPreset.values)
              ChoiceChip(
                label: Text(labelPreset[p]!),
                selected: state.preset == p,
                onSelected: (_) => ctrl.pilihPreset(p),
              ),
            ChoiceChip(
              label: Text(l10n.presetCustom),
              selected: state.preset == null,
              onSelected: (_) => ctrl.setCustomUtama(),
            ),
          ],
        ),
        const SizedBox(height: FinaraSpacing.lg),
        _BarisPersen(
          label: l10n.bagianJago,
          bp: state.jagoBp,
          custom: state.preset == null,
          onChanged: (bp) => ctrl.setCustomUtama(jagoBp: bp),
        ),
        _BarisPersen(
          label: l10n.bagianInvestasi,
          bp: state.investasiBp,
          custom: state.preset == null,
          onChanged: (bp) => ctrl.setCustomUtama(investasiBp: bp),
        ),
        _BarisPersen(
          label: l10n.bagianDana,
          bp: state.danaBp,
          custom: state.preset == null,
          onChanged: (bp) => ctrl.setCustomUtama(danaBp: bp),
        ),
        _IndikatorTotal(
          totalBp: totalUtamaBp,
          valid: state.persentaseUtamaValid,
        ),
        const Divider(height: FinaraSpacing.xxl),
        Text(l10n.kartuInvestasi, style: theme.textTheme.titleMedium),
        const SizedBox(height: FinaraSpacing.xs),
        Text(l10n.descKartuInvestasi,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: FinaraSpacing.sm),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.aktifkanStockbit),
          value: state.stockbitAktif,
          onChanged: (v) => ctrl.setStockbitAktif(aktif: v),
        ),
        if (!state.stockbitAktif)
          Text(l10n.stockbitNonaktifInfo,
              style: theme.textTheme.bodySmall)
        else ...[
          _BarisPersen(
            label: l10n.bagianBibit,
            bp: state.bibitBp,
            custom: state.preset == null,
            onChanged: (bp) => ctrl.setCustomInvestasi(bibitBp: bp),
          ),
          _BarisPersen(
            label: l10n.bagianStockbit,
            bp: state.stockbitBp,
            custom: state.preset == null,
            onChanged: (bp) => ctrl.setCustomInvestasi(stockbitBp: bp),
          ),
          if (state.investasiBp > 0)
            _IndikatorTotal(
              totalBp: totalInvestasiBp,
              valid: state.persentaseInvestasiValid,
            ),
        ],
        const Divider(height: FinaraSpacing.xxl),
        DropdownButtonFormField<JagoSubAllocationMethod>(
          initialValue: state.metodeSubJago,
          decoration: InputDecoration(
            labelText: l10n.metodeSubJago,
            helperText: l10n.descMetodeSubJago,
            helperMaxLines: 3,
          ),
          items: [
            DropdownMenuItem(
                value: JagoSubAllocationMethod.persentaseTetap,
                child: Text(l10n.subJagoPersentaseTetap)),
            DropdownMenuItem(
                value: JagoSubAllocationMethod.berdasarkanLangganan,
                child: Text(l10n.subJagoBerdasarkanLangganan)),
          ],
          onChanged: (v) => ctrl.setMetodeSubJago(
              v ?? JagoSubAllocationMethod.persentaseTetap),
        ),
        const SizedBox(height: FinaraSpacing.lg),
        DropdownButtonFormField<RoundingOption>(
          initialValue: state.pembulatan,
          decoration: InputDecoration(
            labelText: l10n.pembulatan,
            helperText: l10n.descPembulatan,
            helperMaxLines: 3,
          ),
          items: [
            DropdownMenuItem(
                value: RoundingOption.tanpa, child: Text(l10n.pembulatanTanpa)),
            DropdownMenuItem(
                value: RoundingOption.seribu,
                child: Text(l10n.pembulatanSeribu)),
            DropdownMenuItem(
                value: RoundingOption.limaRibu,
                child: Text(l10n.pembulatanLimaRibu)),
            DropdownMenuItem(
                value: RoundingOption.sepuluhRibu,
                child: Text(l10n.pembulatanSepuluhRibu)),
          ],
          onChanged: (v) => ctrl.setPembulatan(v ?? RoundingOption.tanpa),
        ),
        const SizedBox(height: FinaraSpacing.lg),
        DropdownButtonFormField<DanaTopUpFrequency>(
          initialValue: state.frekuensiTopUpDana,
          decoration: InputDecoration(
            labelText: l10n.frekuensiTopUpDana,
            helperText: l10n.descFrekuensiDana,
            helperMaxLines: 3,
          ),
          items: [
            DropdownMenuItem(
                value: DanaTopUpFrequency.harian,
                child: Text(l10n.frekuensiHarian)),
            DropdownMenuItem(
                value: DanaTopUpFrequency.mingguan,
                child: Text(l10n.frekuensiMingguan)),
            DropdownMenuItem(
                value: DanaTopUpFrequency.sekaligus,
                child: Text(l10n.frekuensiSekaligus)),
          ],
          onChanged: (v) =>
              ctrl.setFrekuensiDana(v ?? DanaTopUpFrequency.mingguan),
        ),
        const SizedBox(height: FinaraSpacing.xxl),
      ],
    );
  }
}

class _BarisPersen extends StatelessWidget {
  const _BarisPersen({
    required this.label,
    required this.bp,
    required this.custom,
    required this.onChanged,
  });

  final String label;
  final int bp;
  final bool custom;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FinaraSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          if (custom)
            SizedBox(
              width: 88,
              child: TextFormField(
                initialValue: (bp ~/ 100).toString(),
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: const InputDecoration(
                  suffixText: '%',
                  isDense: true,
                ),
                onChanged: (v) => onChanged((int.tryParse(v) ?? 0) * 100),
              ),
            )
          else
            Text(
              formatBasisPoints(bp),
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }
}

class _IndikatorTotal extends StatelessWidget {
  const _IndikatorTotal({required this.totalBp, required this.valid});

  final int totalBp;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final warna = valid ? scheme.primary : scheme.error;
    return Padding(
      padding: const EdgeInsets.only(top: FinaraSpacing.xs),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle_rounded : Icons.error_rounded,
            size: 18,
            color: warna,
          ),
          const SizedBox(width: FinaraSpacing.xs),
          Text(
            l10n.totalPersen(formatBasisPoints(totalBp)),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: warna, fontWeight: FontWeight.w600),
          ),
          if (!valid) ...[
            const SizedBox(width: FinaraSpacing.sm),
            Expanded(
              child: Text(
                l10n.wajibSeratusPersen,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: warna),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InputRupiah extends StatelessWidget {
  const _InputRupiah({
    required this.label,
    required this.onChanged,
    this.nilaiAwal,
    this.errorText,
    this.helper,
  });

  final String label;
  final int? nilaiAwal;
  final String? errorText;
  final String? helper;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: nilaiAwal == null ? '' : formatRupiah(nilaiAwal!).substring(2),
      decoration: InputDecoration(
        labelText: label,
        prefixText: 'Rp',
        errorText: errorText,
        helperText: helper,
        helperMaxLines: 3,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: const [RupiahInputFormatter()],
      onChanged: (v) => onChanged(parseRupiah(v)),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.nama,
    required this.nominal,
    required this.subtitle,
    required this.onHapus,
  });

  final String nama;
  final int nominal;
  final String subtitle;
  final VoidCallback onHapus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(nama),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AmountText(nominal,
              style: Theme.of(context).textTheme.titleMedium),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: l10n.hapus,
            onPressed: onHapus,
          ),
        ],
      ),
    );
  }
}

String _labelKanal(AppLocalizations l10n, PaymentChannel kanal) {
  return switch (kanal) {
    PaymentChannel.bankJago => l10n.kanalBankJago,
    PaymentChannel.dana => l10n.kanalDana,
    PaymentChannel.tunai => l10n.kanalTunai,
    PaymentChannel.transferBankLain => l10n.kanalBankLain,
    PaymentChannel.lainnya => l10n.kanalLainnya,
  };
}
