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

  void submitGuess() {
    if (currentLetter.value < 5 || currentRow.value >= 5) return;

    String guess = _game.worddleBoard[currentRow.value]
        .map((e) => e.letter)
        .join();

    if (!_game.checkWord(guess)) {
      wordMessage.value = "the word does not exist try again";
      return;
    }

    if (guess == _game.gameGuess) {
      wordMessage.value = "Congratulations 🎉";
      for (var letter in _game.worddleBoard[currentRow.value]) {
        letter.code = 1;
      }
      worddleBoard.refresh();
      return;
    } else {
      for (int i = 0; i < guess.length; i++) {
        String char = guess[i];
        if (_game.gameGuess.contains(char)) {
          if (_game.gameGuess[i] == char) {
            _game.worddleBoard[currentRow.value][i].code = 1;
          } else {
            _game.worddleBoard[currentRow.value][i].code = 2;
          }
        }
      }
      worddleBoard.refresh();
      wordMessage.value = "";
      currentRow.value++;
      currentLetter.value = 0;
    }

    // بررسی پایان بازی
    if (currentRow.value >= 5) {
      wordMessage.value = 'Game over! Correct word:${_game.gameGuess}';
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
  }
}
