import 'package:get/get.dart';
import 'package:wordle/Core/Constants/Language/en_us.dart';
import 'package:wordle/Core/Constants/Language/fa_ir.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {

    'en_US': enUS,  //* English translations

    'fa_IR': faIR,   //* Persian translations
  };
}
