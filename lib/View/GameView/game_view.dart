import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/game_viewmodel.dart';
import 'game_keyboard_view.dart';



class GameView extends GetView<GameViewModel> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Get.snackbar('Help', 'This is how you play...');
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // controller.resetGame();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black),
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //   child: Obx(() => Text(
          //     controller.timeLeft.value.toString(),
          //     style: Get.textTheme.headlineMedium,
          //   )),
          // ),
          const SizedBox(height: 20),
          Obx(() => Text(controller.gameMessage.value)),
          const SizedBox(height: 20),
          const GameKeyboard(),
        ],
      ),
    );
  }
}



