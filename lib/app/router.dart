import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/beranda/beranda_page.dart';
import '../features/hitung/hasil_page.dart';
import '../features/hitung/hitung_controller.dart';
import '../features/hitung/hitung_page.dart';
import '../features/keamanan/lock_page.dart';
import '../features/langganan/langganan_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/onboarding/splash_page.dart';
import '../features/pengaturan/pengaturan_page.dart';
import '../features/progres/progres_page.dart';
import '../features/riwayat/riwayat_detail_page.dart';
import '../features/riwayat/riwayat_page.dart';
import '../features/shell/main_shell.dart';
import 'phase_config.dart';

abstract final class FinaraRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String beranda = '/';
  static const String hitung = '/hitung';
  static const String hasil = '/hasil';
  static const String finaraAi = '/ai';
  static const String progres = '/progres';
  static const String riwayat = '/riwayat';
  static const String pengaturan = '/pengaturan';
  static const String langganan = '/langganan';
  static const String kunci = '/kunci';
}

final routerProvider = Provider<GoRouter>((ref) {
  // Fase aktif menentukan cabang navigasi; cabang Finara AI baru
  // ditambahkan di sini saat Fase 2 dirilis.
  ref.watch(appPhaseProvider);

  return GoRouter(
    initialLocation: FinaraRoutes.splash,
    routes: [
      GoRoute(
        path: FinaraRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: FinaraRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: FinaraRoutes.hasil,
        builder: (context, state) =>
            HasilPage(args: state.extra! as HasilArgs),
      ),
      GoRoute(
        path: FinaraRoutes.pengaturan,
        builder: (context, state) => const PengaturanPage(),
      ),
      GoRoute(
        path: FinaraRoutes.langganan,
        builder: (context, state) => const LanggananPage(),
      ),
      GoRoute(
        path: FinaraRoutes.kunci,
        builder: (context, state) => const LockPage(),
      ),
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
                routes: [
                  GoRoute(
                    path: ':revisiId',
                    builder: (context, state) => RiwayatDetailPage(
                      revisiId:
                          int.parse(state.pathParameters['revisiId']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
