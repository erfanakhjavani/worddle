import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Constants/app_colors.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor:  Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.secondary,),
    ),
    textTheme:  TextTheme(
        labelLarge:
        Get.textTheme.labelLarge?.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.secondary),
        labelMedium:
        Get.textTheme.labelMedium?.copyWith(fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.secondary),
        labelSmall:
        Get.textTheme.labelSmall?.copyWith(fontSize: 8,fontWeight: FontWeight.w400,color: AppColors.secondary),
        bodySmall:
        Get.textTheme.bodySmall?.copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.secondary),
        bodyMedium:
        Get.textTheme.bodyMedium?.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.secondary),
        bodyLarge:
        Get.textTheme.bodyLarge?.copyWith(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.secondary),
        headlineSmall:
        Get.textTheme.headlineSmall?.copyWith(fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.secondary),
        headlineMedium:
        Get.textTheme.headlineMedium?.copyWith(fontSize: 30,fontWeight: FontWeight.w600,color: AppColors.secondary),
        headlineLarge:
        Get.textTheme.headlineLarge?.copyWith(fontSize: 40,fontWeight: FontWeight.w600,color: AppColors.secondary)),

    );

  static final dark = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.secondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    textTheme:  TextTheme(
        labelLarge:
        Get.textTheme.labelLarge?.copyWith(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.primary),
        labelMedium:
        Get.textTheme.labelMedium?.copyWith(fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.primary),
        labelSmall:
        Get.textTheme.labelSmall?.copyWith(fontSize: 8,fontWeight: FontWeight.w400,color: AppColors.primary),
        bodySmall:
        Get.textTheme.bodySmall?.copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.primary),
        bodyMedium:
        Get.textTheme.bodyMedium?.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.primary),
        bodyLarge:
        Get.textTheme.bodyLarge?.copyWith(fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.primary),
        headlineMedium:
        Get.textTheme.headlineMedium?.copyWith(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.white),
        headlineSmall:
        Get.textTheme.headlineSmall?.copyWith(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white70),
        headlineLarge:
        Get.textTheme.headlineLarge?.copyWith(fontSize: 40,fontWeight: FontWeight.w600,color: Colors.white)),

  );
}
