import 'package:flutter/material.dart';

/// Warna dasar merek Finara (Bagian II, sistem warna).
abstract final class FinaraColors {
  static const Color emerald = Color(0xFF059669);
  static const Color emeraldDark = Color(0xFF047857);
  static const Color mint = Color(0xFF6EE7B7);

  static const Color backgroundLight = Color(0xFFF7F9F8);
  static const Color backgroundDark = Color(0xFF101413);

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color info = Color(0xFF2563EB);

  // Warna platform: hanya untuk aksen card, bukan background halaman.
  static const Color brimo = Color(0xFF1E40AF);
  static const Color bankJago = Color(0xFFF97316);
  static const Color bibit = Color(0xFF16A34A);
  static const Color stockbit = Color(0xFF0D9488);
  static const Color dana = Color(0xFF0EA5E9);
}

/// Warna semantik dan aksen platform yang mengikuti tema aktif.
@immutable
class FinaraPalette extends ThemeExtension<FinaraPalette> {
  const FinaraPalette({
    required this.success,
    required this.warning,
    required this.info,
    required this.brimo,
    required this.bankJago,
    required this.bibit,
    required this.stockbit,
    required this.dana,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color brimo;
  final Color bankJago;
  final Color bibit;
  final Color stockbit;
  final Color dana;

  static const FinaraPalette light = FinaraPalette(
    success: FinaraColors.success,
    warning: FinaraColors.warning,
    info: FinaraColors.info,
    brimo: FinaraColors.brimo,
    bankJago: FinaraColors.bankJago,
    bibit: FinaraColors.bibit,
    stockbit: FinaraColors.stockbit,
    dana: FinaraColors.dana,
  );

  static const FinaraPalette dark = FinaraPalette(
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
    brimo: Color(0xFF60A5FA),
    bankJago: Color(0xFFFB923C),
    bibit: Color(0xFF4ADE80),
    stockbit: Color(0xFF2DD4BF),
    dana: Color(0xFF38BDF8),
  );

  @override
  FinaraPalette copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? brimo,
    Color? bankJago,
    Color? bibit,
    Color? stockbit,
    Color? dana,
  }) {
    return FinaraPalette(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      brimo: brimo ?? this.brimo,
      bankJago: bankJago ?? this.bankJago,
      bibit: bibit ?? this.bibit,
      stockbit: stockbit ?? this.stockbit,
      dana: dana ?? this.dana,
    );
  }

  @override
  FinaraPalette lerp(FinaraPalette? other, double t) {
    if (other == null) {
      return this;
    }
    return FinaraPalette(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      brimo: Color.lerp(brimo, other.brimo, t)!,
      bankJago: Color.lerp(bankJago, other.bankJago, t)!,
      bibit: Color.lerp(bibit, other.bibit, t)!,
      stockbit: Color.lerp(stockbit, other.stockbit, t)!,
      dana: Color.lerp(dana, other.dana, t)!,
    );
  }
}

extension FinaraPaletteX on ThemeData {
  FinaraPalette get palette => extension<FinaraPalette>() ?? FinaraPalette.light;
}
