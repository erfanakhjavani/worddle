import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class WorddleGame {
  //! Game status message and target word
  String gameMessage = '';
  String gameGuess = '';

  //! Word list and game settings
  late List<String> wordList;
  final int wordLength;
  final int maxChances;
  final bool isFarsi; //* Flag to determine if it's a Farsi game

  //! Constructor to initialize the game
  WorddleGame({required this.wordLength, required this.maxChances, this.isFarsi = false}) {
    initGame(); //* Initialize the game when the object is created
  }

  //! Initialize the game and load the dictionary based on the language
  Future<void> initGame() async {
    if (isFarsi) {
      //! Load Farsi dictionary
      Set<String> dictionary = await generateDictionary(wordLength: wordLength, lang: 'fa');
      Set<String> dictionary2 = await generateDictionary(wordLength: wordLength, lang: 'fa2');
      wordList = dictionary.union(dictionary2).toList(); //* Combine two dictionaries
    } else {
      //! Load English dictionary
      Set<String> dictionary = await generateDictionary(wordLength: wordLength, lang: 'en');
      wordList = dictionary.toList();
    }

    //! If no words are found for the given length, throw an exception
    if (wordList.isEmpty) {
      throw Exception('No words found with length $wordLength');
    }

    //! Select a random word from the list to be the target word
    final random = Random();
    int index = random.nextInt(wordList.length);
    gameGuess = wordList[index];
  }

  //! Check if the guessed word is in the dictionary
  bool checkWord(String word) {
    return wordList.contains(word);
  }

  //! Row and board setup for the game
  List<Letter> worddleRow = [];
  late List<List<Letter>> worddleBoard;

  //! Setup the board with empty letters
  void setupBoard() {
    worddleRow = List.generate(wordLength, (index) => Letter('', 0)); //* Initialize row with empty letters
    worddleBoard = List.generate(
      maxChances,
          (index) => List.generate(wordLength, (index) => Letter('', 0)), //* Initialize the board with empty letters
    );
  }

  //! Insert a letter into the board at a specific position
  void insertWord(int index, Letter letter, int rowId) {
    worddleBoard[rowId][index] = letter;
  }

  //! Row and letter identifiers
  int rowId = 0;
  int letterID = 0;
}

class Letter {
  //! Letter and its status code (for coloring and validation)
  String? letter;
  int code = 0;

  //! Constructor for the Letter class
  Letter(this.letter, this.code);
}

//! Function to load the dictionary from a text file and filter words by length
Future<Set<String>> generateDictionary({required int wordLength, required String lang}) async {
  try {
    //! Load the dictionary file from assets
    String dicContents = await rootBundle.loadString('assets/dict/$lang.txt');
    Set<String> database = {};

    //! Split the file contents into lines and filter words by the specified length
    LineSplitter.split(dicContents).forEach((line) {
      String word = line.trim().toUpperCase(); //* Trim and convert words to uppercase
      if (word.length == wordLength) {
        database.add(word); //* Add valid words to the set
      }
    });

    return database; //* Return the set of valid words
  } catch (e) {
    //! Error handling in case the dictionary fails to load
    throw Exception('Failed to load dictionary: $e');
  }
}
