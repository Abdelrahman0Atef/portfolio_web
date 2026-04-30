import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Theme + typography helpers for the portfolio.
class AppTheme {
  AppTheme._();

  static TextStyle display({
    double size = 48,
    FontWeight weight = FontWeight.w600,
    Color? color,
    double letterSpacing = -0.6,
    double height = 1.08,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.plusJakartaSans(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
        fontStyle: fontStyle,
      );

  static TextStyle body({
    double size = 15,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double letterSpacing = 0,
    double height = 1.55,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle mono({
    double size = 11,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double letterSpacing = 1.4,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// Signature-style script — used for the "Atef" word in the hero.
  static TextStyle script({
    double size = 64,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double letterSpacing = 0,
    double height = 1.0,
  }) =>
      GoogleFonts.caveat(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.ink,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.ink,
        surfaceContainerHighest: AppColors.inkRaised,
        primary: AppColors.accent,
        onPrimary: AppColors.accentInk,
        secondary: AppColors.accent,
        onSurface: AppColors.textPrimary,
        outline: AppColors.stroke,
        error: AppColors.danger,
      ),
      textTheme: _textTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.ink.withValues(alpha: 0.85),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.inkSoft,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.stroke,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      splashColor: AppColors.accent.withValues(alpha: 0.06),
      highlightColor: AppColors.accent.withValues(alpha: 0.04),
      hoverColor: AppColors.accent.withValues(alpha: 0.04),
    );
  }

  static TextTheme _textTheme() {
    return TextTheme(
      displayLarge: display(
          size: 56,
          weight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -1.2),
      displayMedium: display(
          size: 40,
          weight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.9),
      displaySmall: display(
          size: 28,
          weight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.5),
      headlineMedium: display(
          size: 22,
          weight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.3),
      headlineSmall: display(
          size: 18,
          weight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.2),
      titleMedium:
          body(size: 15, weight: FontWeight.w600, color: AppColors.textPrimary),
      bodyLarge: body(size: 16, color: AppColors.textPrimary),
      bodyMedium: body(size: 14, color: AppColors.textSecondary),
      bodySmall: body(size: 12.5, color: AppColors.textSecondary, height: 1.45),
      labelLarge:
          body(size: 14, weight: FontWeight.w600, color: AppColors.textPrimary),
      labelSmall: mono(size: 10.5, color: AppColors.textSecondary, letterSpacing: 1.6),
    );
  }
}
