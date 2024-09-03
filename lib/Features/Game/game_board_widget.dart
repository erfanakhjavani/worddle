import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_viewmodel.dart';


import 'package:flutter_animate/flutter_animate.dart'; // اضافه کردن این ایمپورت

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
                case 3:
                  color = Colors.grey.shade700;
                  break;
                default:
                  color = Colors.blueGrey.shade300;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 64.0,
                height: 64.0,
                margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: color,
                ),
                child: Center(
                  child: Text(
                    letter.letter ?? '',
                    style: Get.textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate()
                  .flipH(duration: 1000.ms); // اجرای انیمیشن فلیپ
            }).toList(),
          );
        }).toList(),
      );
    });
  }
}


