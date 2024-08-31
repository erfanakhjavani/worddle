
import 'package:get/get.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/ViewModel/splash_viewmodel.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SplashViewmodel());
    Get.lazyPut(()=> ThemeService(),);
  }

}