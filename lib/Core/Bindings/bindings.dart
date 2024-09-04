
import 'package:get/get.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';
import 'package:wordle/Features/Splash/splash_viewmodel.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SplashViewmodel());
    Get.lazyPut(()=> MenuViewmodel());
    Get.put(GameViewModel(5,6));
  }

}