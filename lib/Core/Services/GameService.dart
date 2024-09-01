


import '../../Model/game_model.dart';

class GameService {
  final WorddleGame _game = WorddleGame();

  List<List<Letter>> get worddleBoard => _game.worddleBoard;

  void initGame() {
    WorddleGame.initGame();
  }

  void insertWord(int index, Letter word) {
    _game.insertWord(index, word);
  }

  bool checkWord(String word) {
    return WorddleGame.checkWord(word);
  }
}

