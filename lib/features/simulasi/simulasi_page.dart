import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data_providers.dart';
import '../../core/basis_points.dart';
import '../../core/money.dart';
import '../../data/db/app_database.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/finara_card.dart';
import '../../domain/models/allocation_input.dart';
import '../../domain/services/allocation_engine.dart';
import '../../domain/services/allocation_validator.dart';
import '../../l10n/app_localizations.dart';

/// Simulasi "Bagaimana Jika" (§25): sandbox murni — tidak menyentuh data
/// utama; baseline dimuat dari revisi aktif bila ada.
class SimulasiPage extends ConsumerStatefulWidget {
  const SimulasiPage({super.key});

  @override
  ConsumerState<SimulasiPage> createState() => _SimulasiPageState();
}

class _SimulasiPageState extends ConsumerState<SimulasiPage> {
  static const _engine = AllocationEngine();
  static const _validator = AllocationValidator();

  int _penghasilan = 10000000;
  int _kas = 300000;
  int _wajib = 0;
  int _jagoersen = 40;
  int _investasiPersen = 30;
  int _danaPersen = 30;
  int _bibitPersen = 70;
  int _stockbitPersen = 30;
  bool _dariBulanAktif = false;
  bool _dimuat = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Muat baseline sekali dari revisi aktif (§25).
    final revisi = ref.watch(revisiBulanAktifProvider).value;
    if (!_dimuat && revisi != null) {
      _dimuat = true;
      _dariBulanAktif = true;
      _penghasilan = revisi.penghasilanUtama;
      _kas = revisi.kasPeganganBrimo;
      _wajib = revisi.totalPengeluaranWajib;
      _jagoersenDariBp(revisi.jagoBp, revisi.investasiBp, revisi.danaBp,
          revisi.bibitBp, revisi.stockbitBp);
    }

    final hasilAwal = revisi;
    final hasilSimulasi = _hitungSimulasi();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.bagaimanaJika)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              Text(l10n.simulasiCatatan, style: theme.textTheme.bodySmall),
              if (_dariBulanAktif)
                Text(l10n.muatDariBulanAktif,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: FinaraSpacing.lg),
              _InputNominal(
                label: l10n.penghasilanUtama,
                nilai: _penghasilan,
                onChanged: (v) => setState(() => _penghasilan = v),
              ),
              const SizedBox(height: FinaraSpacing.md),
              _InputNominal(
                label: l10n.kasPeganganBrimo,
                nilai: _kas,
                onChanged: (v) => setState(() => _kas = v),
              ),
              const SizedBox(height: FinaraSpacing.md),
              _InputNominal(
                label: l10n.totalPengeluaranWajib,
                nilai: _wajib,
                onChanged: (v) => setState(() => _wajib = v),
              ),
              const SizedBox(height: FinaraSpacing.lg),
              _SliderPersen(
                label: l10n.bagianJago,
                nilai: _jagoersen,
                onChanged: (v) => setState(() {
                  _jagoersen = v;
                  _danaPersen = 100 - _jagoersen - _investasiPersen;
                }),
              ),
              _SliderPersen(
                label: l10n.bagianInvestasi,
                nilai: _investasiPersen,
                onChanged: (v) => setState(() {
                  _investasiPersen = v;
                  _danaPersen = 100 - _jagoersen - _investasiPersen;
                }),
              ),
              _SliderPersen(
                label: l10n.bagianDana,
                nilai: _danaPersen,
                aktif: false,
              ),
              const SizedBox(height: FinaraSpacing.sm),
              _SliderPersen(
                label: l10n.bagianBibit,
                nilai: _bibitPersen,
                onChanged: (v) => setState(() {
                  _bibitPersen = v;
                  _stockbitPersen = 100 - v;
                }),
              ),
              _SliderPersen(
                label: l10n.bagianStockbit,
                nilai: _stockbitPersen,
                aktif: false,
              ),
              const SizedBox(height: FinaraSpacing.lg),
              if (hasilSimulasi != null)
                _CardDampak(sebelum: hasilAwal, sesudah: hasilSimulasi)
              else
                FinaraCard(
                  child: Text(l10n.wajibSeratusPersen,
                      style: TextStyle(color: theme.colorScheme.error)),
                ),
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  // Konversi bp tersimpan ke slider persen (dibulatkan ke persen terdekat).
  void _jagoersenDariBp(
      int jagoBp, int investasiBp, int danaBp, int bibitBp, int stockbitBp) {
    _jagoersen = jagoBp ~/ 100;
    _investasiPersen = investasiBp ~/ 100;
    _danaPersen = 100 - _jagoersen - _investasiPersen;
    _bibitPersen = bibitBp ~/ 100;
    _stockbitPersen = 100 - _bibitPersen;
  }

  _HasilSimulasi? _hitungSimulasi() {
    if (_danaPersen < 0) return null;
    final kini = DateTime.now();
    final input = AllocationInput(
      tahun: kini.year,
      bulan: kini.month,
      penghasilanUtama: _penghasilan,
      kasPeganganBrimo: _kas,
      pengeluaranWajib: [
        if (_wajib > 0)
          MandatoryExpenseInput(nama: 'Total wajib', nominal: _wajib),
      ],
      jagoBp: _jagoersen * 100,
      investasiBp: _investasiPersen * 100,
      danaBp: _danaPersen * 100,
      bibitBp: _bibitPersen * 100,
      stockbitBp: _stockbitPersen * 100,
    );
    if (_validator.validasiInput(input).isNotEmpty) return null;
    final hasil = _engine.hitung(input);
    return _HasilSimulasi(
      danaBersih: hasil.danaBersih,
      investasiBulanan: hasil.totalAlokasiInvestasi,
      alokasiBibit: hasil.alokasiBibit,
      alokasiStockbit: hasil.alokasiStockbit,
      uangJajanHarian: hasil.jadwalDana.uangJajanHarianDasar,
      kontribusiDarurat: hasil.subAlokasiJago.danaDarurat,
    );
  }
}

