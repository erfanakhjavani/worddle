import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_viewmodel.dart';


class GameBoard extends StatelessWidget {
  GameBoard({super.key});

  final GameViewModel viewModel = Get.find<GameViewModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: viewModel.worddleBoard.map((row) {
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
                default:
                  color = Colors.grey.shade800;
              }

              return Container(
                padding: const EdgeInsets.all(16.0),
                width: 64.0,
                height: 64.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: color,
                ),
                child: Center(
                  child: Text(
                    letter.letter ?? '',
                    style: Get.textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
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
