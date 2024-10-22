import 'package:get/get.dart';
import 'package:wordle/Core/Constants/keyboard.dart';

List<List<String>>? languagesKeyboard() {
  Map<String, List<List<String>>> keyboardMap = {
    'fa': [row1Farsi, row2Farsi, row3Farsi],
    'en': [row1English, row2English, row3English],
    'ar': [row1Arabic, row2Arabic, row3Arabic],
    'fr': [row1French, row2French, row3French],
    'de': [row1German, row2German, row3German],
    'it': [row1Italian, row2Italian, row3Italian],
    'pt': [row1Portuguese, row2Portuguese, row3Portuguese],
    'ru': [row1Russian, row2Russian, row3Russian],
    'es': [row1Spanish, row2Spanish, row3Spanish],
    'tr': [row1Turkish, row2Turkish, row3Turkish],
  };

  return keyboardMap[Get.locale!.languageCode];
}
