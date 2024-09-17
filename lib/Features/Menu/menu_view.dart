import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Menu/Play/menu_play_view.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';

import 'Settings/menu_setting_view.dart';

class MenuView extends GetView<MenuViewmodel> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    var isFarsi = Get.locale!.languageCode == 'fa';
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          //! Welcome message and Lottie animation
          Stack(
            alignment: Alignment.center,
            children: [
              //! Welcome text
              GetBuilder<ThemeService>(builder: (c) => Positioned(
                top: 60,
                child: Text(
                  'Raviar is Words'.tr,
                  style: Get.textTheme.displayLarge?.copyWith(
                    color: c.isDarkMode() ? Colors.white : Colors.blueGrey,
                    fontFamily: isFarsi ? 'Yekan' : 'Debug',
                    fontWeight: FontWeight.w100,
                    fontSize: isFarsi ? 40 : 50,
                  ),
                ),
              )),
              //! Lottie animation
              Lottie.asset(
                'assets/json/worddle.json',
                height: 300,
                width: double.infinity,
                reverse: true,
                alignment: Alignment.center,
              ),
            ],
          ),
          //! Menu options
          _buildMenuItem(
            title: 'play_local'.tr,
            isShaking: controller.isPlayShaking,
            onTap: () {
              //! Reset game state and navigate to Play View
              Get.to(
                const MenuPlayView(),
                transition: Transition.rightToLeft,
                curve: Curves.linearToEaseOut,
                duration: const Duration(seconds: 1),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            title: 'online'.tr,
            isShaking: controller.isOnlinePvPShaking,
            onTap: () {
              //! Placeholder for Online PvP functionality
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            title: 'settings'.tr,
            isShaking: controller.isSettingsShaking,
            onTap: () {
              //! Navigate to Settings View
              Get.to(
                const MenuSettingView(),
                transition: Transition.rightToLeft,
                curve: Curves.bounceInOut,
                duration: 500.ms,
              );
            },
          ),
        ],
      ),
    );
  }

  //! Widget to build individual menu item with shake animation
  Widget _buildMenuItem({
    required String title,
    required RxBool isShaking,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () {
        controller.startShaking(title);
        onTap();
        print('$title selected'); // Log menu selection
      },
      child: GetBuilder<ThemeService>(builder: (c) {
        return Text(
          title,
          style: Get.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ).animate(
          target: isShaking.value ? 1 : 0,
        ).shake(duration: 100.ms); //* Shake animation for menu item
      }),
    );
  }
}
