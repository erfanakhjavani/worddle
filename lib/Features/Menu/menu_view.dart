import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:wordle/Core/Constants/app_colors.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Menu/Play/menu_play_view.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';

import 'Settings/menu_setting_view.dart';


class MenuView extends GetView<MenuViewmodel> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          // خوش‌آمدگویی و انیمیشن Lottie
          Stack(
            alignment: Alignment.center,
            children: [
              // متن خوش‌آمدگویی
              GetBuilder<ThemeService>(builder: (c)=>  Positioned(
                top: 80,
                child: Text(
                  'Welcome to Raviar is',
                  style: Get.textTheme.headlineLarge?.copyWith(
                    color: c.isDarkMode() ? AppColors.primary : AppColors.secondary,
                    fontFamily: 'Debug',
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),),
              // انیمیشن Lottie
              Lottie.asset(
                'assets/json/worddle.json',
                height: 300,
                width: double.infinity,
                reverse: true,
                alignment: Alignment.center,
              ),
            ],
          ),
          // گزینه‌های منو
          _buildMenuItem(
            title: 'Play',
            isShaking: controller.isPlayShaking,
            onTap: () {
              // Reset game state

              Get.to( const MenuPlayView(), transition: Transition.rightToLeft, curve: Curves.linearToEaseOut, duration: const Duration(seconds: 1));
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            title: 'Online PvP',
            isShaking: controller.isOnlinePvPShaking,
            onTap: () {
            },
          ),
          const SizedBox(height: 20),
          _buildMenuItem(
            title: 'Settings',
            isShaking: controller.isSettingsShaking,
            onTap: () {
              Get.to(const MenuSettingView(), transition: Transition.rightToLeft, curve: Curves.bounceInOut, duration: 500.ms);

              // Placeholder for Settings functionality
            },
          ),

        ],
      ),
    );
  }

  // ویجت جداگانه برای هر آیتم منو با انیمیشن لرزشی
  Widget _buildMenuItem({required String title, required RxBool isShaking, required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        controller.startShaking(title);
        onTap();
        print('$title selected'); // اجرای دستور هنگام کلیک
      },
      child: GetBuilder<ThemeService>(builder: (c) {
        return Text(
          title,
          style: Get.textTheme.headlineLarge?.copyWith(
            fontFamily: 'Debug',
            color: c.isDarkMode() ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ).animate(
          target: isShaking.value ? 1 : 0,
        ).shake(duration: 100.ms); // اجرای انیمیشن لرزش
      }),
    );
  }

}
