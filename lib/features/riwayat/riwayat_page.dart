import 'package:flutter/material.dart';

import '../../design_system/widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navRiwayat)),
      body: EmptyState(
        icon: Icons.history_outlined,
        title: l10n.riwayatKosongJudul,
        message: l10n.riwayatKosongPesan,
      ),
    );
  }
}
