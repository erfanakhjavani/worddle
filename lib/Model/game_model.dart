import 'dart:math';

class WorddleGame {
  static String gameMessage = '';
  static String gameGuess = '';
  static List<String> wordList = [
    'WORLD',
    'FIGHT',
    'BRAIN',
    'PLANE',
    'EARTH',
    'ROBOT'
  ];

  static void initGame() {
    final random = Random();
    int index = random.nextInt(wordList.length);
    gameGuess = wordList[index];
  }

  static bool checkWord(String word) {
    return wordList.contains(word);
  }

  static List<Letter> worddleRow = List.generate(5, (index) => Letter('', 0));
  List<List<Letter>> worddleBoard = List.generate(5, (index) => List.generate(5, (index) => Letter('', 0)));

  void insertWord(int index, Letter word) {
    worddleBoard[rowId][index] = word;
  }

  int rowId = 0;
  int letterID = 0;
}

class Letter {
  String? letter;
  int code = 0;
  Letter(this.letter, this.code);
}
