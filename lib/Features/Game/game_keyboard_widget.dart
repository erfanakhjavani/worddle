import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_viewmodel.dart';

class GameKeyboard extends StatelessWidget {
  GameKeyboard({super.key});

  final GameViewModel viewModel = Get.find<GameViewModel>();

  // لیست حروف انگلیسی
  final List<String> row1English = 'QWERTYUIOP'.split('');
  final List<String> row2English = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L','DEL'];
  final List<String> row3English = [ 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DO'];

  // لیست حروف فارسی
  final List<String> row1Farsi =  ['ج', 'ح', 'خ', 'ه', 'ع', 'غ', 'ف', 'ق', 'ث', 'ص', 'ض'];
  final List<String> row2Farsi =  ['DEL','گ', 'ک', 'م', 'ن', 'ت', 'ا', 'ل', 'ب', 'ی', 'س', 'ش'];
  final List<String> row3Farsi = ['DO','چ', 'پ', 'و', 'د', 'ذ', 'ر', 'ز', 'ژ', 'ط', 'ظ',];

  @override
  Widget build(BuildContext context) {
    bool isFarsi = viewModel.isFarsi.value;

    // انتخاب حروف کیبورد بر اساس زبان
    final row1 = isFarsi ? row1Farsi : row1English;
    final row2 = isFarsi ? row2Farsi : row2English;
    final row3 = isFarsi ? row3Farsi : row3English;

    return Directionality(
      textDirection: isFarsi ? TextDirection.rtl : TextDirection.ltr, // تنظیم جهت متن
      child: Column(
        children: [
          rowOfKeyboard(row1),
          const SizedBox(height: 10.0),
          rowOfKeyboard(row2),
          const SizedBox(height: 10.0),
          rowOfKeyboard(row3),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget rowOfKeyboard(List<String> row) {
    return Row(
      children: row.map((e) {
        return Expanded(
          flex: (e == 'DEL' || e == 'DO') ? 2 : 1, // اندازه بزرگ‌تر برای دکمه‌های حذف و انجام
          child: InkWell(
            onTap: () {
              if (e == 'DEL') {
                viewModel.deleteLetter();
              } else if (e == 'DO') {
                viewModel.submitGuess();
              } else {
                viewModel.insertLetter(e);
              }
            },
            child: Obx(() {
              Color keyColor = viewModel.letterColors[e] ?? Colors.blueGrey.shade300;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: keyColor,
                ),
                child: Center(
                  child: e == 'DEL'
                      ? Icon(Icons.backspace_outlined, color: Colors.white)  // آیکون حذف
                      : e == 'DO'
                      ? Icon(Icons.check_circle, color: Colors.white)     // آیکون ثبت
                      : Text(
                    e,
                    style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        );
      }).toList(),
    );
  }
}

