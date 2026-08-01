import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/beranda/beranda_page.dart';
import '../features/hitung/hitung_page.dart';
import '../features/progres/progres_page.dart';
import '../features/riwayat/riwayat_page.dart';
import '../features/shell/main_shell.dart';
import 'phase_config.dart';

abstract final class FinaraRoutes {
  static const String beranda = '/';
  static const String hitung = '/hitung';
  static const String finaraAi = '/ai';
  static const String progres = '/progres';
  static const String riwayat = '/riwayat';
}

final routerProvider = Provider<GoRouter>((ref) {
  // Fase aktif menentukan cabang navigasi; cabang Finara AI baru
  // ditambahkan di sini saat Fase 2 dirilis.
  ref.watch(appPhaseProvider);

  return GoRouter(
    initialLocation: FinaraRoutes.beranda,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FinaraRoutes.beranda,
                builder: (context, state) => const BerandaPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FinaraRoutes.hitung,
                builder: (context, state) => const HitungPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FinaraRoutes.progres,
                builder: (context, state) => const ProgresPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FinaraRoutes.riwayat,
                builder: (context, state) => const RiwayatPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
