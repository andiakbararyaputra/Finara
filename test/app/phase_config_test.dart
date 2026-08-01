import 'package:finara/app/phase_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPhase', () {
    test('urutan fase konsisten', () {
      expect(AppPhase.fase1.isAtLeast(AppPhase.fase1), isTrue);
      expect(AppPhase.fase2.isAtLeast(AppPhase.fase1), isTrue);
      expect(AppPhase.fase1.isAtLeast(AppPhase.fase2), isFalse);
      expect(AppPhase.fase4.isAtLeast(AppPhase.fase3), isTrue);
    });

    test('fase aktif build saat ini adalah Fase 1', () {
      expect(activeAppPhase, AppPhase.fase1);
    });
  });
}
