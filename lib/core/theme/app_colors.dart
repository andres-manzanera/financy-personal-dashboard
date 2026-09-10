import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Light Mode ───
  static const Color lightBackground = Color(0xFFE4E5E2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F1D0);
  static const Color lightCardBorder = Color(0xFFE8E4C8);

  // ─── Dark Mode ───
  static const Color darkBackground = Color(0xFF343A40);
  static const Color darkSurface = Color(0xFF3E444A);
  static const Color darkSurfaceVariant = Color(0xFF4A5058);
  static const Color darkCardBorder = Color(0xFF565C62);

  // ─── Brand ───
  static const Color primary = Color(0xFF1B4332);
  static const Color primaryLight = Color(0xFF2D6A4F);
  static const Color secondary = Color(0xFF74C69D);
  static const Color secondaryLight = Color(0xFFA7DFC2);
  static const Color accent = Color(0xFFFFB703);
  static const Color accentLight = Color(0xFFFFCA3A);

  // ─── Semantic ───
  static const Color success = Color(0xFF38B000);
  static const Color successLight = Color(0xFF5CB85C);
  static const Color error = Color(0xFFEE6055);
  static const Color errorLight = Color(0xFFFF7B73);
  static const Color warning = Color(0xFF00A5CF);
  static const Color warningLight = Color(0xFF33B8D9);

  // ─── Text Light ───
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF6B6B6B);
  static const Color lightTextTertiary = Color(0xFF9E9E9E);

  // ─── Text Dark ───
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextTertiary = Color(0xFF808080);

  // ─── Category Colors ───
  static const Color categoryFood = Color(0xFFEE6055);
  static const Color categoryServices = Color(0xFF00A5CF);
  static const Color categoryLeisure = Color(0xFFFFB703);
  static const Color categoryHealth = Color(0xFF38B000);
  static const Color categoryTransport = Color(0xFF7B68EE);
  static const Color categoryShopping = Color(0xFFE67E22);

  // ─── Helpers ───
  static Color background(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  static Color surface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color surfaceVariant(bool isDark) =>
      isDark ? darkSurfaceVariant : lightSurfaceVariant;
  static Color cardBorder(bool isDark) =>
      isDark ? darkCardBorder : lightCardBorder;
  static Color textPrimary(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;
  static Color textSecondary(bool isDark) =>
      isDark ? darkTextSecondary : lightTextSecondary;
  static Color textTertiary(bool isDark) =>
      isDark ? darkTextTertiary : lightTextTertiary;
}
