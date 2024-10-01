import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Constants/app_colors.dart';
import 'package:wordle/Core/Themes/theme_service.dart';

class Themes {
  //! Light theme configuration
  static final light = ThemeData(
    primaryColor: AppColors.secondary, //* Primary color for the light theme
    scaffoldBackgroundColor: AppColors.primary, //* Background color for the scaffold
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent, //* Transparent background for the AppBar
      iconTheme: IconThemeData(color: AppColors.secondary), //* Icon color in the AppBar
    ),
    iconTheme: IconThemeData(color: AppColors.secondary), //* Default icon color
    textTheme: _getTextTheme(isDarkMode: false), //* Add text theme
  );

  //! Dark theme configuration
  static final dark = ThemeData(
    primaryColor: AppColors.primary, //* Primary color for the dark theme
    scaffoldBackgroundColor: AppColors.secondary, //* Background color for the scaffold
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent, //* Transparent background for the AppBar
      iconTheme: IconThemeData(color: AppColors.primary), //* Icon color in the AppBar
    ),
    iconTheme: IconThemeData(color: AppColors.primary), //* Default icon color
    textTheme: _getTextTheme(isDarkMode: true), //* Add text theme
  );

  //! Function to get text theme based on dark mode setting
  static TextTheme _getTextTheme({required bool isDarkMode}) {
    String fontFamily = Get.locale.toString() == 'en' ? 'Roboto' : 'Yekan';
    Color textColor = isDarkMode ? AppColors.primary : AppColors.secondary;
    return TextTheme(
      labelSmall: TextStyle(
          fontFamily: fontFamily, fontSize: 8, fontWeight: FontWeight.w400, color: textColor),
      labelMedium: TextStyle(
          fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: textColor),
      labelLarge: TextStyle(
          fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: textColor),
      bodySmall: TextStyle(
          fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      bodyMedium: TextStyle(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: TextStyle(
          fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
      headlineSmall: TextStyle(
          fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
      headlineMedium: TextStyle(
          fontFamily: fontFamily, fontSize: 30, fontWeight: FontWeight.w500, color: textColor),
      headlineLarge: TextStyle(
          fontFamily: fontFamily, fontSize: 40, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}
