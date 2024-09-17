import 'package:get/get.dart';

class MenuPlayViewModel extends GetxController {
  // State variables
  RxInt wordLength = 4.obs;
  RxInt maxAttempts = 4.obs;

  var isPlayShaking = false.obs;

  //! Increase the length of the word with a maximum limit
  void increaseWordLength() {
    if (wordLength.value < 8) {
      wordLength.value++;
    }
  }

  //! Decrease the length of the word with a minimum limit
  void decreaseWordLength() {
    if (wordLength.value > 4) {
      wordLength.value--;
    }
  }

  //! Increase the number of attempts with a maximum limit
  void increaseMaxAttempts() {
    if (maxAttempts.value < 8) {
      maxAttempts.value++;
    }
  }

  //! Decrease the number of attempts with a minimum limit
  void decreaseMaxAttempts() {
    if (maxAttempts.value > 1) {
      maxAttempts.value--;
    }
  }

  //! Start shaking animation for a menu item
  void startShaking(String menuItem) {
    isPlayShaking.value = true;

    //* Stop shaking after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      isPlayShaking.value = false;
    });
  }
}
