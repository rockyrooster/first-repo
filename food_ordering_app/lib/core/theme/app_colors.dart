import 'package:flutter/material.dart';

/// App-wide color palette inspired by coffee and food
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6B4226); // Coffee brown
  static const Color primaryLight = Color(0xFF8D6E4F);
  static const Color primaryDark = Color(0xFF4A2C1A);

  // Secondary Colors
  static const Color secondary = Color(0xFF4CAF50); // Fresh green
  static const Color secondaryLight = Color(0xFF80E27E);
  static const Color secondaryDark = Color(0xFF087F23);

  // Accent Colors
  static const Color accent = Color(0xFFFF6B35); // Warm orange
  static const Color accentLight = Color(0xFFFF9563);
  static const Color accentDark = Color(0xFFCC5426);

  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Divider & Border
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFEEEEEE);

  // Transparent overlays
  static const Color overlay = Color(0x1F000000);
  static const Color overlayLight = Color(0x0A000000);
}
