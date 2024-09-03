import 'dart:math';

class WorddleGame {
  String gameMessage = '';
  String gameGuess = '';
  List<String> wordList = [
    'WORLD',
    'FIGHT',
    'BRAIN',
    'PLANE',
    'EARTH',
    'ROBOT'
  ];

  WorddleGame() {
    initGame();
  }

  void initGame() {
    final random = Random();
    int index = random.nextInt(wordList.length);
    gameGuess = wordList[index];
  }

  bool checkWord(String word) {
    return wordList.contains(word);
  }

  List<Letter> worddleRow = List.generate(5, (index) => Letter('', 0));
  List<List<Letter>> worddleBoard = List.generate(
    5,
        (index) => List.generate(5, (index) => Letter('', 0)),
  );

  void insertWord(int index, Letter letter, int rowId) {
    worddleBoard[rowId][index] = letter;
  }

  int rowId = 0;
  int letterID = 0;
}

class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);
}