import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/beranda/beranda_page.dart';
import '../features/dana_plus/dana_plus_page.dart';
import '../features/finara_ai/ai_config_page.dart';
import '../features/finara_ai/ai_page.dart';
import '../features/finara_ai/ai_provider_detail_page.dart';
import '../features/finara_ai/chat_page.dart';
import '../features/hitung/hasil_page.dart';
import '../features/hitung/hitung_controller.dart';
import '../features/hitung/hitung_page.dart';
import '../features/investasi/impor_bibit_page.dart';
import '../features/investasi/investasi_aktual_page.dart';
import '../features/keamanan/lock_page.dart';
import '../features/langganan/langganan_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/onboarding/splash_page.dart';
import '../features/pengaturan/pengaturan_page.dart';
import '../features/pengeluaran/catat_pengeluaran_page.dart';
import '../features/progres/progres_page.dart';
import '../features/riwayat/riwayat_detail_page.dart';
import '../features/riwayat/riwayat_page.dart';
import '../features/shell/main_shell.dart';
import '../features/simulasi/simulasi_page.dart';
import 'phase_config.dart';

abstract final class FinaraRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String beranda = '/';
  static const String hitung = '/hitung';
  static const String hasil = '/hasil';
  static const String finaraAi = '/ai';
  static const String aiPengaturan = '/ai-pengaturan';
  static const String aiProvider = '/ai-provider';
  static const String aiChat = '/ai-chat';
  static const String progres = '/progres';
  static const String riwayat = '/riwayat';
  static const String pengaturan = '/pengaturan';
  static const String langganan = '/langganan';
  static const String kunci = '/kunci';
  static const String simulasi = '/simulasi';
  static const String danaPlus = '/dana-plus';
  static const String investasiAktual = '/investasi-aktual';
  static const String imporBibit = '/impor-bibit';
  static const String catatPengeluaran = '/catat-pengeluaran';
}

final routerProvider = Provider<GoRouter>((ref) {
  // Fase aktif menentukan cabang navigasi (§8).
  final fase = ref.watch(appPhaseProvider);

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
      GoRoute(
        path: FinaraRoutes.simulasi,
        builder: (context, state) => const SimulasiPage(),
      ),
      GoRoute(
        path: FinaraRoutes.danaPlus,
        builder: (context, state) => const DanaPlusPage(),
      ),
      GoRoute(
        path: FinaraRoutes.investasiAktual,
        builder: (context, state) => const InvestasiAktualPage(),
      ),
      GoRoute(
        path: FinaraRoutes.imporBibit,
        builder: (context, state) => const ImporBibitPage(),
      ),
      GoRoute(
        path: FinaraRoutes.catatPengeluaran,
        builder: (context, state) => const CatatPengeluaranPage(),
      ),
      GoRoute(
        path: FinaraRoutes.aiPengaturan,
        builder: (context, state) => const AiConfigPage(),
      ),
      GoRoute(
        path: '${FinaraRoutes.aiProvider}/:id',
        builder: (context, state) => AiProviderDetailPage(
          providerId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${FinaraRoutes.aiChat}/:id',
        builder: (context, state) => ChatPage(
          conversationId: int.parse(state.pathParameters['id']!),
        ),
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
          if (fase.isAtLeast(AppPhase.fase2))
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: FinaraRoutes.finaraAi,
                  builder: (context, state) => const AiPage(),
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
