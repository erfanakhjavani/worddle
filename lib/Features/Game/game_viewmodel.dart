import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'game_model.dart';

class GameViewModel extends GetxController {
  final WorddleGame _game = WorddleGame();

  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;
  var isGameOver = false.obs; // New variable to track the game state

  @override
  void onInit() {
    super.onInit();
    worddleBoard.value = _game.worddleBoard;
    wordMessage.value = _game.gameMessage;
  }

  @override
  void dispose() {
    super.dispose();
    worddleBoard.value = _game.worddleBoard;
    wordMessage.value = _game.gameMessage;
  }

  void insertLetter(String letter) {
    if (!isGameOver.value && currentLetter.value < 5 && currentRow.value < 5) {
      _game.insertWord(
        currentLetter.value,
        Letter(letter, 0),
        currentRow.value,
      );
      currentLetter.value++;
      worddleBoard.refresh();
    }
  }

  void deleteLetter() {
    if (!isGameOver.value && currentLetter.value > 0 && currentRow.value < 5) {
      currentLetter.value--;
      _game.insertWord(
        currentLetter.value,
        Letter('', 0),
        currentRow.value,
      );
      worddleBoard.refresh();
    }
  }

  void submitGuess() async {
    if (isGameOver.value || currentLetter.value < 5 || currentRow.value >= 5) return;

    String guess = _game.worddleBoard[currentRow.value].map((e) => e.letter).join();

    if (!_game.checkWord(guess)) {
      wordMessage.value = 'the word does not exist try again';
      return;
    }

    for (int i = 0; i < 5; i++) {
      await animateLetterFlip(i);
      checkLetter(i, guess);
    }

    worddleBoard.refresh();

    if (guess == _game.gameGuess) {
      wordMessage.value = 'Congratulations 🎉';
      isGameOver.value = true; // Set the game as over
    } else if (currentRow.value >= 4) {
      wordMessage.value = 'Game over! Correct word: ${_game.gameGuess}';
      isGameOver.value = true; // Set the game as over
    }

    currentRow.value++;
    currentLetter.value = 0;
  }

  Future<void> animateLetterFlip(int index) async {
    _game.worddleBoard[currentRow.value][index].code = -1;
    worddleBoard.refresh();
    await Future.delayed(500.ms);
  }

  void checkLetter(int index, String guess) {
    String char = guess[index];
    if (_game.gameGuess.contains(char)) {
      if (_game.gameGuess[index] == char) {
        _game.worddleBoard[currentRow.value][index].code = 1;
        letterColors[char] = Colors.green;
      } else {
        _game.worddleBoard[currentRow.value][index].code = 2;
        letterColors[char] = Colors.amber.shade400;
      }
    } else {
      _game.worddleBoard[currentRow.value][index].code = 3;
      letterColors[char] = Colors.grey.shade700;
    }
  }

  void resetGame() {
    _game.initGame();
    _game.worddleBoard = List.generate(
      5,
          (index) => List.generate(5, (index) => Letter('', 0)),
    );
    worddleBoard.value = _game.worddleBoard;
    wordMessage.value = '';
    currentRow.value = 0;
    currentLetter.value = 0;
    letterColors.clear();
    isGameOver.value = false; // Reset the game state
  }
}


