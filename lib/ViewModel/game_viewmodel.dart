import 'dart:async';

import 'package:get/get.dart';
import '../Core/Services/GameService.dart';
import '../Model/game_model.dart';

class GameViewModel extends GetxController {
  final GameService _gameService = GameService();

  var gameMessage = ''.obs;
  var letterID = 0.obs;
  var rowId = 0.obs;
  var isGameActive = true.obs; // کنترل فعال بودن بازی

  List<List<Letter>> get worddleBoard => _gameService.worddleBoard;

  @override
  void onInit() {
    super.onInit();
    _gameService.initGame();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void resetGame() {
    _gameService.initGame();
    letterID.value = 0;
    rowId.value = 0;
    gameMessage.value = '';
    isGameActive.value = true; // Re-enable the game
    update();
  }

  void onKeyTap(String key) {
    if (!isGameActive.value) return; // Prevent actions when the game is inactive

    if (key == 'DEL') {
      deleteLetter();
    } else if (key == 'SUBMIT') {
      submitWord();
    } else {
      addLetter(key);
    }
    update();
  }

  void deleteLetter() {
    if (letterID.value > 0) {
      _gameService.insertWord(letterID.value - 1, Letter('', 0));
      letterID.value--;
    }
    update();
  }

  void addLetter(String letter) {
    if (letterID.value < 5) {
      _gameService.insertWord(letterID.value, Letter(letter, 0));
      letterID.value++;
    }
    update();
  }

  void submitWord() {
    if (letterID.value >= 5) {
      String guess = worddleBoard[rowId.value]
          .map((e) => e.letter)
          .join();

      if (_gameService.checkWord(guess)) {
        if (guess == WorddleGame.gameGuess) {
          gameMessage.value = 'Congratulations 🎉';
          worddleBoard[rowId.value].forEach((element) {
            element.code = 1;
          });
          isGameActive.value = false; // Disable the game upon correct guess
        } else {
          updateBoardWithGuess(guess);

          if (rowId.value < 4) { // Check if there are remaining rows
            rowId.value++;
            letterID.value = 0;
          } else {
            gameMessage.value = 'Game Over! You have used all attempts.';
            isGameActive.value = false; // Disable the game after 5 rows
          }
        }
      } else {
        gameMessage.value = 'The word does not exist. Try again.';
      }
    }
    update();
  }

  void updateBoardWithGuess(String guess) {
    for (int i = 0; i < 5; i++) {
      String char = guess[i];
      if (WorddleGame.gameGuess.contains(char)) {
        if (WorddleGame.gameGuess[i] == char) {
          worddleBoard[rowId.value][i].code = 1;
        } else {
          worddleBoard[rowId.value][i].code = 2;
        }
      }
    }
    update();
  }
}
