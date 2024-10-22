import 'package:get/get.dart';
import '../Constants/Language/ar.dart';
import '../Constants/Language/de.dart';
import '../Constants/Language/en.dart';
import '../Constants/Language/es.dart';
import '../Constants/Language/fa.dart';
import '../Constants/Language/fr.dart';
import '../Constants/Language/it.dart';
import '../Constants/Language/pt.dart';
import '../Constants/Language/ru.dart';
import '../Constants/Language/tr.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'fa': fa,   //* Persian translations
    'en': en,   //* English translations
    'ar': ar,        //* Arabic translations
    'fr': fr,        //* French translations
    'de': de,        //* German translations
    'it': it,        //* Italian translations
    'pt': pt,        //* Portuguese translations
    'ru': ru,        //* Russian translations
    'es': es,        //* Spanish translations
    'tr': tr,        //* Turkish translations
  };
}