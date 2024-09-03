

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Splash/splash_view.dart';
import 'Core/Bindings/bindings.dart';
import 'Core/Constants/app_route.dart';
import 'Core/Themes/themes.dart';
import 'Features/Game/game_view.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(ThemeService());
  runApp(const Main());
}

class Main extends StatelessWidget {
   const Main({super.key});


  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.pages,
      initialBinding: Binding(),
      darkTheme: Themes.dark,
      theme: Themes.light,
      themeMode: Get.find<ThemeService>().theme,
      // initialRoute: AppRoute.splashView,
      home: const SplashView(),
    );
  }
}
