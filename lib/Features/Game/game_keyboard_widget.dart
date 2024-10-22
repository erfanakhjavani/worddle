import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/helper/check_language_keyboard.dart';
import 'game_viewmodel.dart';

class GameKeyboard extends StatelessWidget {
  GameKeyboard({super.key});

  final GameViewModel viewModel = Get.find<GameViewModel>();
  static const double spacing = 10.0;

  @override
  Widget build(BuildContext context) {

    //! Selecting keyboard rows based on the language
    final rows = languagesKeyboard();

    return  Column(
        children: [
          //! Building rows of the keyboard
          for (var row in rows!) ...[
            buildKeyboardRow(row),
            const SizedBox(height: spacing), //* Adds space between rows
          ],
        ],
      );
  }

  //! Builds a single keyboard row
  Widget buildKeyboardRow(List<String> row) {
    return Row(
      children: row.map((key) => buildKey(key)).toList(), //* Creates keys for each letter in the row
    );
  }

  //! Builds an individual key
  Widget buildKey(String key) {
    return Expanded(
      flex: (key == 'DEL' || key == 'DO') ? 2 : 1, //* Special keys like DEL and DO take double space
      child: InkWell(
        onTap: () => onKeyTap(key), //* Handle key tap
        child: Obx(() {
          return buildKeyContainer(key); //* Updates the key with reactive color changes
        }),
      ),
    );
  }

  //! Handles key taps
  void onKeyTap(String key) {
    if (key == 'DEL') {
      viewModel.deleteLetter(); //* Calls delete letter function
    } else if (key == 'DO') {
      viewModel.submitGuess(); //* Calls submit guess function
    } else {
      viewModel.insertLetter(key); //* Inserts the tapped letter
    }
  }

  //! Builds the visual appearance of a key
  Widget buildKeyContainer(String key) {
    Color keyColor = viewModel.letterColors[key] ?? Colors.blueGrey.shade300; //* Uses reactive colors for keys
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: keyColor, //* Set the key's color
      ),
      child: Center(
        //! Displays icon or letter based on the key
        child: key == 'DEL'
            ? const Icon(Icons.backspace_outlined, color: Colors.white) //* Backspace icon for delete key
            : key == 'DO'
            ? const Icon(Icons.check_circle, color: Colors.white) //* Check icon for submit key
            : Text(key, style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white)), //* Shows the letter
      ),
    );
  }
}

