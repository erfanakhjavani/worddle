import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'game_viewmodel.dart';

class GameBoard extends GetView<GameViewModel> {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Obx(() {
      //! Checking language and setting text direction
      return Directionality(
        textDirection: controller.isFarsi.value ? TextDirection.rtl : TextDirection.ltr, //* RTL for Farsi, LTR for others
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //* Centering the board
          children: controller.worddleBoard.map((row) {
            //! Mapping each row to a row of letters
            return Row(
              mainAxisAlignment: MainAxisAlignment.center, //* Centering letters in the row
              children: row.map((letter) {
                //! Determine the color based on the letter code
                Color color;
                switch (letter.code) {
                  case 1:
                    color = Colors.green; //* Green for correct letters
                    break;
                  case 2:
                    color = Colors.amber.shade400; //* Yellow for misplaced letters
                    break;
                  case 3:
                    color = Colors.grey.shade700; //* Grey for wrong letters
                    break;
                  default:
                    color = Colors.blueGrey.shade300; //* Default color
                }

                //! Applying animations and styling for each letter box
                return Animate(
                  effects: letter.code == -1
                      ? [ShimmerEffect(duration: 600.ms)] //* Shimmer effect for special cases
                      : [],
                  child: AnimatedContainer(
                    duration: 600.ms, //* Smooth transition for color change
                    width: width / (controller.game.wordLength + 3.3), //* Dynamic width based on word length
                    height: height / (controller.game.wordLength + 12.8), //* Dynamic height based on screen size
                    margin: EdgeInsets.symmetric(vertical: width * 0.01, horizontal: height * 0.005), //* Dynamic margins
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), //* Rounded corners
                      color: color, //* Color based on letter code
                    ),
                    child: Center(
                      child: Text(
                        letter.letter ?? '', //* Display the letter
                        style: Get.textTheme.headlineMedium!.copyWith(
                          fontSize: controller.game.wordLength + 25, //* Adjust font size based on word length
                          color: Colors.white, //* White text color
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      );
    });
  }
}

