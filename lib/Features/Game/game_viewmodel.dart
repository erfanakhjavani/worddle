import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'game_model.dart';

class GameViewModel extends GetxController {
  // نمونه از مدل بازی
  final WorddleGame _game = WorddleGame();

  // متغیرهای واکتیو
  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;  // مپ برای ذخیره رنگ هر حرف

  @override
  void onInit() {
    super.onInit();
    // مقداردهی اولیه صفحه بازی
    worddleBoard.value = _game.worddleBoard;
    wordMessage.value = _game.gameMessage;
  }

  void insertLetter(String letter) {
    if (currentLetter.value < 5 && currentRow.value < 5) {
      _game.insertWord(
        currentLetter.value,
        Letter(letter, 0),
        currentRow.value,
      );
      currentLetter.value++;
      worddleBoard.refresh(); // به‌روزرسانی UI
    }
  }

  void deleteLetter() {
    if (currentLetter.value > 0 && currentRow.value < 5) {
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
    if (currentLetter.value < 5 || currentRow.value >= 5) return;

    String guess = _game.worddleBoard[currentRow.value].map((e) => e.letter).join();

    if (!_game.checkWord(guess)) {
      wordMessage.value = 'the word does not exist try again';
      return;
    }

    for (int i = 0; i < 5; i++) {
      await animateLetterFlip(i); // اجرای انیمیشن فلیپ برای هر حرف
      checkLetter(i, guess); // چک کردن حرف بعد از اتمام انیمیشن
    }

    worddleBoard.refresh();

    if (guess == _game.gameGuess) {
      wordMessage.value = 'Congratulations 🎉';
    } else if (currentRow.value >= 4) {
      wordMessage.value = 'Game over! Correct word: ${_game.gameGuess}';
    }

    currentRow.value++;
    currentLetter.value = 0;
  }

  Future<void> animateLetterFlip(int index) async {
    _game.worddleBoard[currentRow.value][index].code = -1; // تنظیم کد به یک مقدار موقت برای نمایش انیمیشن فلیپ
    worddleBoard.refresh();
    await Future.delayed(500.ms); // تاخیر برای انیمیشن فلیپ
  }

  void checkLetter(int index, String guess) {
    String char = guess[index];
    if (_game.gameGuess.contains(char)) {
      if (_game.gameGuess[index] == char) {
        _game.worddleBoard[currentRow.value][index].code = 1;
        letterColors[char] = Colors.green; // رنگ سبز برای حرف صحیح در جای صحیح
      } else {
        _game.worddleBoard[currentRow.value][index].code = 2;
        letterColors[char] = Colors.amber.shade400; // رنگ زرد برای حرف صحیح در جای اشتباه
      }
    } else {
      _game.worddleBoard[currentRow.value][index].code = 3;
      letterColors[char] = Colors.grey.shade700; // به‌روزرسانی رنگ حرف
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
    letterColors.clear(); // پاک کردن وضعیت رنگ‌ها برای شروع بازی جدید
  }
}

