import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:wordle/Features/Game/game_view.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'package:wordle/Features/Menu/menu_viewmodel.dart';


class MenuView extends GetView<MenuViewmodel> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            // خوش‌آمدگویی و انیمیشن Lottie
            Stack(
              alignment: Alignment.center,
              children: [
                // متن خوش‌آمدگویی
                Positioned(
                  top: 80,
                  child: Text(
                    'Welcome to Raviar is',
                    style: Get.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Debug',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
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

                Get.to(const GameView(), transition: Transition.downToUp, curve: Curves.bounceInOut, duration: const Duration(seconds: 1));
              },
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              title: 'Online PvP',
              isShaking: controller.isOnlinePvPShaking,
              onTap: () {
                // Placeholder for Online PvP functionality
                Get.to(const GameView(), transition: Transition.downToUp, curve: Curves.bounceInOut, duration: const Duration(seconds: 2));

              },
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              title: 'Settings',
              isShaking: controller.isSettingsShaking,
              onTap: () {
                Get.to(const GameView(), transition: Transition.downToUp, curve: Curves.bounceInOut, duration: const Duration(seconds: 2));

                // Placeholder for Settings functionality
              },
            ),

          ],
        ),
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
      child: Obx(() {
        return Text(
          title,
          style: Get.textTheme.headlineLarge?.copyWith(
            fontFamily: 'Debug',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ).animate(
          target: isShaking.value ? 1 : 0,
        ).shake(duration: 100.ms); // اجرای انیمیشن لرزش
      }),
    );
  }

}
