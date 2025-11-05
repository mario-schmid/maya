import 'package:flutter/material.dart';

/// Material Design 3 Theme for Maya Calendar App
/// Combines modern Material You design with Maya cultural colors
class MayaTheme {
  // Maya-inspired color palette with modern Material 3 approach
  static const Color _mayaRed = Color(0xFFD32F2F);
  static const Color _mayaWhite = Color(0xFFF5F5F5);
  static const Color _mayaBlue = Color(0xFF1976D2);
  static const Color _mayaYellow = Color(0xFFFFA726);
  static const Color _mayaDeepPurple = Color(0xFF6A1B9A);
  static const Color _mayaTeal = Color(0xFF00897B);

  // Neutral colors
  static const Color _neutral0 = Color(0xFFFFFFFF);
  static const Color _neutral10 = Color(0xFFFAFAFA);
  static const Color _neutral20 = Color(0xFFF5F5F5);
  static const Color _neutral90 = Color(0xFF1A1A1A);
  static const Color _neutral95 = Color(0xFF0D0D0D);
  static const Color _neutral99 = Color(0xFF050505);

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: _mayaDeepPurple,
      onPrimary: _neutral0,
      primaryContainer: _mayaDeepPurple.withOpacity(0.1),
      onPrimaryContainer: _mayaDeepPurple,

      secondary: _mayaTeal,
      onSecondary: _neutral0,
      secondaryContainer: _mayaTeal.withOpacity(0.1),
      onSecondaryContainer: _mayaTeal,

      tertiary: _mayaYellow,
      onTertiary: _neutral90,
      tertiaryContainer: _mayaYellow.withOpacity(0.1),
      onTertiaryContainer: _mayaYellow.withOpacity(0.8),

      error: _mayaRed,
      onError: _neutral0,
      errorContainer: _mayaRed.withOpacity(0.1),
      onErrorContainer: _mayaRed,

      surface: _neutral10,
      onSurface: _neutral90,
      surfaceContainerLowest: _neutral0,
      surfaceContainerLow: _neutral10,
      surfaceContainer: _neutral20,
      surfaceContainerHigh: _neutral20,
      surfaceContainerHighest: _neutral20,

      outline: _neutral90.withOpacity(0.12),
      outlineVariant: _neutral90.withOpacity(0.08),
    ),

    // Typography
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 3,
      backgroundColor: _neutral10,
      foregroundColor: _neutral90,
      surfaceTintColor: _mayaDeepPurple,
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Filled Button Theme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _neutral20,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: _neutral90.withOpacity(0.12),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: _mayaDeepPurple,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: _mayaRed,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      backgroundColor: _neutral10,
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      thickness: 1,
      color: _neutral90.withOpacity(0.12),
    ),

    // Icon Theme
    iconTheme: IconThemeData(
      color: _neutral90,
      size: 24,
    ),

    // Font Family
    fontFamily: 'Roboto',
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color Scheme
    colorScheme: ColorScheme.dark(
      primary: _mayaDeepPurple.withOpacity(0.8),
      onPrimary: _neutral0,
      primaryContainer: _mayaDeepPurple.withOpacity(0.2),
      onPrimaryContainer: _mayaDeepPurple.withOpacity(0.9),

      secondary: _mayaTeal.withOpacity(0.8),
      onSecondary: _neutral0,
      secondaryContainer: _mayaTeal.withOpacity(0.2),
      onSecondaryContainer: _mayaTeal.withOpacity(0.9),

      tertiary: _mayaYellow,
      onTertiary: _neutral99,
      tertiaryContainer: _mayaYellow.withOpacity(0.2),
      onTertiaryContainer: _mayaYellow,

      error: _mayaRed.withOpacity(0.8),
      onError: _neutral0,
      errorContainer: _mayaRed.withOpacity(0.2),
      onErrorContainer: _mayaRed,

      surface: _neutral90,
      onSurface: _neutral10,
      surfaceContainerLowest: _neutral99,
      surfaceContainerLow: _neutral95,
      surfaceContainer: _neutral90,
      surfaceContainerHigh: _neutral90,
      surfaceContainerHighest: _neutral90,

      outline: _neutral10.withOpacity(0.12),
      outlineVariant: _neutral10.withOpacity(0.08),
    ),

    // Keep same component themes but they'll adapt to dark color scheme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 3,
      backgroundColor: _neutral90,
      foregroundColor: _neutral10,
      surfaceTintColor: _mayaDeepPurple,
    ),

    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    dialogTheme: DialogTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      backgroundColor: _neutral90,
    ),

    fontFamily: 'Roboto',
  );

  /// Get Maya color by traditional designation
  static Color getMayaColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return _mayaRed;
      case 'white':
        return _mayaWhite;
      case 'blue':
        return _mayaBlue;
      case 'yellow':
        return _mayaYellow;
      default:
        return _mayaDeepPurple;
    }
  }
}
