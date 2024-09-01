// views/game_board.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/game_viewmodel.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<GameViewModel>(builder: (controller){
     return Column(
        children: controller.worddleBoard.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((letter) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                width: 64.0,
                height: 64.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: letter.code == 0
                      ? Colors.grey.shade800
                      : letter.code == 1
                      ? Colors.green
                      : Colors.amber.shade400,
                ),
                child: Center(
                  child: Text(
                    letter.letter!,
                    style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: 25),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      );
    });
  }
}
