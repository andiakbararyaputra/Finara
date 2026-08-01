import 'package:flutter/material.dart';

import '../../core/money.dart';

/// Menampilkan nominal Rupiah dengan angka tabular dan label pembaca layar.
class AmountText extends StatelessWidget {
  const AmountText(
    this.amount, {
    super.key,
    this.style,
    this.color,
  });

  final int amount;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.headlineSmall!;
    return Text(
      formatRupiah(amount),
      style: base.copyWith(
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      semanticsLabel: '${formatRupiah(amount)} rupiah',
    );
  }
}
