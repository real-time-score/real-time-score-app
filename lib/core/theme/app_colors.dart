import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryLight = Color(0xFF6AB7FF);
  static const Color primaryDark = Color(0xFF005CB2);

  // Secondary
  static const Color secondary = Color(0xFFFF6D00);
  static const Color secondaryLight = Color(0xFFFF9E40);
  static const Color secondaryDark = Color(0xFFC43C00);

  // Background
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Sports
  static const Color live = Color(0xFFE53935);
  static const Color win = Color(0xFF4CAF50);
  static const Color lose = Color(0xFFF44336);
  static const Color draw = Color(0xFF9E9E9E);

  // Divider
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);

  // ============================================
  // FIGMA DESIGN SYSTEM COLORS
  // ============================================

  // Layer
  static const Color layerElevated = Color(0xFFFFFFFF);

  // Border
  static const Color borderNormal = Color(0xFFE7E9EC);

  // Label
  static const Color labelNormal = Color(0xFF151719);
  static const Color labelNeutral = Color(0xFF505866);
  static const Color labelAlternative = Color(0xFFB1B8C0); // placeholder 색상
  static const Color labelDisabled = Color(0xFFB1B8C0);

  // Container
  static const Color containerNormal = Color(0xFFFAFAFB);
  static const Color containerSelected = Color(0xFFF2F3F5);

  // Semantic - Negative (Error)
  static const Color negative = Color(0xFFE6533E);
  static const Color negativeContainer = Color(0xFFFDECEE);

  // Semantic - Positive (Decrease/Blue)
  static const Color positive = Color(0xFF3F94EE);
  static const Color positiveContainer = Color(0xFFE4F2FD);

  // ============================================
  // CHIPS DESIGN SYSTEM COLORS (from Figma)
  // ============================================

  // Primary (Figma)
  static const Color primaryFigma = Color(0xFF061667);
  static const Color primaryContainer = Color(0xFFF0F1F7);

  // Container
  static const Color containerDisabled = Color(0xFFE7E9EC);

  // Contents
  static const Color contentsNormal = Color(0xFFB1B8C0);
  static const Color contentsNeutral = Color(0xFF6D7582);

  // Semantic - Positive (Green)
  static const Color positiveGreen = Color(0xFF0BBD49);

  // Yellow
  static const Color yellow = Color(0xFFFBC926);

  // Base
  static const Color white = Color(0xFFFFFFFF);

  // ============================================
  // BUTTON DESIGN SYSTEM COLORS (from Figma)
  // ============================================

  // Container - Additional
  static const Color containerHover = Color(0xFFF2F3F5);
  static const Color containerAlternative = Color(0xFFE7E9EC);
  static const Color containerNeutral = Color(0xFFF3F4F8);

  // ============================================
  // ALIASES (편의를 위한 별칭)
  // ============================================

  // Label 별칭
  static const Color labelStrong = labelNormal;

  // Primary 별칭
  static const Color primaryBackground = primaryContainer;

  // Semantic 별칭 (주가 하락 = 파란색)
  static const Color decrease = positive;
}
