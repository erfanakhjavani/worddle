import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wordle/Core/Constants/app_colors.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Game/game_view.dart';
import 'package:wordle/Features/Game/game_viewmodel.dart';
import 'menu_play_viewmodel.dart';

class MenuPlayView extends GetView<MenuPlayViewModel> {
  const MenuPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'back'.tr, //* Title for the AppBar
          style: theme.headlineSmall,
        ),
        titleSpacing: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //! Section for word length adjustment
          _buildAdjustableRow(
              label: 'word-length'.tr,
              value: controller.wordLength,
              decrease: controller.decreaseWordLength,
              increase: controller.increaseWordLength,
          ),
          const SizedBox(height: 20),
          //! Section for max attempts adjustment
          _buildAdjustableRow(
              label : 'max-attempts'.tr,
              value: controller.maxAttempts,
              decrease: controller.decreaseMaxAttempts,
              increase: controller.increaseMaxAttempts
          ),
          const SizedBox(height: 50),
          //! Button to start the game
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildAdjustableRow({required String label, required RxInt value, required VoidCallback decrease, required VoidCallback increase}) {
    return Column(
      children: [
        Text(
          label, //* Display label text for each section
          style: Get.textTheme.bodyMedium!.copyWith(fontSize: 30)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              iconSize: 30,
              color: Colors.red,
              onPressed: decrease, //* Decrease value
            ),
            const SizedBox(width: 10),
            Obx(() => Text(
              '${value.value}', //* Display current value
              style: Get.textTheme.headlineMedium!.copyWith(
                fontFamily: Get.locale!.languageCode == 'fa' ? 'Yekan' : '', //* Font adjustment for Farsi
              ),
            )),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              iconSize: 30,
              color: Colors.green,
              onPressed: increase, //* Increase value
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Get.theme.primaryColor,
      ),
      child: Text(
        'start'.tr, //* Button text to start the game
        style: Get.textTheme.headlineLarge?.copyWith(
          fontSize: 50,
          color: Get.find<ThemeService>().isDarkMode()
              ? AppColors.secondary
              : AppColors.primary, //* Color based on theme
        ),
      ),
      onPressed: () async {
        await Appodeal.show(AppodealAdType.NativeAd);
        bool isFarsi = Get.locale?.languageCode == 'fa' || Get.locale?.languageCode == 'ar'; //* Check if language is Farsi
        final gameViewModel = Get.find<GameViewModel>();
        await gameViewModel.initializeGame(
          controller.wordLength.value,
          controller.maxAttempts.value,
          isFarsiGame: isFarsi, //* Initialize game settings
        );
        Get.to(() => const GameView(),
          transition: Transition.downToUp, //* Transition to game view
          curve: Curves.bounceInOut,
          duration: 600.ms,
        );
      },
    );
  }
}


