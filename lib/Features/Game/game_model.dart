import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class WorddleGame {
  String gameMessage = '';
  String gameGuess = '';
  late List<String> wordList; // حذف لیست پیش‌فرض و استفاده از late

  WorddleGame() {
    initGame();
  }

  Future<void> initGame() async {
    Set<String> dictionary = await generateDictionary();
    wordList = dictionary.toList();

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



Future<Set<String>> generateDictionary() async {
  String dicContents = await rootBundle.loadString("assets/All.txt");
  Set<String> database = {};

  // اضافه کردن فقط کلمات پنج حرفی به دیکشنری
  LineSplitter.split(dicContents).forEach((line) {
    if (line.trim().length == 5) {
      database.add(line.trim().toUpperCase());
    }
  });

  return database;
}