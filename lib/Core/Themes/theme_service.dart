import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxController {
  final themeMode = ThemeMode.light.obs;
  ThemeMode get theme => themeMode.value;




  void switchTheme(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  bool isDarkMode() {
    return themeMode.value == ThemeMode.dark;
  }
}
