import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_board_widget.dart';
import 'game_keyboard_widget.dart';
import 'game_viewmodel.dart';


class GameView extends GetView<GameViewModel> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            controller.resetGame();
          }, icon: const Icon(Icons.settings_backup_restore_sharp))
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // عنوان بازی
          Text(
            'Wordle',
            style: Get.textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          // پیام بازی
          Obx(() => Text(
            controller.wordMessage.value,
            style: TextStyle(
              color: controller.wordMessage.value.contains("Congratulations")
                  ? Colors.green
                  : Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),

          // صفحه نمایش تخته بازی
          GameBoard(),
          // صفحه کلید بازی
          Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 50, 3, 15),
                child: GameKeyboard(),
              )),
        ],
      ),
    );
  }
}
