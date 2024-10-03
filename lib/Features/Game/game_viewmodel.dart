import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import '../../Core/Constants/keyboard.dart';
import 'game_model.dart';

class GameViewModel extends GetxController with GetTickerProviderStateMixin {
  late WorddleGame game;

  // Observable properties
  var wordMessage = ''.obs;
  var worddleBoard = <List<Letter>>[].obs;
  var currentRow = 0.obs;
  var currentLetter = 0.obs;
  var letterColors = <String, Color>{}.obs;
  var isGameOver = false.obs;
  var isFarsi = false.obs;
  var usePopper = false.obs;
  var helpClickCount = 0.obs;
  var isLoadAds =  false.obs;

  late AnimationController lottieController;
  late AnimationController popperController;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    setupAnimations();
    setupTimer();
  }

  @override
  void onClose() {
    disposeResources();
    super.onClose();
  }


  // Initialize the game
  Future<void> initializeGame(int wordLength, int maxChances, {bool isFarsiGame = false}) async {
    resetGameState(isFarsiR: isFarsiGame);

    game = WorddleGame(wordLength: wordLength, maxChances: maxChances, isFarsi: isFarsiGame);

    try {
      await game.initGame();
      game.setupBoard();
      worddleBoard.assignAll(game.worddleBoard);
      wordMessage.value = game.gameMessage;
      print('worddle is: ${game.gameGuess}');
    } catch (e) {
      wordMessage.value = 'Error starting game: ${e.toString()}';
    }
  }

  // Reset game state
  void resetGameState({required bool isFarsiR}) {
    currentRow.value = 0;
    currentLetter.value = 0;
    letterColors.clear();
    worddleBoard.clear();
    isFarsi.value = isFarsiR;
    isGameOver.value = false;
    usePopper.value = false;
    helpClickCount.value = 0;
  }



  //! Reset the game and reinitialize it
  void resetGame({required bool isFarsi}) async {
    await initializeGame(game.wordLength, game.maxChances, isFarsiGame: isFarsi);
  }

  // Insert a letter into the current row
  void insertLetter(String letter) {
    if (canInsertLetter()) {
      game.insertWord(currentLetter.value, Letter(letter, 0), currentRow.value);
      currentLetter.value++;
      worddleBoard.refresh();
    }
  }

  // Delete the last letter
  void deleteLetter() {
    if (canDeleteLetter()) {
      currentLetter.value--;
      game.insertWord(currentLetter.value, Letter('', 0), currentRow.value); // Clear the letter
      worddleBoard.refresh();
    }
  }

  // Submit the current guess
  void submitGuess() async {
    wordMessage.value = '';
    if (!canSubmitGuess()) return;

    String guess = getCurrentGuess();
    if (!game.checkWord(guess)) {
      wordMessage.value = 'The word does not exist. Try again.'.tr;
      return;
    }

    await animateAndCheckLetters(guess);
    handleGuessResult(guess);
  }

  // Handle the result of a guess
  void handleGuessResult(String guess) {
    if (guess == game.gameGuess) {
      handleCorrectGuess();
    } else if (isOutOfChances()) {
      handleGameOver();
    } else {
      moveToNextRow();
    }
  }

  // Animate letters and check them
  Future<void> animateAndCheckLetters(String guess) async {
    for (int i = 0; i < game.wordLength; i++) {
      await animateLetter(i);
      checkLetter(i, guess);
    }
    worddleBoard.refresh();
  }

  // Handle correct guess
  void handleCorrectGuess() {
    wordMessage.value = 'Congratulations 🎉'.tr;
    usePopper.value = true;
    isGameOver.value = true;
    popperController.forward(from: 0);
  }

  // Handle game over
  void handleGameOver() {
    wordMessage.value = 'Game over! Correct word:'.tr + game.gameGuess;
    isGameOver.value = true;
  }

  // Check if the letter is correct or misplaced
  void checkLetter(int index, String guess) {
    Map<String, int> charCount = countCharacters(game.gameGuess);

    // First pass: mark correct positions
    for (int i = 0; i <= index; i++) {
      if (isCorrectPosition(i, guess)) {
        setCorrectPosition(i, guess[i], charCount);
      }
    }

    // Second pass: mark misplaced or incorrect letters
    for (int i = 0; i <= index; i++) {
      if (game.worddleBoard[currentRow.value][i].code != 1) { // Skip correct letters
        if (isMisplacedLetter(i, guess[i], charCount)) {
          setMisplacedPosition(i, guess[i], charCount);
        } else {
          setIncorrectPosition(i, guess[i]);
        }
      }
    }
  }

  // Helper functions
  bool isCorrectPosition(int index, String guess) => game.gameGuess[index] == guess[index];
  bool isMisplacedLetter(int index, String char, Map<String, int> charCount) => game.gameGuess.contains(char) && charCount[char]! > 0;

  void setCorrectPosition(int index, String char, Map<String, int> charCount) {
    game.worddleBoard[currentRow.value][index].code = 1; // Correct position
    letterColors[char] = Colors.green;
    charCount[char] = charCount[char]! - 1;
  }

  void setMisplacedPosition(int index, String char, Map<String, int> charCount) {
    game.worddleBoard[currentRow.value][index].code = 2; // Wrong position
    letterColors[char] = Colors.amber.shade400;
    charCount[char] = charCount[char]! - 1;
  }

  void setIncorrectPosition(int index, String char) {
    game.worddleBoard[currentRow.value][index].code = 3; // Incorrect letter
    if (letterColors[char] != Colors.green) {
      letterColors[char] = Colors.grey.shade700;
    }
  }

  // Count character occurrences
  Map<String, int> countCharacters(String word) {
    Map<String, int> charCount = {};
    for (var letter in word.split('')) {
      charCount[letter] = (charCount[letter] ?? 0) + 1;
    }
    return charCount;
  }

  // Move to the next row after a guess
  void moveToNextRow() {
    currentRow.value++;
    currentLetter.value = 0;
  }

  // Check if the guess can be submitted
  bool canSubmitGuess() {
    return !isGameOver.value && currentLetter.value == game.wordLength && currentRow.value < game.maxChances;
  }

  // Check if the letter can be inserted
  bool canInsertLetter() {
    return !isGameOver.value && currentLetter.value < game.wordLength && currentRow.value < game.maxChances;
  }

  // Check if the letter can be deleted
  bool canDeleteLetter() {
    return !isGameOver.value && currentLetter.value > 0 && currentRow.value < game.maxChances;
  }

  // Check if the player is out of chances
  bool isOutOfChances() {
    return currentRow.value >= game.maxChances - 1;
  }

  // Animate the letter for a specific index
  Future<void> animateLetter(int index) async {
    game.worddleBoard[currentRow.value][index].code = -1; // Mark the letter for animation
    worddleBoard.refresh(); // Refresh the board to show the animation
    await Future.delayed(const Duration(milliseconds: 600)); // Delay for the animation
  }

  // Get the current guess as a string
  String getCurrentGuess() {
    return game.worddleBoard[currentRow.value].map((e) => e.letter).join();
  }

  // Set up animation controllers
  void setupAnimations() {
    popperController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    lottieController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  // Set up a timer for periodic tasks
  void setupTimer() {
    timer = Timer.periodic(const Duration(seconds: 6), (Timer t) {
      lottieController.reset();
      checkAdLoaded();
      lottieController.forward();
    });
  }

  // Dispose of resources
  void disposeResources() {
    lottieController.dispose();
    popperController.dispose();
    timer?.cancel();
  }

  // Disable random keys after help button is clicked
  void disableRandomKeys() {
    if (helpClickCount.value >= 2) return;

    List<String> allKeys = isFarsi.value
        ? [...row1Farsi, ...row2Farsi, ...row3Farsi]
        : [...row1English, ...row2English, ...row3English];

    String targetWord = game.gameGuess;
    allKeys.removeWhere((key) => targetWord.contains(key) || key == 'DEL' || key == 'DO');

    helpClickCount.value++;
    int disableCount = ((allKeys.length / 6) * helpClickCount.value).round();
    disableCount = disableCount > allKeys.length ? allKeys.length : disableCount;

    allKeys.shuffle();
    List<String> disabledKeys = allKeys.take(disableCount).toList();

    for (String key in disabledKeys) {
      letterColors[key] = Colors.grey.shade500;
    }

    worddleBoard.refresh();
  }

  // Triggered when the help button is clicked
  void onHelpClicked() {
    if (!isGameOver.value) {
      disableRandomKeys();
    }
  }


  Future<void> checkAdLoaded() async {
    if (await Appodeal.isLoaded(AppodealAdType.BannerBottom)) {
      isLoadAds.value = true;
    }
  }

}
