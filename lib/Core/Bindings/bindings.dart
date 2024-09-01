
import 'package:get/get.dart';
import 'package:wordle/ViewModel/game_viewmodel.dart';
import 'package:wordle/ViewModel/menu_viewmodel.dart';
import 'package:wordle/ViewModel/splash_viewmodel.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> SplashViewmodel());
    Get.lazyPut(()=> MenuViewmodel());
    Get.put(GameViewModel());
  }

}