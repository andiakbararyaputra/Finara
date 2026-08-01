import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/router.dart';
import '../../app/theme_mode_controller.dart';
import '../../design_system/tokens/finara_spacing.dart';
import '../../design_system/widgets/empty_state.dart';
import '../../l10n/app_localizations.dart';

class BerandaPage extends ConsumerWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bulanAktif = DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.appName),
            Text(
              bulanAktif,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.pengaturan,
            onPressed: () => _showThemeSheet(context, ref),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: FinaraSpacing.maxContentWidth),
          child: EmptyState(
            icon: Icons.account_balance_wallet_outlined,
            title: l10n.berandaKosongJudul,
            message: l10n.berandaKosongPesan,
            actionLabel: l10n.hitungAlokasi,
            onAction: () => context.go(FinaraRoutes.hitung),
          ),
        ),
      ),
    );
  }

  void _showThemeSheet(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, _) {
            final mode = ref.watch(themeModeProvider);
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: FinaraSpacing.xxl,
                      vertical: FinaraSpacing.sm,
                    ),
                    child: Text(
                      l10n.tema,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  _ThemeOption(
                    icon: Icons.brightness_auto_outlined,
                    label: l10n.temaSistem,
                    selected: mode == ThemeMode.system,
                    onTap: () => _selectMode(sheetContext, ref, ThemeMode.system),
                  ),
                  _ThemeOption(
                    icon: Icons.light_mode_outlined,
                    label: l10n.temaTerang,
                    selected: mode == ThemeMode.light,
                    onTap: () => _selectMode(sheetContext, ref, ThemeMode.light),
                  ),
                  _ThemeOption(
                    icon: Icons.dark_mode_outlined,
                    label: l10n.temaGelap,
                    selected: mode == ThemeMode.dark,
                    onTap: () => _selectMode(sheetContext, ref, ThemeMode.dark),
                  ),
                  const SizedBox(height: FinaraSpacing.sm),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _selectMode(BuildContext sheetContext, WidgetRef ref, ThemeMode mode) {
    ref.read(themeModeProvider.notifier).setMode(mode);
    Navigator.of(sheetContext).pop();
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check_rounded, color: scheme.primary)
          : null,
      selected: selected,
      onTap: onTap,
    );
  }
}
