import 'package:get/get.dart';


class MenuSettingViewmodel extends GetxController {
  var isDarkMode = false.obs;
  var language = ''.obs;


  String changeLanguageString() {
    language.value = Get.locale.toString() == 'fa' ? 'پارسی' : 'English';
    return language.value;
  }
}