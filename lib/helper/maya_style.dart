import 'package:flutter/material.dart';

/// Material Design 3 Style Helper for Maya Calendar
/// Provides modern styling while maintaining backward compatibility
class MayaStyle {
  // Text Field TextStyle - Updated for Material 3
  TextStyle textFieldStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  // Text Field InputDecoration - Material 3 style
  InputDecoration textFieldInputDecoration(
    BuildContext context,
    Color? mainColor,
    String labelText,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = mainColor ?? colorScheme.primary;

    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surfaceContainer,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: effectiveColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontSize: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }

  // Dialog Title Style - Material 3
  static TextStyle popUpDialogTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontFamily: 'Roboto',
      color: colorScheme.onSurface,
      fontSize: 24,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
      letterSpacing: 0,
      height: 1.33,
    );
  }

  // Dialog Body Style - Material 3
  static TextStyle popUpDialogBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextStyle(
      fontFamily: 'Roboto',
      color: colorScheme.onSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      letterSpacing: 0.5,
      height: 1.5,
    );
  }

  // Legacy static styles (for backward compatibility)
  static const TextStyle popUpDialogTitleLegacy = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle popUpDialogBodyLegacy = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
  );

  // Dialog Decoration - Material 3 with surface tint
  BoxDecoration popUpDialogDecoration(BuildContext context, Color? mainColor) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = mainColor ?? colorScheme.primary;

    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Legacy decoration (for backward compatibility with custom backgrounds)
  BoxDecoration popUpDialogDecorationLegacy(Color mainColor) {
    return BoxDecoration(
      color: mainColor,
      border: Border.all(width: 1, color: Colors.white),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }

  // Main Button Style - Material 3 Filled Button
  ButtonStyle mainButtonStyle(BuildContext context, Color? color) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colorScheme.primary;

    return FilledButton.styleFrom(
      backgroundColor: effectiveColor,
      foregroundColor: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
    );
  }

  // Legacy main button (for custom colored buttons)
  ButtonStyle mainButtonStyleLegacy(Color? color) {
    return ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStateProperty.all(color?.withOpacity(0.8)),
      shadowColor: WidgetStateProperty.all(Colors.black26),
      elevation: WidgetStateProperty.all(2),
      side: WidgetStateProperty.all(
        BorderSide(color: color?.withOpacity(0.3) ?? Colors.white24, width: 1),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 16)),
      overlayColor: WidgetStateProperty.all(color?.withOpacity(0.1)),
    );
  }

  // Transparent Button Style - Material 3 Outlined Button
  ButtonStyle transparentButtonStyle(BuildContext context, Color? overlayColor) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = overlayColor ?? colorScheme.primary;

    return OutlinedButton.styleFrom(
      foregroundColor: effectiveColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      side: BorderSide(color: effectiveColor, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
    );
  }

  // Legacy transparent button
  ButtonStyle transparentButtonStyleLegacy(Color? overlayColor) {
    return ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      side: WidgetStateProperty.all(
        const BorderSide(color: Colors.white, width: 1),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 16)),
      overlayColor: WidgetStateProperty.all(overlayColor),
    );
  }

  // Card Decoration - Material 3
  BoxDecoration cardDecoration(BuildContext context, {Color? color}) {
    final colorScheme = Theme.of(context).colorScheme;

    return BoxDecoration(
      color: color ?? colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Legacy card decoration (for custom backgrounds)
  BoxDecoration cardDecorationLegacy(Color? color) {
    return BoxDecoration(
      color: color?.withOpacity(0.5) ?? Colors.white.withOpacity(0.1),
      border: Border.all(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  // Dialog Padding - Responsive
  double dialogPadding(Size size) {
    return size.width * 0.04; // Slightly more padding for modern design
  }

  // Dialog Button Size - Responsive
  Size dialogButtonSize(Size size) {
    return Size(size.width * 0.35, size.width * 0.12);
  }

  // Elevation for cards
  double get cardElevation => 1.0;

  // Elevation for dialogs
  double get dialogElevation => 3.0;

  // Standard spacing
  double get spacingSmall => 8.0;
  double get spacingMedium => 16.0;
  double get spacingLarge => 24.0;
  double get spacingXLarge => 32.0;

  // Border radius
  double get borderRadiusSmall => 8.0;
  double get borderRadiusMedium => 12.0;
  double get borderRadiusLarge => 16.0;
  double get borderRadiusXLarge => 28.0;
}

