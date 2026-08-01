/// Preset alokasi dua tingkat (§13): pembagian Dana Bersih + pembagian
/// internal Total Alokasi Investasi. Preset adalah alat perencanaan,
/// bukan rekomendasi aset.
library;

enum AllocationPreset {
  standardHybrid(
    jagoBp: 4000,
    investasiBp: 3000,
    danaBp: 3000,
    bibitBp: 7000,
    stockbitBp: 3000,
  ),
  investorFokus(
    jagoBp: 2500,
    investasiBp: 5000,
    danaBp: 2500,
    bibitBp: 5000,
    stockbitBp: 5000,
  ),
  pelajar(
    jagoBp: 4500,
    investasiBp: 1500,
    danaBp: 4000,
    bibitBp: 8000,
    stockbitBp: 2000,
  ),
  konservatif(
    jagoBp: 6000,
    investasiBp: 2000,
    danaBp: 2000,
    bibitBp: 8500,
    stockbitBp: 1500,
  );

  const AllocationPreset({
    required this.jagoBp,
    required this.investasiBp,
    required this.danaBp,
    required this.bibitBp,
    required this.stockbitBp,
  });

  final int jagoBp;
  final int investasiBp;
  final int danaBp;
  final int bibitBp;
  final int stockbitBp;
}
