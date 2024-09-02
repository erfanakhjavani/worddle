
import 'package:get/get.dart';
import 'package:wordle/Features/Splash/splash_view.dart';

import '../../Features/Menu/menu_view.dart';

class AppRoute{
  static const String menuView = '/MenuView';
  static const String splashView = '/SplashView';



  static List<GetPage> pages = [
    GetPage(name: menuView, page: () => const MenuView()),
    GetPage(name: splashView, page: () => const SplashView()),
  ];
}