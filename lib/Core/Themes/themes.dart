import 'package:flutter/material.dart';
import 'package:wordle/Core/Constants/app_colors.dart';

class Themes {
  static final light = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFD6CEB6),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
  );

  static final dark = ThemeData(
    primaryColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.secondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFBDC4DA),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
