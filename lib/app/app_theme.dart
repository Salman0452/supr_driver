import 'package:flutter/material.dart';

class AppColors {
  static const Color PrimaryColor = Color(0xFFFCF3CF);
  static const Color SecondaryColor = Color(0xFF000000);
  static const Color lightSecondaryColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Colors.white;
  static const Color darkBackgroundColor = Color(0xFF121212); // Dark background
  static const Color textColor = Color(0xFF000000);
  static const Color darkTextColor = Color(0xFFEEEEEE);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.PrimaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.PrimaryColor,
      secondary: AppColors.SecondaryColor,
      background: AppColors.backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textColor),
      titleTextStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColor),
      bodyMedium: TextStyle(color: AppColors.textColor),
      bodySmall: TextStyle(color: AppColors.textColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.PrimaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textColor,
        side: const BorderSide(color: AppColors.textColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.PrimaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor, // Make sure this is dark
    colorScheme: ColorScheme.dark(
      primary: AppColors.PrimaryColor,
      secondary: AppColors.SecondaryColor,
      background: AppColors.darkBackgroundColor,
      surface: AppColors.darkSurfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkTextColor),
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextColor),
      bodyMedium: TextStyle(color: AppColors.darkTextColor),
      bodySmall: TextStyle(color: AppColors.darkTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.PrimaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.lightSecondaryColor,
        side: const BorderSide(color: AppColors.lightSecondaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
