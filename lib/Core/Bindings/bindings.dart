
import 'package:get/get.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'package:wordle/Features/Language/language_viewmodel.dart';
import 'package:wordle/Features/Menu/Settings/menu_setting_viewmodel.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';
import 'package:wordle/Features/Splash/splash_viewmodel.dart';
import '../../Features/Menu/Play/menu_play_viewmodel.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SplashViewmodel());
    Get.put(MenuViewmodel());
    Get.put(MenuPlayViewModel());
    Get.put(GameViewModel());
    Get.put(LanguageViewmodel());
    Get.put(MenuSettingViewmodel());
  }

}