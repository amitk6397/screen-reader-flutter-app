import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Semantic tokens (resolved at runtime) ──────────────────────
  static Color navy(BuildContext context) =>
      _t(context, dark: const Color(0xFF0F1724), light: const Color(0xFFF4F6FB));

  static Color navyMid(BuildContext context) =>
      _t(context, dark: const Color(0xFF1A2435), light: const Color(0xFFFFFFFF));

  static Color navyLight(BuildContext context) =>
      _t(context, dark: const Color(0xFF243047), light: const Color(0xFFE2E8F4));

  static Color textPrimary(BuildContext context) =>
      _t(context, dark: const Color(0xFFF0F4FF), light: const Color(0xFF0F1724));

  static Color textMuted(BuildContext context) =>
      _t(context, dark: const Color(0xFF6B7A9A), light: const Color(0xFF8896B0));

  // ── Static / always-same ───────────────────────────────────────
  static const Color accent     = Color(0xFFC8A96E);
  static const Color accentDim  = Color(0x22C8A96E);
  static const Color danger     = Color(0xFFE05C5C);
  static const Color info       = Color(0xFF5B9BF8);
  static const Color warning    = Color(0xFFF5A623);
  static const Color coverGreen = Color(0xFF4CAF7D);
  static const Color coverBlue  = Color(0xFF5B9BF8);
  static const Color coverPurple= Color(0xFF9B7FD4);
  static const Color coverTeal  = Color(0xFF4DB6AC);

  // ── Helper ─────────────────────────────────────────────────────
  static Color _t(BuildContext ctx,
      {required Color dark, required Color light}) {
    final brightness = Theme.of(ctx).brightness;
    return brightness == Brightness.dark ? dark : light;
  }

  // Core Background
  // static const Color navy = Color(0xFF0D1B2A);
  // static const Color navyMid = Color(0xFF1A2E42);
  // static const Color navyLight = Color(0xFF243B55);
  static const Color navyHover = Color(0xFF2E4A6A);

  // Accent
  // static const Color accent = Color(0xFF4ECDC4);
  // static const Color accentDim = Color(0x264ECDC4);
  static const Color accentBorder = Color(0x404ECDC4);
  static const Color accent2 = Color(0xFFFFD166);
  static const Color accent2Dim = Color(0x26FFD166);

  // Text
  //static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFC8D6E5);
  //static const Color textMuted = Color(0xFF8A9BAE);
  static const Color textDisabled = Color(0xFF4A5E72);

  // Semantic
  static const Color success = Color(0xFF1D9E75);
  static const Color successDim = Color(0x261D9E75);
  // static const Color warning = Color(0xFFF4A261);
  // static const Color danger = Color(0xFFE76F51);
  // static const Color info = Color(0xFF4895EF);

  // Book Cover Colors
  // static const Color coverGreen = Color(0xFF1D9E75);
  // static const Color coverBlue = Color(0xFF185FA5);
  // static const Color coverPurple = Color(0xFF534AB7);
  static const Color coverOrange = Color(0xFF993C1D);
 // static const Color coverTeal = Color(0xFF0F6E56);
  static const Color coverPink = Color(0xFF993556);

  // Primary Colors
  static const Color primary = Color(0xFF06192B);
  static const Color lightBlue = Color(0xFFE2F5FF);

  // Background Colors
  static const Color background = Color(0xFFF7F5F1);

  // Text Colors

  static const Color hintText = Color(0xFFBDBDBD);

  // Button Colors
  static const Color button = primary;
  static const Color blue = Color(0xFF059AE4);
  static const Color buttonText = Color(0xFF000000);

  // Border & Divider
  static const Color divider = Color(0xFFF2F2F2);

  // Status Colors

  static const Color error = Color(0xFFEB5757);


  // Other
  static const Color transparent = Colors.transparent;

  static const grey = Colors.grey;

  static const grey50 = Color(0xFFF5F5F5); // same as Colors.grey[50]
  static const grey100 = Color(0xFFF0F0F0);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey500 = Colors.grey;
  static const grey600 = Color(0xFF757575);
  static const grey700 = Color(0xFF616161);
  static const grey800 = Color(0xFF424242);
  static const grey900 = Color(0xFF212121);

  // Black variants
  static const black = Colors.black;
  static const black87 = Colors.black87;
  static const black54 = Colors.black54;
  static const black45 = Colors.black45;
  static const black12 = Colors.black12;

  // White variants
  static const white = Colors.white;
  static const white70 = Colors.white70;
  static const white54 = Colors.white54;
  static const white38 = Colors.white38;
  static const white30 = Colors.white30;

  static const yellow = Color(0xFFDBBC00);

  static const orange = Colors.deepOrange;
}