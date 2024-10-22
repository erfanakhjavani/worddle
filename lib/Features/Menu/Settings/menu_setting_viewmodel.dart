import 'package:get/get.dart';


class MenuSettingViewmodel extends GetxController {
  var isDarkMode = false.obs;
  var language = ''.obs;


  String changeLanguageString() {
    switch(Get.locale.toString()){
      case 'fa':
        language.value = 'پارسی';
        break;
        case 'en':
          language.value = 'English';
        break;
        case 'ar':
          language.value = 'العربية';
        break;
        case 'fr':
          language.value = 'Français';
        break;
        case 'de':
          language.value = 'Deutsch';
        break;
        case 'it':
          language.value = 'Italiano';
        break;
        case 'pt':
          language.value = 'Português';
        break;
        case 'ru':
          language.value = 'Русский';
        break;
        case 'es':
          language.value = 'Español';
        break;
        case 'tr':
          language.value = 'Türkçe';
        break;
    }
    return language.value;
  }

}

