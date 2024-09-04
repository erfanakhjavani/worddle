import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'game_model.dart';

class GameViewModel extends GetxController {
  late final WorddleGame game;


  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;
  var isGameOver = false.obs;



  @override
  void onInit() async {
    super.onInit();
    try {
      await game.initGame();
      game.setupBoard();
      worddleBoard.value = game.worddleBoard;
      wordMessage.value = game.gameMessage;
      print(game.gameGuess);
    } catch (e) {
      wordMessage.value = 'Error initializing game: ${e.toString()}';
    }
  }

  @override
  void dispose() async{
    super.dispose();
    await game.initGame();
    game.setupBoard();
    worddleBoard.value = game.worddleBoard;
    wordMessage.value = game.gameMessage;
  }

  void insertLetter(String letter) {
    if (!isGameOver.value && currentLetter.value < game.wordLength  && currentRow.value < game.wordLength + 1) {
      game.insertWord(
        currentLetter.value,
        Letter(letter, 0),
        currentRow.value,
      );
      currentLetter.value++;
      worddleBoard.refresh();
    }
  }

  void deleteLetter() {
    if (!isGameOver.value && currentLetter.value > 0 && currentRow.value < game.maxChances) {
      currentLetter.value--;
      game.insertWord(
        currentLetter.value,
        Letter('', 0),
        currentRow.value,
      );
      worddleBoard.refresh();
    }
  }

  void submitGuess() async {
    wordMessage.value = '';
    if (isGameOver.value || currentLetter.value < game.wordLength || currentRow.value >= game.maxChances) return;


    String guess = game.worddleBoard[currentRow.value].map((e) => e.letter).join();


    if (!game.checkWord(guess)) {
      wordMessage.value = 'the word does not exist try again';
      return;
    }

    // انیمیشن فلیپ برای هر حرف در ردیف
    for (int i = 0; i < game.wordLength; i++) {
      await animateLetter(i);
      checkLetter(i, guess);
    }

    // تازه‌سازی جدول بازی
    worddleBoard.refresh();

    if (guess == game.gameGuess) {
      wordMessage.value = 'Congratulations 🎉';
      isGameOver.value = true;
    } else if (currentRow.value >= game.maxChances - 1) {
      wordMessage.value = 'Game over! Correct word: ${game.gameGuess}';
      isGameOver.value = true;

    }

    currentRow.value++;
    currentLetter.value = 0;
  }

  Future<void> animateLetter(int index) async {
    game.worddleBoard[currentRow.value][index].code = -1;
    worddleBoard.refresh();

    // تاخیر برای نمایش انیمیشن فلیپ
    await Future.delayed(600.ms);
  }

  void checkLetter(int index, String guess) {
    String char = guess[index];
    if (game.gameGuess.contains(char)) {
      if (game.gameGuess[index] == char) {
        game.worddleBoard[currentRow.value][index].code = 1;
        letterColors[char] = Colors.green;
      } else {
        game.worddleBoard[currentRow.value][index].code = 2;
        letterColors[char] = Colors.amber.shade400;
      }
    } else {
      game.worddleBoard[currentRow.value][index].code = 3;
      letterColors[char] = Colors.grey.shade700;
    }
  }
}


