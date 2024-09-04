import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_board_widget.dart';
import 'game_keyboard_widget.dart';
import 'game_viewmodel.dart';


class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    // قرار دادن ViewModel در GetX
    final GameViewModel viewModel = Get.put(GameViewModel());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            viewModel.resetGame();
          }, icon: Icon(Icons.settings_backup_restore_sharp))
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // عنوان بازی
            Text(
              'Wordle',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            // پیام بازی
            Obx(() => Text(
              viewModel.wordMessage.value,
              style: TextStyle(
                color: viewModel.wordMessage.value.contains("Congratulations")
                    ? Colors.green
                    : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(height: 20),
            // صفحه نمایش تخته بازی
            GameBoard(),
            const SizedBox(height: 40),
            // صفحه کلید بازی
            GameKeyboard(),
          ],
        ),
      ),
    );
  }
}
