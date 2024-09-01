import 'package:get/get.dart';

class MenuViewmodel extends GetxController {
  // متغیرهای Rx برای کنترل لرزش آیتم‌ها
  var isPlayShaking = false.obs;
  var isOnlinePvPShaking = false.obs;
  var isSettingsShaking = false.obs;
  var isExitShaking = false.obs;

  // متد برای شروع لرزش
  void startShaking(String menuItem) {
    _stopAllShaking(); // متوقف کردن لرزش‌های قبلی
    switch (menuItem) {
      case 'Play':
        isPlayShaking.value = true;
        break;
      case 'Online PvP':
        isOnlinePvPShaking.value = true;
        break;
      case 'Settings':
        isSettingsShaking.value = true;
        break;
      case 'Exit':
        isExitShaking.value = true;
        break;
    }

    // توقف لرزش بعد از مدت زمان کوتاه
    Future.delayed(const Duration(milliseconds: 100), () {
      _stopAllShaking();
    });
  }



  // متد برای توقف لرزش
  void _stopAllShaking() {
    isPlayShaking.value = false;
    isOnlinePvPShaking.value = false;
    isSettingsShaking.value = false;
    isExitShaking.value = false;
  }
}
