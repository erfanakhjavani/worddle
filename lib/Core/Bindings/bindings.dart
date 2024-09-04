
import 'package:get/get.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';
import 'package:wordle/Features/Splash/splash_viewmodel.dart';

import '../../Features/Menu/Play/menu_play_viewmodel.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SplashViewmodel());
    Get.lazyPut(()=> MenuViewmodel());
    Get.lazyPut(()=> MenuPlayViewModel());
    Get.put(GameViewModel());
  }

}