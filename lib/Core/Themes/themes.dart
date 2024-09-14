import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Constants/app_colors.dart';


class Themes {
  // تم روشن
  static final light = ThemeData(
    primaryColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.secondary),
    ),
    iconTheme: const IconThemeData(color: AppColors.secondary),
    textTheme: _getTextTheme(isDarkMode: false), // استفاده از تم متنی برای حالت روشن
  );

  // تم تیره
  static final dark = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.secondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    iconTheme: const IconThemeData(color: AppColors.primary),
    textTheme: _getTextTheme(isDarkMode: true), // استفاده از تم متنی برای حالت تیره
  );

  // تابعی که تم متنی را بر اساس حالت روشن یا تاریک انتخاب می‌کند
  static TextTheme _getTextTheme({required bool isDarkMode}) {
    String? fontFamily = 'Yekan';
    Color textColor = isDarkMode ? AppColors.primary : AppColors.secondary;

    return TextTheme(
      labelLarge: Get.textTheme.labelLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: textColor),
      labelMedium: Get.textTheme.labelMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: textColor),
      labelSmall: Get.textTheme.labelSmall?.copyWith(
          fontFamily: fontFamily, fontSize: 8, fontWeight: FontWeight.w400, color: textColor),
      bodySmall: Get.textTheme.bodySmall?.copyWith(
          fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      bodyMedium: Get.textTheme.bodyMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: Get.textTheme.bodyLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
      headlineSmall: Get.textTheme.headlineSmall?.copyWith(
          fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
      headlineMedium: Get.textTheme.headlineMedium?.copyWith(
          fontFamily: fontFamily, fontSize: 30, fontWeight: FontWeight.w500, color: textColor),
      headlineLarge: Get.textTheme.headlineLarge?.copyWith(
          fontFamily: fontFamily, fontSize: 40, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}

