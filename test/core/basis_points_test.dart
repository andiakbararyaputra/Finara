import 'package:finara/core/basis_points.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('applyBasisPoints', () {
    test('menghitung persentase dasar', () {
      expect(applyBasisPoints(1000000, 4000), 400000);
      expect(applyBasisPoints(1000000, 3000), 300000);
      expect(applyBasisPoints(1000000, 10000), 1000000);
      expect(applyBasisPoints(1000000, 0), 0);
    });

    test('membulatkan ke bawah (floor), tidak pernah melebihi target', () {
      // 1001 * 3333 / 10000 = 333,63... -> 333
      expect(applyBasisPoints(1001, 3333), 333);
      // 999 * 5000 / 10000 = 499,5 -> 499
      expect(applyBasisPoints(999, 5000), 499);
    });

    test('jumlah bagian floor tidak pernah melebihi nominal awal', () {
      const amount = 987654;
      const parts = [4000, 3000, 3000];
      final total = parts
          .map((bp) => applyBasisPoints(amount, bp))
          .fold<int>(0, (a, b) => a + b);
      expect(total <= amount, isTrue);
    });
  });

  group('isFullAllocation', () {
    test('benar hanya saat total tepat 100%', () {
      expect(isFullAllocation([4000, 3000, 3000]), isTrue);
      expect(isFullAllocation([10000]), isTrue);
      expect(isFullAllocation([5000, 4999]), isFalse);
      expect(isFullAllocation([5000, 5001]), isFalse);
      expect(isFullAllocation([]), isFalse);
    });
  });

  group('formatBasisPoints', () {
    test('persen bulat tanpa desimal', () {
      expect(formatBasisPoints(4000), '40%');
      expect(formatBasisPoints(10000), '100%');
      expect(formatBasisPoints(0), '0%');
    });

    test('desimal memakai koma sesuai format Indonesia', () {
      expect(formatBasisPoints(4050), '40,5%');
      expect(formatBasisPoints(4055), '40,55%');
      expect(formatBasisPoints(4005), '40,05%');
    });
  });
}
