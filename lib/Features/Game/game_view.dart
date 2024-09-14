import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../Core/Widgets/popper_generator.dart';
import 'game_board_widget.dart';
import 'game_keyboard_widget.dart';
import 'game_viewmodel.dart';


class GameView extends GetView<GameViewModel> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                actions: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.onHelpClicked(); // فراخوانی تابع کمک
                        },
                        child: Lottie.asset('assets/json/help.json',
                            width: 40,
                            controller: controller.lottieController
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.resetGame(isFarsi: Get.locale?.languageCode == 'en' ? false : true);
                          },
                          icon: const Icon(Icons.settings_backup_restore_sharp, size: 35,)
                      ),
                    ],
                  )
                ],
              ),
              Obx(() => Text(
                controller.wordMessage.value,
                style: TextStyle(
                  color: controller.wordMessage.value.contains('Congratulations 🎉'.tr)
                      ? Colors.green
                      : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const Expanded(
                  flex: 2,
                  child: GameBoard()
              ),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 50, 3, 15),
                    child: GameKeyboard(),
                  )
              ),
            ],
          ),
          Obx(() {
            if (controller.isCorrectGuess.value) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: PartyPopperGenerator(
                      direction: PopDirection.forwardX,
                      motionCurveX: FunctionCurve(func: (t) {
                        return - t * t / 2 + t;
                      }),
                      motionCurveY: FunctionCurve(func: (t) {
                        return 4 / 3 * t * t - t / 3;
                      }),
                      numbers: 50,
                      posX: -60.0,
                      posY: 30.0,
                      pieceHeight: 15.0,
                      pieceWidth: 30.0,
                      controller: controller.popperController,
                    ),
                  ),
                  Positioned.fill(
                    child: PartyPopperGenerator(
                      direction: PopDirection.backwardX,
                      motionCurveX: FunctionCurve(func: (t) {
                        return - t * t / 2 + t;
                      }),
                      motionCurveY: FunctionCurve(func: (t) {
                        return 4 / 3 * t * t - t / 3;
                      }),
                      numbers: 50,
                      posX: -60.0,
                      posY: 30.0,
                      pieceHeight: 15.0,
                      pieceWidth: 30.0,
                      controller: controller.popperController,
                    ),
                  ),
                ],
              );

            } else {
              return const SizedBox.shrink(); // مخفی کردن افکت اگر حدس درست نباشد
            }
          }),
        ],
      ),
    );
  }
}


