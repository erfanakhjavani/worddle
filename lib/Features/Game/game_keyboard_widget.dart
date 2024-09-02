import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_viewmodel.dart';

class GameKeyboard extends StatelessWidget {
  GameKeyboard({super.key});

  final GameViewModel viewModel = Get.find<GameViewModel>();

  final List<String> row1 = 'QWERTYUIOP'.split('');
  final List<String> row2 = 'ASDFGHJKL'.split('');
  final List<String> row3 = ['DEL', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DO'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rowOfKeyboard(row1),
        const SizedBox(height: 10.0),
        rowOfKeyboard(row2),
        const SizedBox(height: 10.0),
        rowOfKeyboard(row3),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget rowOfKeyboard(List<String> row) {
    return Row(
      children: row.map((e) {
        return Expanded(
          flex: (e == 'DEL' || e == 'DO') ? 2 : 1, // افزایش سایز کلیدهای "DEL" و "DO"
          child: InkWell(
            onTap: () {
              if (e == 'DEL') {
                viewModel.deleteLetter();
              } else if (e == 'DO') {
                viewModel.submitGuess();
              } else {
                viewModel.insertLetter(e);
              }
            },
            child: Obx(() {
              Color keyColor = viewModel.letterColors[e] ?? Colors.blueGrey.shade300;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                padding: const EdgeInsets.only(top: 12,bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: keyColor,
                ),
                child: Center(
                  child: Text(
                    e,
                    style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        );
      }).toList(),
    );
  }
}
