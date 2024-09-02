import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_viewmodel.dart';

class GameKeyboard extends StatelessWidget {
  GameKeyboard({Key? key}) : super(key: key);

  final GameViewModel viewModel = Get.find<GameViewModel>();

  final List<String> row1 = 'QWERTYUIOP'.split("");
  final List<String> row2 = 'ASDFGHJKL'.split("");
  final List<String> row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: row.map((e) {
        return InkWell(
          onTap: () {
            if (e == "DEL") {
              viewModel.deleteLetter();
            } else if (e == "SUBMIT") {
              viewModel.submitGuess();
            } else {
              viewModel.insertLetter(e);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blueGrey.shade300,
            ),
            child: Text(
              e,
              style:
              Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

}
