import 'package:flutter/material.dart';

// Modern minimal color palette
class AppColors {
  // Dark theme colors (primary)
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF2A2A2A);
  static const Color darkBorder = Color(0xFF3A3A3A);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentOrangeLight = Color(0xFFFF8A65);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);

  // Light theme colors (secondary)
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF8F8F8);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF4A4A4A);
  static const Color lightTextTertiary = Color(0xFF6A6A6A);

  // Gradient colors for backgrounds
  static const Color darkGradientStart = Color(0xFF0A0A0A);
  static const Color darkGradientMid = Color(0xFF1A1A1A);
  static const Color darkGradientEnd = Color(0xFF0F0F0F);

  static const Color lightGradientStart = Color(0xFFFAFAFA);
  static const Color lightGradientMid = Color(0xFFF5F5F5);
  static const Color lightGradientEnd = Color(0xFFFFFFFF);
}

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Ariel',
  colorScheme: const ColorScheme.dark(
    surface: AppColors.darkBackground,
    primary: AppColors.accentOrange,
    secondary: AppColors.darkSurface,
    tertiary: AppColors.textPrimary,
    primaryFixed: AppColors.textSecondary,
    primaryContainer: AppColors.darkCard,
    tertiaryFixedDim: AppColors.darkBorder,
    primaryFixedDim: AppColors.accentOrangeLight,
    secondaryFixed: AppColors.darkSurface,
    surfaceContainerHigh: AppColors.darkCard,
    surfaceContainerLow: AppColors.textTertiary,
    onSurface: AppColors.textPrimary,
    onPrimary: AppColors.textPrimary,
    onSecondary: AppColors.textSecondary,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardTheme: CardTheme(
    color: AppColors.darkCard.withOpacity(0.8),
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: AppColors.darkBorder.withOpacity(0.3),
        width: 1,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Ariel',
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentOrange,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.darkBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accentOrange),
    ),
    hintStyle: const TextStyle(color: AppColors.textTertiary),
  ),
);

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Ariel',
  colorScheme: const ColorScheme.light(
    surface: AppColors.lightBackground,
    primary: AppColors.accentOrange,
    secondary: AppColors.lightSurface,
    tertiary: AppColors.lightTextPrimary,
    primaryFixed: AppColors.lightTextSecondary,
    primaryContainer: AppColors.lightCard,
    tertiaryFixedDim: AppColors.lightBorder,
    primaryFixedDim: AppColors.accentOrangeLight,
    secondaryFixed: AppColors.lightSurface,
    surfaceContainerHigh: AppColors.lightCard,
    surfaceContainerLow: AppColors.lightTextTertiary,
    onSurface: AppColors.lightTextPrimary,
    onPrimary: AppColors.textPrimary,
    onSecondary: AppColors.lightTextSecondary,
  ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardTheme: CardTheme(
    color: AppColors.lightCard.withOpacity(0.9),
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: AppColors.lightBorder.withOpacity(0.5),
        width: 1,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightTextPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Ariel',
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentOrange,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightCard,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lightBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accentOrange),
    ),
    hintStyle: const TextStyle(color: AppColors.lightTextTertiary),
  ),
);
