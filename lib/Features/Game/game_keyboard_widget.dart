import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Constants/keyboard.dart';
import 'game_viewmodel.dart';

class GameKeyboard extends StatelessWidget {
  GameKeyboard({super.key});

  final GameViewModel viewModel = Get.find<GameViewModel>();
  static const double spacing = 10.0;



  @override
  Widget build(BuildContext context) {
    bool isFarsi = viewModel.isFarsi.value;

    // انتخاب حروف کیبورد بر اساس زبان
    final rows = [
      isFarsi ? row1Farsi : row1English,
      isFarsi ? row2Farsi : row2English,
      isFarsi ? row3Farsi : row3English,
    ];

    return Directionality(
      textDirection: isFarsi ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          for (var row in rows) ...[
            buildKeyboardRow(row),
            const SizedBox(height: spacing),
          ],
        ],
      ),
    );
  }

  Widget buildKeyboardRow(List<String> row) {
    return Row(
      children: row.map((key) => buildKey(key)).toList(),
    );
  }

  Widget buildKey(String key) {
    return Expanded(
      flex: (key == 'DEL' || key == 'DO') ? 2 : 1,
      child: InkWell(
        onTap: () => onKeyTap(key),
        child: Obx(() {
          return buildKeyContainer(key);
        }),
      ),
    );
  }

  void onKeyTap(String key) {
    if (key == 'DEL') {
      viewModel.deleteLetter();
    } else if (key == 'DO') {
      viewModel.submitGuess();
    } else {
      viewModel.insertLetter(key);
    }
  }

  Widget buildKeyContainer(String key) {
    Color keyColor = viewModel.letterColors[key] ?? Colors.blueGrey.shade300;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: keyColor,
      ),
      child: Center(
        child: key == 'DEL'
            ? const Icon(Icons.backspace_outlined, color: Colors.white)
            : key == 'DO'
            ? const Icon(Icons.check_circle, color: Colors.white)
            : Text(key, style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white)),
      ),
    );
  }
}
