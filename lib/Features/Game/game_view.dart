import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:wordle/Core/Widgets/widgets.dart';
import 'package:wordle/Features/Menu/menu_view.dart';
import '../../Core/Widgets/popper_generator.dart';
import 'game_board_widget.dart';
import 'game_keyboard_widget.dart';
import 'game_viewmodel.dart';

class GameView extends GetView<GameViewModel> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            //! Main game structure and layout
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //! AppBar with actions for help and reset
                AppBar(
                  actions: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showRewardedVideoDialog();
                          },
                          child: Lottie.asset('assets/json/help.json',
                              width: 40,
                              controller: controller
                                  .lottieController //* Lottie animation controller
                              ),
                        ),
                        IconButton(
                            onPressed: () {
                              showMyDialog(
                                title: 'Reset Game'.tr,
                                  content: 'Do you want to reset game?'.tr,
                                  context: context,
                                  accept: () {
                                    //* Reset the game depending on the current language
                                    controller.resetGame(
                                        isFarsi: Get.locale?.languageCode == 'en'
                                            ? false
                                            : true);
                                    Get.back();
                                  });

                            },
                            icon: const Icon(
                              Icons.settings_backup_restore_sharp,
                              size: 35,
                            )),
                      ],
                    )
                  ],
                  leading: IconButton(
                    onPressed: () {
                      showMyDialog(
                          context: context,
                          accept: () {
                            // Appodeal.destroy(AppodealAdType.BannerBottom);
                            Get.offAll(
                              const MenuView(),
                              transition: Transition.rightToLeft,
                              duration: 250.ms,
                              //* Smooth transition with 1-second duration
                              curve: Curves
                                  .easeIn, //* Use easeIn curve for the animation
                            );
                          });
                    },
                    icon: const Icon(Icons.home_sharp, size: 30),
                  ),
                ),

                //! Display message for the player
                Obx(() => Text(
                      controller.wordMessage.value,
                      style: TextStyle(
                        color: controller.wordMessage.value
                                .contains('Congratulations 🎉'.tr)
                            ? Colors.green //* Success message in green
                            : Colors.red, //* Error message in red
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),

                //! Game board area
                const Expanded(flex: 2, child: GameBoard()),


                //! Game keyboard area with padding
                Obx(
                      () => Expanded(
                    flex: controller.isLoadAds.value ? 1 : 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 10, 3, 0),
                      child: GameKeyboard(),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 0,
                //   child: Obx(() {
                //     if (controller.isLoadAds.value) {
                //        Appodeal.show(AppodealAdType.BannerBottom);
                //       return const SizedBox();
                //     } else {
                //       return const SizedBox();
                //     }
                //   }),
                // ),
              ],
            ),

            //! Confetti effect when the player guesses correctly
            Obx(() {
              if (controller.usePopper.value) {
                return Stack(
                  children: [
                    //! Forward direction confetti
                    Positioned.fill(
                      child: PartyPopperGenerator(
                        direction: PopDirection.forwardX,
                        motionCurveX: FunctionCurve(func: (t) {
                          return -t * t / 2 +
                              t; //* Define the motion curve for confetti pieces
                        }),
                        motionCurveY: FunctionCurve(func: (t) {
                          return 4 / 3 * t * t -
                              t / 3; //* Define the vertical motion curve
                        }),
                        numbers: 50,
                        //* Number of confetti pieces
                        posX: -60.0,
                        posY: 30.0,
                        pieceHeight: 15.0,
                        pieceWidth: 30.0,
                        controller: controller.popperController,
                      ),
                    ),

                    //! Backward direction confetti
                    Positioned.fill(
                      child: PartyPopperGenerator(
                        direction: PopDirection.backwardX,
                        motionCurveX: FunctionCurve(func: (t) {
                          return -t * t / 2 +
                              t; //* Define the motion curve for confetti pieces
                        }),
                        motionCurveY: FunctionCurve(func: (t) {
                          return 4 / 3 * t * t -
                              t / 3; //* Define the vertical motion curve
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
                return const SizedBox
                    .shrink(); //* Hide confetti effect if the guess is incorrect
              }
            }),
          ],
        ),
      ),
    );
  }
  void _showRewardedVideoDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                 Lottie.asset('assets/json/help2.json',
                    width: 120,
                    controller: controller
                        .lottieController //* Lottie animation controller
                ),
              const SizedBox(height: 20),
               Text(
                'Do you need help?'.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
               Text(
                'If you want, we will remove some of the game keys by watching the video!'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Obx(() {
                Gradient buttonGradient;
                if (controller.watchedCount.value == 0) {
                  buttonGradient = const LinearGradient(
                    colors: [Colors.blueGrey, Colors.transparent],
                    stops: [0.0, 0.0],
                  );
                } else if (controller.watchedCount.value == 1) {
                  buttonGradient = const LinearGradient(
                    colors: [Colors.blueAccent, Colors.transparent],
                    stops: [0.5, 0.5],
                  );
                } else {
                  buttonGradient = const LinearGradient(
                    colors: [Colors.blueGrey, Colors.transparent],
                    stops: [1.0, 1.0],
                  );
                }

                return ElevatedButton(
                  onPressed: () async {
                    // if (controller.watchedCount.value < 2) {
                    //   bool isRewarded = await Appodeal.show(AppodealAdType.RewardedVideo);
                    //
                    //   if (isRewarded) {
                    //     controller.onHelpClicked();
                    //     controller.watchedCount.value++;
                    //     Get.back();
                    //   }
                    // } else {
                    //   Get.snackbar('attention'.tr, 'You have already watched the video.'.tr,
                    //   colorText: AppColors.primary,
                    //   );
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    side: WidgetStateProperty.all(BorderSide.none),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Text(
                        controller.watchedCount.value < 2 ? 'Watch the video'.tr : 'The video has already been seen'.tr,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
