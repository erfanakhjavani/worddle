import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../Core/Constants/keyboard.dart';
import 'game_model.dart';

class GameViewModel extends GetxController with GetTickerProviderStateMixin {
  //! Wordle game instance
  late WorddleGame game;

  //! Observable variables for game status and UI updates
  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;
  var isGameOver = false.obs;
  var isFarsi = false.obs;
  late AnimationController lottieController;
  var helpClickCount = 0.obs;
  late AnimationController popperController;
  var isCorrectGuess = false.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    //! AnimationController for popper effect
    popperController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    //! Lottie animation controller setup
    lottieController = AnimationController(
      vsync: this,
      duration: GetNumUtils(2).seconds,
    );

    //! Timer to periodically reset and forward the lottie animation every 6 seconds
    timer = Timer.periodic(const Duration(seconds: 6), (Timer t) {
      lottieController.reset();
      lottieController.forward();
    });
  }

  @override
  void onClose() {
    //! Dispose of the animation controllers and timer when the controller is closed
    lottieController.dispose();
    popperController.dispose();
    timer?.cancel();
    super.onClose();
  }

  //! Initialize the game with a given word length and max chances
  Future<void> initializeGame(int wordLength, int maxChances, {bool isFarsiGame = false}) async {
    isFarsi.value = isFarsiGame;
    game = WorddleGame(wordLength: wordLength, maxChances: maxChances, isFarsi: isFarsiGame);

    try {
      await game.initGame(); //* Initialize the game
      game.setupBoard(); //*Setup the initial game board
      worddleBoard.value = game.worddleBoard; //* Assign the board to the observable list
      wordMessage.value = game.gameMessage; //* Set the initial message
      isGameOver.value = false; //* Reset the game over flag
      helpClickCount.value = 0; //* Reset the help click count
      print('worddle is:  ${game.gameGuess}');
    } catch (e) {
      //! Error handling in case game initialization fails
      wordMessage.value = 'Error starting game: ${e.toString()}';
    }
  }

  //! Reset the game and reinitialize it
  void resetGame({required bool isFarsi}) async {
    await initializeGame(game.wordLength, game.maxChances, isFarsiGame: isFarsi);

    //* Reset the keyboard and board positions
    currentRow.value = 0;
    currentLetter.value = 0;

    //* Clear and refresh the letter colors for the keyboard
    letterColors.clear();

    //* Refresh the game board
    worddleBoard.refresh();
  }

  //! Insert a letter into the current row of the game board
  void insertLetter(String letter) {
    //* Condition to check if the game is ongoing and the letter count is within the allowed range
    if (!isGameOver.value && currentLetter.value < game.wordLength && currentRow.value < game.maxChances) {
      //* Insert the letter at the current position on the board
      game.insertWord(
        currentLetter.value,
        Letter(letter, 0),
        currentRow.value,
      );
      //* Move to the next letter position
      currentLetter.value++;
      //* Refresh the board to display the updated letters
      worddleBoard.refresh();
    }
  }

  //! Remove the last inserted letter
  void deleteLetter() {
    //* Condition to ensure the game is not over and there are letters to delete
    if (!isGameOver.value && currentLetter.value > 0 && currentRow.value < game.maxChances) {
      //* Move back one position to delete the letter
      currentLetter.value--;
      //* Remove the letter from the board
      game.insertWord(
        currentLetter.value,
        Letter('', 0), //* Empty letter indicates removal
        currentRow.value,
      );
      //* Refresh the board to update the view after deletion
      worddleBoard.refresh();
    }
  }

  //! Submit the current guess and check it against the correct word
  void submitGuess() async {
    wordMessage.value = ''; //* Reset the word message

    //* Conditions to check if the game is over or the guess is incomplete
    if (isGameOver.value || currentLetter.value < game.wordLength || currentRow.value >= game.maxChances) return;

    String guess = game.worddleBoard[currentRow.value].map((e) => e.letter).join(); //* Build the guess from the current row

    //! Check if the guessed word exists
    if (!game.checkWord(guess)) {
      wordMessage.value = 'The word does not exist. Try again.'.tr;
      return;
    }

    //! Flip animation for each letter in the row
    for (int i = 0; i < game.wordLength; i++) {
      await animateLetter(i); //* Animate the letter flip
      checkLetter(i, guess); //* Check if the letter is correct or in the word
    }

    //* Refresh the game board after submitting the guess
    worddleBoard.refresh();

    //! Check if the guess is correct
    if (guess == game.gameGuess) {
      wordMessage.value = 'Congratulations 🎉'.tr;
      isGameOver.value = true;
      isCorrectGuess.value = true;
      popperController.forward(from: 0); //* Play the popper animation for winning
    } else if (currentRow.value >= game.maxChances - 1) {
      //! If out of chances, display the correct word
      wordMessage.value = 'Game over! Correct word:'.tr;
      wordMessage.value += game.gameGuess;
      isGameOver.value = true;
    }

    currentRow.value++; //* Move to the next row
    currentLetter.value = 0; //* Reset the letter position
  }

  //! Animate the letter flip effect for a specific index
  Future<void> animateLetter(int index) async {
    game.worddleBoard[currentRow.value][index].code = -1; //* Mark the letter for animation
    worddleBoard.refresh(); //* Refresh the board to show the animation

    //! Delay to allow the flip animation to display
    await Future.delayed(600.ms);
  }

  //! Check if the letter is in the correct position or the word
  void checkLetter(int index, String guess) {
    String char = guess[index];

    //! Check if the letter is in the correct position or exists in the word
    if (game.gameGuess.contains(char)) {
      if (game.gameGuess[index] == char) {
        game.worddleBoard[currentRow.value][index].code = 1; //* Correct position
        letterColors[char] = Colors.green;
      } else {
        game.worddleBoard[currentRow.value][index].code = 2; //* Correct letter, wrong position
        letterColors[char] = Colors.amber.shade400;
      }
    } else {
      game.worddleBoard[currentRow.value][index].code = 3; //* Incorrect letter
      letterColors[char] = Colors.grey.shade700;
    }
  }

  //! Disable random keys after help button is clicked
  void disableRandomKeys() {
    //* Do nothing if help has been clicked more than twice
    if (helpClickCount.value >= 2) {
      return;
    }

    //! Collect all keys from the keyboard
    List<String> allKeys = isFarsi.value
        ? [...row1Farsi, ...row2Farsi, ...row3Farsi]
        : [...row1English, ...row2English, ...row3English];

    //! Remove keys from the target word and special keys like DEL and DO
    String targetWord = game.gameGuess;
    allKeys.removeWhere((key) => targetWord.contains(key) || key == 'DEL' || key == 'DO');

    helpClickCount.value++; // Increment help click count

    //! Calculate how many keys to disable based on the click count
    int disableCount = ((allKeys.length / 6) * helpClickCount.value).round();

    //* Ensure we don't disable more keys than available
    disableCount = disableCount > allKeys.length ? allKeys.length : disableCount;

    //! Shuffle the keys and pick random ones to disable
    allKeys.shuffle();
    List<String> disabledKeys = allKeys.take(disableCount).toList();

    //! Disable the selected keys by changing their color
    for (String key in disabledKeys) {
      letterColors[key] = Colors.grey.shade500;
    }

    //! Refresh the keyboard to reflect the changes
    worddleBoard.refresh();
  }

  //! Triggered when the help button is clicked
  void onHelpClicked() {
    //* Disable random keys if the game is not over
    if (!isGameOver.value) {
      disableRandomKeys();
    }
  }
}
