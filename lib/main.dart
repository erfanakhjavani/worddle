

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'Core/Bindings/bindings.dart';
import 'Core/Constants/app_route.dart';
import 'Core/Themes/themes.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp( Main());
}

class Main extends StatelessWidget {
   Main({super.key});

  final ThemeService themeService = Get.put(ThemeService());

  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.pages,
      initialBinding: Binding(),
      darkTheme: Themes.dark,
      theme: Themes.light,
      themeMode: themeService.theme,
      initialRoute: AppRoute.splashView,
    );
  }
}
