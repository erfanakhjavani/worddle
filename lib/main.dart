import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Core/Translations/my_translation.dart';
import 'Core/Bindings/bindings.dart';
import 'Core/Constants/app_route.dart';
import 'Core/Themes/themes.dart';
import 'firebase_options.dart';

//! Main function to initialize the app and set up system configurations
void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //* Ensure Flutter is fully initialized before running
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); //* Hide system UI for immersive mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //* Lock screen orientation to portrait mode
  Get.put(ThemeService()); //* Initialize and store the theme service
  runApp(const Main()); //* Run the main app widget
}

//! Main class for the app, extends StatelessWidget
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => GetMaterialApp(
          translations: MyTranslation(), //* Load translations for multi-language support
          locale: Get.locale ?? const Locale('en'), //* Set default language to English
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: false, //* Disable debug banner
          getPages: AppRoute.pages, //* Define app routes
          initialBinding: Binding(), //* Set initial bindings for dependency injection
          darkTheme: Themes.dark, //* Define dark theme
          theme: Themes.light, //* Define light theme
          themeMode: Get.find<ThemeService>().theme, //* Use the theme defined by ThemeService
          initialRoute: AppRoute.splashView, //* Set the initial route (splash screen)
        )
    );
  }
}
