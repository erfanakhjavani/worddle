import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../Core/Constants/keyboard.dart';
import 'game_model.dart';

class GameViewModel extends GetxController with GetTickerProviderStateMixin {
  late WorddleGame game;

  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;
  var isGameOver = false.obs;
  var isFarsi = false.obs;
  late AnimationController lottieController;
  var helpClickCount = 0.obs; // شمارنده برای کلیک‌های دکمه کمک
  late AnimationController popperController;
  var isCorrectGuess = false.obs;


  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    popperController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // AnimationController
    lottieController = AnimationController(
      vsync: this,
      duration: GetNumUtils(2).seconds,
    );


    timer = Timer.periodic(const Duration(seconds: 6), (Timer t) {
      lottieController.reset();
      lottieController.forward();
    });
  }

  @override
  void onClose() {
    // انیمیشن و تایمر را پاکسازی می‌کنیم
    lottieController.dispose();
    popperController.dispose();
    timer?.cancel();
    super.onClose();
  }







  Future<void> initializeGame(int wordLength, int maxChances, {bool isFarsiGame = false}) async {
    isFarsi.value = isFarsiGame;
    game = WorddleGame(wordLength: wordLength, maxChances: maxChances, isFarsi: isFarsiGame);

    try {
      await game.initGame();
      game.setupBoard();
      worddleBoard.value = game.worddleBoard;
      wordMessage.value = game.gameMessage;
      isGameOver.value = false;
      helpClickCount.value = 0;
      print('worddle is:  ${game.gameGuess}');
    } catch (e) {
      wordMessage.value = 'خطا در شروع بازی: ${e.toString()}';
    }
  }

  // متد ریست بازی
  void resetGame({required bool isFarsi}) async {
    await initializeGame(game.wordLength, game.maxChances,isFarsiGame: isFarsi);

    // ریست کردن کیبورد و جدول بازی
    currentRow.value = 0;
    currentLetter.value = 0;

    // ریست کردن رنگ‌های کیبورد
    letterColors.clear(); // خالی کردن رنگ‌های قبلی

    worddleBoard.refresh(); // به روز رسانی جدول بازی
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
      wordMessage.value = 'the word does not exist try again'.tr;
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
      wordMessage.value = 'Congratulations 🎉'.tr;
      isGameOver.value = true;
      isCorrectGuess.value = true;
      popperController.forward(from: 0); // اجرای انیمیشن
    } else if (currentRow.value >= game.maxChances - 1) {
      wordMessage.value = 'Game over! Correct word:'.tr;
      wordMessage.value += game.gameGuess;
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

  // تابع برای غیرفعال‌سازی تصادفی دکمه‌ها
  void disableRandomKeys() {
    // اگر کاربر بیش از دو بار کلیک کرده باشد، هیچ کاری انجام نده
    if (helpClickCount.value >= 2) {
      return;
    }

    // جمع‌آوری تمام حروف کیبورد
    List<String> allKeys = isFarsi.value
        ? [...row1Farsi, ...row2Farsi, ...row3Farsi]
        : [...row1English, ...row2English, ...row3English];

    // حذف حروف موجود در کلمه هدف و دکمه‌های DEL و DO از لیست
    String targetWord = game.gameGuess;
    allKeys.removeWhere((key) => targetWord.contains(key)
        || key == 'DEL' || key == 'DO'
    );

    // افزایش تعداد دفعات کلیک
    helpClickCount.value++;

    // محاسبه چند چهارم از کل دکمه‌ها باید غیرفعال شوند
    int disableCount = ((allKeys.length / 6) * helpClickCount.value).round();

    // مطمئن شدن که بیش از همه دکمه‌ها غیر فعال نشوند
    disableCount = disableCount > allKeys.length ? allKeys.length : disableCount;

    // انتخاب تصادفی disableCount دکمه که غیرفعال شوند
    allKeys.shuffle(); // مخلوط کردن لیست
    List<String> disabledKeys = allKeys.take(disableCount).toList();

    // تغییر رنگ دکمه‌ها به خاکستری و جلوگیری از استفاده دوباره
    for (String key in disabledKeys) {
      letterColors[key] = Colors.grey.shade500;
    }

    // تازه‌سازی کیبورد برای نمایش تغییرات
    worddleBoard.refresh();
  }



  // تابعی که هنگام کلیک روی دکمه help فراخوانی می‌شود
  void onHelpClicked() {
    if (!isGameOver.value) {
      disableRandomKeys();
    }
  }


}


