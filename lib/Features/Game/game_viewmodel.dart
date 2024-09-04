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
  var isGameOver = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _game.initGame(); // انتظار برای بارگذاری دیکشنری
    worddleBoard.value = _game.worddleBoard;
    wordMessage.value = _game.gameMessage;
    print('worddle is : ${_game.gameGuess}');
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
    wordMessage.value = '';
    // اگر بازی تمام شده یا کلمه کامل نشده باشد یا ردیف پر شده باشد، تابع خروج می‌کند
    if (isGameOver.value || currentLetter.value < 5 || currentRow.value >= 5) return;

    // استخراج کلمه‌ی حدس زده شده
    String guess = _game.worddleBoard[currentRow.value].map((e) => e.letter).join();

    // بررسی وجود کلمه در لیست کلمات معتبر
    if (!_game.checkWord(guess)) {
      wordMessage.value = 'the word does not exist try again';
      return;
    }

    // انیمیشن فلیپ برای هر حرف در ردیف
    for (int i = 0; i < 5; i++) {
      await animateLetter(i);  // اجرای انیمیشن فلیپ برای هر حرف
      checkLetter(i, guess);   // بررسی وضعیت حرف پس از انیمیشن
    }

    // تازه‌سازی جدول بازی
    worddleBoard.refresh();

    // بررسی اینکه آیا کلمه به درستی حدس زده شده یا بازی به پایان رسیده است
    if (guess == _game.gameGuess) {
      wordMessage.value = 'Congratulations 🎉';
      isGameOver.value = true;
    } else if (currentRow.value >= 4) {
      wordMessage.value = 'Game over! Correct word: ${_game.gameGuess}';
      isGameOver.value = true;

    }

    // انتقال به ردیف بعدی و بازنشانی شماره حروف
    currentRow.value++;
    currentLetter.value = 0;
  }

  Future<void> animateLetter(int index) async {
    // تنظیم وضعیت انیمیشن برای حرف فعلی
    _game.worddleBoard[currentRow.value][index].code = -1;
    worddleBoard.refresh();

    // تاخیر برای نمایش انیمیشن فلیپ
    await Future.delayed(600.ms);
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


