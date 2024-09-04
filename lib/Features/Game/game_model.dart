import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class WorddleGame {
  String gameMessage = '';
  String gameGuess = '';
  late List<String> wordList;
  final int wordLength;
  final int maxChances;

  WorddleGame({required this.wordLength, required this.maxChances}) {
    initGame();
  }

  Future<void> initGame() async {
    Set<String> dictionary = await generateDictionary(wordLength: wordLength);
    wordList = dictionary.where((word) => word.length == wordLength).toList();

    // بررسی اینکه wordList خالی نباشد
    if (wordList.isEmpty) {
      throw Exception('No words found with length $wordLength');
    }

    final random = Random();
    int index = random.nextInt(wordList.length); // اکنون مطمئن هستیم که wordList خالی نیست
    gameGuess = wordList[index];
  }

  bool checkWord(String word) {
    return wordList.contains(word);
  }

  List<Letter> worddleRow = [];
  late List<List<Letter>> worddleBoard;

  void setupBoard() {
    worddleRow = List.generate(wordLength, (index) => Letter('', 0));
    worddleBoard = List.generate(
      maxChances,
          (index) => List.generate(wordLength, (index) => Letter('', 0)),
    );
  }

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



Future<Set<String>> generateDictionary({required int wordLength}) async {
  try {
    // بارگیری محتوای فایل دیکشنری
    String dicContents = await rootBundle.loadString("assets/All.txt");
    Set<String> database = {};

    // تقسیم محتوا به خطوط و افزودن کلمات با طول مشخص به دیکشنری
    LineSplitter.split(dicContents).forEach((line) {
      String word = line.trim().toUpperCase();
      if (word.length == wordLength) {
        database.add(word);
      }
    });

    return database;
  } catch (e) {
    // مدیریت خطا
    throw Exception('Failed to load dictionary: $e');
  }
}