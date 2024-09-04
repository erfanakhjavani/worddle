import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxController {
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get theme => _themeMode.value;

  void switchTheme(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  bool isDarkMode() {
    return _themeMode.value == ThemeMode.dark ||
        (_themeMode.value == ThemeMode.system &&
            WidgetsBinding.instance.window.platformBrightness == Brightness.dark);
  }

}
