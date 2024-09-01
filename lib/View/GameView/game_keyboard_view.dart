// views/game_keyboard.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/game_viewmodel.dart';
import 'game_board_view.dart';

class GameKeyboard extends StatelessWidget {
  const GameKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> row1 = 'QWERTYUIOP'.split('');
    List<String> row2 = 'ASDFGHJKL'.split('');
    List<String> row3 = ['DEL', 'Z', 'X', 'C', 'V','B', 'N', 'M', 'SUBMIT'];

    return GetBuilder<GameViewModel>(builder: (controller) {
      return Column(
        children: [
          const GameBoard(),
          const SizedBox(height: 40.0),
          buildKeyboardRow(row1, controller),
          const SizedBox(height: 10.0),
          buildKeyboardRow(row2, controller),
          const SizedBox(height: 10.0),
          buildKeyboardRow(row3, controller),
          const SizedBox(height: 10.0),
        ],
      );
    });
  }

  Row buildKeyboardRow(List<String> row, GameViewModel controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: row.map((key) {
        return InkWell(
          onTap: () => controller.onKeyTap(key),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade300,
            ),
            child: Text(
              key,
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }
}

