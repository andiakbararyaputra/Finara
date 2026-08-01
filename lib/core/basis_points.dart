/// Persentase disimpan sebagai basis points bulat agar pemeriksaan total 100%
/// bersifat eksak dan perhitungan tetap deterministik (10000 bp = 100%).
const int totalBasisPoints = 10000;

/// Mengalikan nominal dengan basis points, dibulatkan ke bawah (floor).
/// Sesuai aturan pembulatan: komponen non-residual tidak boleh melebihi target.
int applyBasisPoints(int amount, int basisPoints) {
  assert(amount >= 0, 'Nominal tidak boleh negatif');
  assert(basisPoints >= 0, 'Basis points tidak boleh negatif');
  return (amount * basisPoints) ~/ totalBasisPoints;
}

/// Benar hanya jika seluruh bagian berjumlah tepat 100%.
bool isFullAllocation(Iterable<int> basisPointParts) {
  return basisPointParts.fold<int>(0, (sum, part) => sum + part) ==
      totalBasisPoints;
}

/// Label persen untuk UI, memakai koma desimal sesuai format Indonesia.
/// Contoh: 4000 -> "40%", 4050 -> "40,5%", 4055 -> "40,55%".
String formatBasisPoints(int basisPoints) {
  final whole = basisPoints ~/ 100;
  final fraction = basisPoints % 100;
  if (fraction == 0) {
    return '$whole%';
  }
  if (fraction % 10 == 0) {
    return '$whole,${fraction ~/ 10}%';
  }
  return '$whole,${fraction.toString().padLeft(2, '0')}%';
}