class _HasilSimulasi {
  const _HasilSimulasi({
    required this.danaBersih,
    required this.investasiBulanan,
    required this.alokasiBibit,
    required this.alokasiStockbit,
    required this.uangJajanHarian,
    required this.kontribusiDarurat,
  });

  final int danaBersih;
  final int investasiBulanan;
  final int alokasiBibit;
  final int alokasiStockbit;
  final int uangJajanHarian;
  final int kontribusiDarurat;
}

class _CardDampak extends StatelessWidget {
  const _CardDampak({required this.sebelum, required this.sesudah});

  final MonthlyAllocationRevision? sebelum;
  final _HasilSimulasi sesudah;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    Widget baris(String label, int? nilaiSebelum, int nilaiSesudah) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
            if (nilaiSebelum != null) ...[
              Text(formatRupiah(nilaiSebelum),
                  style: theme.textTheme.bodySmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(width: FinaraSpacing.sm),
            ],
            Text(formatRupiah(nilaiSesudah),
                style: theme.textTheme.titleSmall),
          ],
        ),
      );
    }

    return FinaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${l10n.sebelum} → ${l10n.sesudah}',
              style: theme.textTheme.titleMedium),
          const SizedBox(height: FinaraSpacing.sm),
          baris(l10n.danaBersih, sebelum?.danaBersih, sesudah.danaBersih),
          baris(l10n.bagianInvestasi, sebelum?.totalAlokasiInvestasi,
              sesudah.investasiBulanan),
          baris(
              l10n.investasiPerTahun,
              sebelum == null ? null : sebelum!.totalAlokasiInvestasi * 12,
              sesudah.investasiBulanan * 12),
          baris(l10n.bagianBibit, sebelum?.alokasiBibit,
              sesudah.alokasiBibit),
          baris(l10n.bagianStockbit, sebelum?.alokasiStockbit,
              sesudah.alokasiStockbit),
          baris(l10n.anggaranHarianDasar, null, sesudah.uangJajanHarian),
          baris(l10n.kontribusiBulanIni, sebelum?.subJagoDanaDarurat,
              sesudah.kontribusiDarurat),
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
  final int nilai;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: formatRupiah(nilai).substring(2),
      decoration: InputDecoration(labelText: label, prefixText: 'Rp'),
      keyboardType: TextInputType.number,
      inputFormatters: const [RupiahInputFormatter()],
      onChanged: (v) => onChanged(parseRupiah(v) ?? 0),
    );
  }
}

class _SliderPersen extends StatelessWidget {
  const _SliderPersen({
    required this.label,
    required this.nilai,
    this.onChanged,
    this.aktif = true,
  });

  final String label;
  final int nilai;
  final ValueChanged<int>? onChanged;
  final bool aktif;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(width: 110, child: Text(label)),
        Expanded(
          child: Slider(
            value: nilai.clamp(0, 100).toDouble(),
            max: 100,
            divisions: 100,
            onChanged:
                aktif && onChanged != null ? (v) => onChanged!(v.round()) : null,
          ),
        ),
        SizedBox(
          width: 48,
          child: Text(
            formatBasisPoints(nilai * 100),
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
