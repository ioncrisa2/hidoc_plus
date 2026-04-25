import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand foundations
  static const primary = Color(0xFF525693);
  static const primaryContainer = Color(0xFF6B6FAE);
  static const secondary = Color(0xFF006A64);
  static const secondaryContainer = Color(0xFF7BF3E9);
  static const tertiary = Color(0xFF49605E);

  // Text / foreground
  static const textPrimary = Color(0xFF141B2C);
  static const textMuted = Color(0xFF464650);
  static const onSurface = textPrimary;
  static const onSurfaceVariant = textMuted;
  static const onBackground = textPrimary;
  static const onPrimary = Color(0xFFFFFFFF);
  static const onPrimaryContainer = Color(0xFFFFFBFF);
  static const onSecondary = Color(0xFFFFFFFF);
  static const onSecondaryContainer = Color(0xFF006F69);
  static const onTertiary = Color(0xFFFFFFFF);
  static const onTertiaryContainer = Color(0xFFF2FFFD);
  static const inverseOnSurface = Color(0xFFEDF0FF);

  // Surfaces
  static const background = Color(0xFFFAF9FF);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceBright = Color(0xFFFAF9FF);
  static const surfaceDim = Color(0xFFD3D9F0);
  static const surfaceLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF1F3FF);
  static const surfaceContainer = Color(0xFFE9EDFF);
  static const surfaceContainerHigh = Color(0xFFE1E8FF);
  static const surfaceContainerHighest = Color(0xFFDBE2F9);
  static const surfaceVariant = Color(0xFFDBE2F9);
  static const surfaceTint = Color(0xFF555996);
  static const inverseSurface = Color(0xFF293041);

  // Borders / outlines
  static const outline = Color(0xFF777681);
  static const outlineVariant = Color(0xFFC7C5D1);

  // Fixed and alternate brand tones
  static const primaryFixed = Color(0xFFE0E0FF);
  static const primaryFixedDim = Color(0xFFBFC2FF);
  static const inversePrimary = Color(0xFFBFC2FF);
  static const secondaryFixed = Color(0xFF7EF6EC);
  static const secondaryFixedDim = Color(0xFF5FD9D0);
  static const tertiaryContainer = Color(0xFF617977);
  static const tertiaryFixed = Color(0xFFCEE8E5);
  static const tertiaryFixedDim = Color(0xFFB2CCC9);
  static const onPrimaryFixed = Color(0xFF0F134F);
  static const onPrimaryFixedVariant = Color(0xFF3D417D);
  static const onSecondaryFixed = Color(0xFF00201E);
  static const onSecondaryFixedVariant = Color(0xFF00504B);
  static const onTertiaryFixed = Color(0xFF071F1E);
  static const onTertiaryFixedVariant = Color(0xFF344B49);

  // Semantic
  static const success = Color(0xFF006F69);
  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);

  // Convenience aliases used by the current codebase
  static const primaryDark = Color(0xFF3D417D);
}
