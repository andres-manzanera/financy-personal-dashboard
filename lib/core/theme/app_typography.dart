import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle _outfit({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
    bool tabularFigures = false,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      fontFeatures: tabularFigures ? [const FontFeature.tabularFigures()] : null,
    );
  }

  // ─── Display ───
  static TextStyle displayLarge({Color? color}) => _outfit(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.1,
        tabularFigures: true,
      );

  static TextStyle displayMedium({Color? color}) => _outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.15,
        tabularFigures: true,
      );

  // ─── Headline ───
  static TextStyle headlineLarge({Color? color}) => _outfit(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
      );

  static TextStyle headlineMedium({Color? color}) => _outfit(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.25,
      );

  static TextStyle headlineSmall({Color? color}) => _outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
      );

  // ─── Title ───
  static TextStyle titleLarge({Color? color}) => _outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.35,
      );

  static TextStyle titleMedium({Color? color}) => _outfit(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      );

  static TextStyle titleSmall({Color? color}) => _outfit(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      );

  // ─── Body ───
  static TextStyle bodyLarge({Color? color}) => _outfit(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle bodyMedium({Color? color}) => _outfit(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle bodySmall({Color? color}) => _outfit(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  // ─── Label ───
  static TextStyle labelLarge({Color? color}) => _outfit(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.4,
      );

  static TextStyle labelMedium({Color? color}) => _outfit(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
      );

  static TextStyle labelSmall({Color? color}) => _outfit(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.4,
        letterSpacing: 0.5,
      );

  // ─── Amount (tabular figures for money alignment) ───
  static TextStyle amountLarge({Color? color}) => _outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.1,
        tabularFigures: true,
      );

  static TextStyle amountMedium({Color? color}) => _outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.2,
        tabularFigures: true,
      );

  static TextStyle amountSmall({Color? color}) => _outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1.3,
        tabularFigures: true,
      );

  static TextStyle amountTiny({Color? color}) => _outfit(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.3,
        tabularFigures: true,
      );
}
