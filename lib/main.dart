import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Core/Translations/my_translation.dart';
import 'package:wordle/Features/Splash/splash_view.dart';
import 'package:wordle/telegram_controller.dart';
import 'Core/Bindings/bindings.dart';
import 'Core/Themes/themes.dart';

//! Main function to initialize the app and set up system configurations
void main() async{
  Get.put(ThemeService()); //* Initialize and store the theme service
  runApp(const Main()); //* Run the main app widget
}

//! Main class for the app, extends StatelessWidget
class Main extends GetView<TelegramController> {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => GetMaterialApp(
          translations: MyTranslation(), //* Load translations for multi-language support
          locale: Get.locale ?? const Locale('en'), //* Set default language to English
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false, //* Disable debug banner
          initialBinding: Binding(), //* Set initial bindings for dependency injection
          darkTheme: Themes.dark, //* Define dark theme
          theme: Themes.light, //* Define light theme
          themeMode: Get.find<ThemeService>().theme, //* Use the theme defined by ThemeService
          home: const SplashView(), //* Set the initial route (splash screen)
        )
    );
  }
}
