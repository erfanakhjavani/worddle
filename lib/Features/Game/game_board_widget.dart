import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'game_viewmodel.dart'; // ایمپورت پکیج انیمیشن

class GameBoard extends GetView<GameViewModel> {
  GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.worddleBoard.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((letter) {
              Color color;
              switch (letter.code) {
                case 1:
                  color = Colors.green;
                  break;
                case 2:
                  color = Colors.amber.shade400;
                  break;
                case 3:
                  color = Colors.grey.shade700;
                  break;
                default:
                  color = Colors.blueGrey.shade300;
              }

              return Animate(
                effects: letter.code == -1
                    ? [ShimmerEffect(duration: 600.ms,)]
                    : [],
                child: AnimatedContainer(
                  duration: 600.ms,
                  width: width / (controller.game.wordLength + 3),
                  height: height / (controller.game.wordLength + 13),
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: color,
                  ),
                  child: Center(
                    child: Text(
                      letter.letter ?? '',
                      style: Get.textTheme.headlineMedium!.copyWith(
                        fontSize: controller.game.wordLength + 25,
                        color: Colors.white,
                      ),
                    ),
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

