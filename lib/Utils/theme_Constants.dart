import 'package:flutter/material.dart';

/// ThemeConstants class contains all the styling constants used across the app
/// This helps maintain consistent styling and makes theme updates easier
class ThemeConstants {
  // Private constructor to prevent instantiation
  ThemeConstants._();

  // Primary colors
  static const Color primaryColor = Color(0xFF0CA201);
  static const Color secondaryColor = Color(0xFF0A8701);
  static const Color accentColor = Color(0xFFFFA726);

  // Text colors
  static const Color textPrimary = Color(0xFF018D14);
  static const Color textSecondary = Color(0xFF000000);
  static const Color textHint = Color(0xFF9E9E9E);

  // Background colors
  static const Color backgroundPrimary = Color(0xFF0CA201);
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  
  // Scaffold colors
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color scaffoldBackgroundColorDark = Color(0xFF121212);
  static const Color scaffoldBackgroundColorAlternate = Color(0xFFF5F7FA);

  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFFB74D);
  static const Color infoColor = Color(0xFF2196F3);

  // Border colors
  static const Color borderColor = Color(0xFFE0E0E0);
  
  // Button colors
  static const Color buttonDisabledColor = Color(0xFFBDBDBD);
  static const Color buttonDisabledTextColor = Color(0xFF757575);
  
  // Shadow color
  static final Color shadowColor = Colors.black.withOpacity(0.1);
  
  // ================ SPACING ================
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 48.0;
  
  // ================ RADIUS ================
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // ================ ELEVATION ================
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  
  // ================ ANIMATION DURATIONS ================
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 350);
  static const Duration animationLong = Duration(milliseconds: 500);
  
  // ================ TEXT STYLES ================
  // Headings
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  // Description text - with Poppins font
  static const TextStyle descriptionText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 24.0 / 16.0, // line-height in Flutter is specified as a multiplier
    letterSpacing: 0.0,
    color: textPrimary,
  );
  
  // Button text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  // Label text
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: textSecondary,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    letterSpacing: 0.5,
  );

  // ================ INPUT DECORATION ================
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: backgroundPrimary,
      errorMaxLines: 2,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMedium,
        vertical: spacingMedium,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      labelStyle: labelMedium,
      hintStyle: bodyMedium.copyWith(color: textHint),
      errorStyle: bodySmall.copyWith(color: errorColor),
    );
  }
  
  // ================ BUTTON STYLES ================
  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return buttonDisabledColor;
        }
        return primaryColor;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return buttonDisabledTextColor;
        }
        return Colors.white;
      },
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: spacingLarge,
        vertical: spacingMedium,
      ),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
    ),
    elevation: MaterialStateProperty.all(elevationSmall),
    textStyle: MaterialStateProperty.all(buttonMedium),
  );
  
  static ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return buttonDisabledColor;
        }
        return Colors.transparent;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return buttonDisabledTextColor;
        }
        return primaryColor;
      },
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: spacingLarge,
        vertical: spacingMedium,
      ),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        side: const BorderSide(color: primaryColor),
      ),
    ),
    elevation: MaterialStateProperty.all(0),
    textStyle: MaterialStateProperty.all(buttonMedium),
  );

  // ================ APP BAR ================
  static const double appBarElevation = 0.0;
  static const Color appBarBackgroundColor = backgroundPrimary;
  static const Color appBarForegroundColor = textPrimary;
  
  // ================ SCAFFOLD ================
  static const EdgeInsets scaffoldPadding = EdgeInsets.symmetric(
    horizontal: spacingMedium,
    vertical: spacingMedium,
  );
  
  static BoxDecoration scaffoldBoxDecoration = BoxDecoration(
    color: scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
  
  // ================ CARD ================
  static BoxDecoration cardBoxDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radiusMedium),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  static const EdgeInsets cardPadding = EdgeInsets.all(spacingMedium);
}