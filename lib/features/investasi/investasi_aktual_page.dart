import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/data_providers.dart';
import '../../app/providers.dart';
import '../../core/money.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../domain/models/finance_enums.dart';
import '../../l10n/app_localizations.dart';

/// Form input aktual manual per platform (§116). Nilai kosong = null.
class InvestasiAktualPage extends ConsumerStatefulWidget {
  const InvestasiAktualPage({super.key});

  @override
  ConsumerState<InvestasiAktualPage> createState() =>
      _InvestasiAktualPageState();
}

class _InvestasiAktualPageState extends ConsumerState<InvestasiAktualPage> {
  InvestmentPlatform _platform = InvestmentPlatform.stockbit;
  final _ctrl = <String, TextEditingController>{};
  bool _terverifikasi = false;
  bool _dimuat = false;

  static const _fieldStockbit = [
    'depositEksternal',
    'penarikan',
    'pembelianBersih',
    'penjualanBersih',
    'saldoRdnAwal',
    'saldoRdnAkhir',
    'biaya',
    'dividen',
    'nilaiPortofolio',
    'modalInvestasi',
  ];
  static const _fieldBibit = [
    'pembelianBersih',
    'penjualanBersih',
    'dividen',
    'nilaiPortofolio',
    'modalInvestasi',
  ];

  TextEditingController _c(String kunci) =>
      _ctrl.putIfAbsent(kunci, TextEditingController.new);

  @override
  void dispose() {
    for (final c in _ctrl.values) {
      c.dispose();
    }
    super.dispose();
  }

  String _label(AppLocalizations l10n, String kunci) => switch (kunci) {
        'depositEksternal' => l10n.depositEksternal,
        'penarikan' => l10n.penarikanRdn,
        'pembelianBersih' => l10n.pembelianBersih,
        'penjualanBersih' => l10n.penjualanBersih,
        'saldoRdnAwal' => l10n.saldoRdnAwal,
        'saldoRdnAkhir' => l10n.saldoRdnAkhir,
        'biaya' => l10n.biayaTransaksi,
        'dividen' => l10n.dividen,
        'nilaiPortofolio' => l10n.nilaiPortofolio,
        _ => l10n.modalInvestasi,
      };

  void _muatDariDb() {
    final row = ref
        .read(aktualInvestasiBulanIniProvider(_platform))
        .value;
    for (final c in _ctrl.values) {
      c.clear();
    }
    _terverifikasi = false;
    if (row == null) return;
    final nilai = <String, int?>{
      'depositEksternal': row.depositEksternal,
      'penarikan': row.penarikan,
      'pembelianBersih': row.pembelianBersih,
      'penjualanBersih': row.penjualanBersih,
      'saldoRdnAwal': row.saldoRdnAwal,
      'saldoRdnAkhir': row.saldoRdnAkhir,
      'biaya': row.biaya,
      'dividen': row.dividen,
      'nilaiPortofolio': row.nilaiPortofolio,
      'modalInvestasi': row.modalInvestasi,
    };
    nilai.forEach((k, v) {
      if (v != null) _c(k).text = formatRupiah(v).substring(2);
    });
    _terverifikasi = row.verifikasi == VerificationStatus.terverifikasi;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final fields = _platform == InvestmentPlatform.stockbit
        ? _fieldStockbit
        : _fieldBibit;

    // Prefill sekali setelah data bulan aktif termuat.
    ref.listen(aktualInvestasiBulanIniProvider(_platform), (_, next) {
      if (!_dimuat && next.hasValue) {
        _dimuat = true;
        setState(_muatDariDb);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.catatInvestasiAktual)),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(FinaraSpacing.lg),
            children: [
              DropdownButtonFormField<InvestmentPlatform>(
                initialValue: _platform,
                decoration:
                    InputDecoration(labelText: l10n.platformLabel),
                items: [
                  DropdownMenuItem(
                      value: InvestmentPlatform.bibit,
                      child: Text(l10n.bagianBibit)),
                  DropdownMenuItem(
                      value: InvestmentPlatform.stockbit,
                      child: Text(l10n.bagianStockbit)),
                ],
                onChanged: (v) => setState(() {
                  _platform = v ?? InvestmentPlatform.stockbit;
                  _dimuat = false;
                }),
              ),
              const SizedBox(height: FinaraSpacing.sm),
              Text(l10n.dimasukkanManual, style: theme.textTheme.bodySmall),
              const SizedBox(height: FinaraSpacing.md),
              for (final f in fields)
                Padding(
                  padding: const EdgeInsets.only(bottom: FinaraSpacing.md),
                  child: TextField(
                    controller: _c(f),
                    decoration: InputDecoration(
                        labelText: _label(l10n, f),
                        prefixText: 'Rp',
                        isDense: true),
                    keyboardType: TextInputType.number,
                    inputFormatters: const [RupiahInputFormatter()],
                  ),
                ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.tandaiTerverifikasi),
                value: _terverifikasi,
                onChanged: (v) => setState(() => _terverifikasi = v),
              ),
              const SizedBox(height: FinaraSpacing.lg),
              FilledButton(onPressed: _simpan, child: Text(l10n.simpan)),
              const SizedBox(height: FinaraSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _simpan() async {
    int? nilai(String k) =>
        _ctrl.containsKey(k) ? parseRupiah(_ctrl[k]!.text) : null;
    final kini = DateTime.now();
    await ref.read(investmentActualRepositoryProvider).simpan(
          platform: _platform,
          tahun: kini.year,
          bulan: kini.month,
          depositEksternal: nilai('depositEksternal'),
          penarikan: nilai('penarikan'),
          pembelianBersih: nilai('pembelianBersih'),
          penjualanBersih: nilai('penjualanBersih'),
          saldoRdnAwal: nilai('saldoRdnAwal'),
          saldoRdnAkhir: nilai('saldoRdnAkhir'),
          biaya: nilai('biaya'),
          dividen: nilai('dividen'),
          nilaiPortofolio: nilai('nilaiPortofolio'),
          modalInvestasi: nilai('modalInvestasi'),
          verifikasi: _terverifikasi
              ? VerificationStatus.terverifikasi
              : VerificationStatus.belumDiverifikasi,
        );
    ref
      ..invalidate(aktualInvestasiBulanIniProvider)
      ..invalidate(rekonsiliasiStockbitProvider)
      ..invalidate(kontribusiGabunganProvider)
      ..invalidate(skorKesehatanProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.tersimpanKeRiwayat)));
  }
}
