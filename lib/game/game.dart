// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Features/Game/game_model.dart';
//
//
// class GameViewH extends StatefulWidget {
//   const  GameViewH({super.key});
//
//   @override
//   State<GameViewH> createState() => _GameViewHState();
// }
//
// class _GameViewHState extends State<GameViewH> {
//   final WorddleGame _game = WorddleGame();
//   late String word;
//
//   @override
//   void initState() {
//     super.initState();
//     WorddleGame.initGame();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Worddle',style: Get.textTheme.headlineMedium,),
//           const SizedBox(
//             height: 20,
//           ),
//           GameKeyboard(game: _game,)
//         ],
//       ),
//     );
//   }
// }
// class GameKeyboard extends StatefulWidget {
//   const GameKeyboard({super.key,required this.game});
//
//   final WorddleGame game;
//   @override
//   State<GameKeyboard> createState() => _GameKeyboardState();
// }
//
// class _GameKeyboardState extends State<GameKeyboard> {
//   List row1 = 'QWERTYUIOP'.split("");
//   List row2 = 'ASDFGHJKL'.split("");
//   List row3 = ["DEL", "Z", "X", "C", "V","B", "N", "M", "SUBMIT"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//
//         children: [
//           Text(WorddleGame.gameMessage,),
//           const SizedBox(height: 20.0,),
//           GameBoard(game: widget.game),
//           const SizedBox(height: 40.0,),
//           rowOfKeyboard(row1),
//           const SizedBox(height: 10.0,),
//           rowOfKeyboard(row2),
//           const SizedBox(height: 10.0,),
//           rowOfKeyboard(row3),
//           const SizedBox(height: 10.0,),
//         ]);
//   }
//
//   Row rowOfKeyboard(List row) {
//     return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: row.map((e) {
//           return InkWell(
//             onTap: () {
//               print(e);
//               //! create the delete function
//               if(e == "DEL"){
//                 if(widget.game.letterID > 0){
//                   setState(() {
//                     widget.game.insertWord(widget.game.letterID - 1, Letter("", 0));
//                     widget.game.letterID--;
//                   });
//                 }
//               }else if(e == "SUBMIT"){
//                 //! set the game rules
//                 if(widget.game.letterID >= 5) {
//                   String guess = widget.game.worddleBoard[widget.game.rowId]
//                       .map((e) => e.letter)
//                       .join();
//                   if(WorddleGame.checkWord(guess)) {
//                     if(guess == WorddleGame.gameGuess) {
//                       setState(() {
//                         WorddleGame.gameMessage = "Congratulations 🎉";
//                         widget.game.worddleBoard[widget.game.rowId]
//                             .forEach((element) {
//                           element.code = 1;
//                         });
//                       });
//                     } else{
//                       int listLength = guess.length;
//                       for(int i = 0; i < listLength; i++){
//                         String char = guess[i];
//                         //! check if the letter is in the word
//                         if(WorddleGame.gameGuess.contains(char)){
//                           //! check if the the two letter has the same id
//                           if(WorddleGame.gameGuess[i] == char){
//                             setState(() {
//                               widget.game.worddleBoard[widget.game.rowId][i]
//                                   .code = 1;
//                             });
//                           }else{
//                             setState(() {
//                               widget.game.worddleBoard[widget.game.rowId][i]
//                                   .code = 2;
//                             });
//                           }
//                         }
//                       }
//                       widget.game.rowId++;
//                       widget.game.letterID = 0;
//                     }
//                   }else{
//                     WorddleGame.gameMessage =
//                     "the word does not exist try again";
//                   }
//                 }
//               }else{
//                 if(widget.game.letterID < 5 ){
//                   setState(() {
//                     widget.game.insertWord(widget.game.letterID, Letter(e, 0));
//                     widget.game.letterID++;
//                   });
//                 }
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 color: Colors.grey.shade300,
//               ),
//               child: Text(
//                 "$e",
//                 style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black),
//               ),
//             ),
//           );
//         }).toList());
//   }
// }
// //
//
// class GameBoard extends StatelessWidget {
//   const GameBoard({super.key, required this.game});
//
//   final WorddleGame game;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: game.worddleBoard.map((e) => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: e.map((e) => Container(
//               padding: const EdgeInsets.all(16.0),
//               width: 64.0,
//               height: 64,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: e.code == 0
//                       ? Colors.grey.shade800
//                       : e.code == 1
//                       ? Colors.green
//                       : Colors.amber.shade400
//               ),
//               child: Center(
//                 child: Text(e.letter!,style: Get.textTheme.headlineSmall!.copyWith(
//                     color: Colors.white
//                 ),),
//               ),
//             )).toList()
//         )).toList()
//     );
//   }
// }