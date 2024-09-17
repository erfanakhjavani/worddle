import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Constants/app_colors.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Game/game_view.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'menu_play_viewmodel.dart';

class MenuPlayView extends GetView<MenuPlayViewModel> {
  const MenuPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'back'.tr, //* Title for the AppBar
          style: Get.textTheme.headlineSmall,
        ),
        titleSpacing: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //! Section for word length adjustment
          Text(
            'word-length'.tr, //* Display text for word length section
            style: Get.textTheme.bodyMedium!.copyWith(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.decreaseWordLength, //* Decrease word length
                icon: const Icon(Icons.arrow_back_ios_rounded),
                iconSize: 30,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Obx(() => Text(
                '${controller.wordLength.value}', //* Display current word length
                style: Get.textTheme.headlineMedium!.copyWith(
                  fontFamily: Get.locale!.languageCode == 'fa' ? 'Yekan' : '',
                ),
              )),
              const SizedBox(width: 10),
              IconButton(
                onPressed: controller.increaseWordLength, //* Increase word length
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                iconSize: 30,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 20),
          //! Section for max attempts adjustment
          Text(
            'max-attempts'.tr, //* Display text for max attempts section
            style: Get.textTheme.bodyLarge!.copyWith(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.decreaseMaxAttempts, //* Decrease max attempts
                icon: const Icon(Icons.arrow_back_ios_rounded),
                iconSize: 30,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Obx(() => Text(
                '${controller.maxAttempts.value}', //* Display current max attempts
                style: Get.textTheme.headlineMedium!.copyWith(
                  fontFamily: Get.locale!.languageCode == 'fa' ? 'Yekan' : '',
                ),
              )),
              const SizedBox(width: 10),
              IconButton(
                onPressed: controller.increaseMaxAttempts, //* Increase max attempts
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                iconSize: 30,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 50),
          //! Button to start the game
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Get.theme.primaryColor,
            ),
            onPressed: () async {
              bool isFarsi = Get.locale?.languageCode == 'fa'; //* Check if the language is Farsi
              print(isFarsi);
              final gameViewModel = Get.find<GameViewModel>();
              await gameViewModel.initializeGame(
                controller.wordLength.value,
                controller.maxAttempts.value,
                isFarsiGame: isFarsi ? true : false, //* Initialize the game with settings
              ).then((value) {
                gameViewModel.resetGame(isFarsi: isFarsi ? true : false); //* Reset the game
              }).then((value) {
                Get.to(
                      () => const GameView(),
                  transition: Transition.downToUp, //* Transition effect to game view
                  curve: Curves.bounceInOut,
                  duration: 600.ms,
                );
              });
            },
            child: Text(
              'start'.tr, //* Button text to start the game
              style: Get.textTheme.headlineLarge?.copyWith(
                fontSize: 50,
                color: Get.find<ThemeService>().isDarkMode()
                    ? AppColors.secondary
                    : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
