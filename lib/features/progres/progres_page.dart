import 'package:flutter/material.dart';

import '../../design_system/widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';

class ProgresPage extends StatelessWidget {
  const ProgresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProgres)),
      body: EmptyState(
        icon: Icons.insights_outlined,
        title: l10n.progresKosongJudul,
        message: l10n.progresKosongPesan,
      ),
    );
  }
}
