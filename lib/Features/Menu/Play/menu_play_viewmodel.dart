import 'package:get/get.dart';

class MenuPlayViewModel extends GetxController {
  // متغیرهای وضعیت
  RxInt wordLength = 4.obs;
  RxInt maxAttempts = 4.obs;

  var isPlayShaking = false.obs;


  // افزایش و کاهش طول کلمه با محدودیت
  void increaseWordLength() {
    if (wordLength.value < 8) {
      wordLength.value++;
    }
  }

  void decreaseWordLength() {
    if (wordLength.value > 4) {
      wordLength.value--;
    }
  }

  // افزایش و کاهش تعداد تلاش‌ها با محدودیت
  void increaseMaxAttempts() {
    if (maxAttempts.value < 8) {
      maxAttempts.value++;
    }
  }

  void decreaseMaxAttempts() {
    if (maxAttempts.value > 1) {
      maxAttempts.value--;
    }
  }


  void startShaking(String menuItem) {
        isPlayShaking.value = true;

    // توقف لرزش بعد از مدت زمان کوتاه
    Future.delayed(const Duration(milliseconds: 100), () {
      isPlayShaking.value = false;
    });
  }



}
