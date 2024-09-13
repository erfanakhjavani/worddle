import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Features/Game/game_model.dart';

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
            controller.resetGame(isFarsi: true);
          }, icon: const Icon(Icons.settings_backup_restore_sharp))
        ],
      ),

      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Obx(() => Text(
                controller.wordMessage.value,
                style: TextStyle(
                  color: controller.wordMessage.value.contains('Congratulations')
                      ? Colors.green
                      : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),

              const Expanded(
                  flex: 2,
                  child: GameBoard()),

              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 50, 3, 15),
                    child: GameKeyboard(),
                  )),
            ],
          )

    );
  }
}
