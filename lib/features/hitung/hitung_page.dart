import 'package:flutter/material.dart';

import '../../design_system/widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';

class HitungPage extends StatelessWidget {
  const HitungPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHitung)),
      body: EmptyState(
        icon: Icons.calculate_outlined,
        title: l10n.hitungKosongJudul,
        message: l10n.hitungKosongPesan,
      ),
    );
  }
}
