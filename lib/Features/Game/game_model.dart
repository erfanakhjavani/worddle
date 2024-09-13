import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class WorddleGame {
  String gameMessage = '';
  String gameGuess = '';
  late List<String> wordList;
  final int wordLength;
  final int maxChances;
  final bool isFarsi; // افزودن پرچم برای مشخص کردن زبان فارسی

  WorddleGame({required this.wordLength, required this.maxChances, this.isFarsi = false}) {
    initGame();
  }

  Future<void> initGame() async {
    if (isFarsi) {
      // استفاده از لیست کلمات فارسی
      Set<String> dictionary = await generateDictionary(wordLength: wordLength,lang: 'farsi');
      wordList = dictionary.where((word) => word.length == wordLength).toList();
    } else {
      // انگلیسی
      Set<String> dictionary = await generateDictionary(wordLength: wordLength,lang: 'english');
      wordList = dictionary.where((word) => word.length == wordLength).toList();
    }

    if (wordList.isEmpty) {
      throw Exception('هیچ کلمه‌ای با طول $wordLength پیدا نشد');
    }

    final random = Random();
    int index = random.nextInt(wordList.length);
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



Future<Set<String>> generateDictionary({required int wordLength,required String lang}) async {
  try {
    // بارگیری محتوای فایل دیکشنری
    String dicContents = await rootBundle.loadString('assets/dict/$lang.txt');
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