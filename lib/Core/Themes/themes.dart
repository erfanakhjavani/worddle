import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Constants/app_colors.dart';

class Themes {
  //! Light theme configuration
  static final light = ThemeData(
    primaryColor: AppColors.secondary, //* Primary color for the light theme
    scaffoldBackgroundColor: AppColors.primary, //* Background color for the scaffold
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, //* Transparent background for the AppBar
      iconTheme: IconThemeData(color: AppColors.secondary), //* Icon color in the AppBar
    ),
    iconTheme: const IconThemeData(color: AppColors.secondary), //* Default icon color
    textTheme: _getTextTheme(isDarkMode: false), //* Text theme for light mode
  );

  //! Dark theme configuration
  static final dark = ThemeData(
    primaryColor: AppColors.primary, //* Primary color for the dark theme
    scaffoldBackgroundColor: AppColors.secondary, //* Background color for the scaffold
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, //* Transparent background for the AppBar
      iconTheme: IconThemeData(color: AppColors.primary), //* Icon color in the AppBar
    ),
    iconTheme: const IconThemeData(color: AppColors.primary), //* Default icon color
    textTheme: _getTextTheme(isDarkMode: true), //* Text theme for dark mode
  );

  //! Function to get text theme based on dark mode setting
  static TextTheme _getTextTheme({required bool isDarkMode}) {
    String? fontFamily = 'Yekan'; //* Font family used for the text
    Color textColor = isDarkMode ? AppColors.primary : AppColors.secondary; //* Text color based on theme

    return TextTheme(
      labelLarge: Get.textTheme.labelLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: textColor), //* Style for large labels
      labelMedium: Get.textTheme.labelMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: textColor), //* Style for medium labels
      labelSmall: Get.textTheme.labelSmall?.copyWith(
          fontFamily: fontFamily, fontSize: 8, fontWeight: FontWeight.w400, color: textColor), //* Style for small labels
      bodySmall: Get.textTheme.bodySmall?.copyWith(
          fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: textColor), //* Style for small body text
      bodyMedium: Get.textTheme.bodyMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: textColor), //* Style for medium body text
      bodyLarge: Get.textTheme.bodyLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w500, color: textColor), //* Style for large body text
      headlineSmall: Get.textTheme.headlineSmall?.copyWith(
          fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w500, color: textColor), //* Style for small headlines
      headlineMedium: Get.textTheme.headlineMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 30, fontWeight: FontWeight.w500, color: textColor), //* Style for medium headlines
      headlineLarge: Get.textTheme.headlineLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 40, fontWeight: FontWeight.w500, color: textColor), //* Style for large headlines
    );
  }
}
