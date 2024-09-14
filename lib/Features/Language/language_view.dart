import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Core/Themes/themes.dart';

import '../../Core/Constants/app_route.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _myContainer(
              languageImage: 'uk',
              language: 'English',
              onTap: () {
                var localeEn = const Locale('en');
                Get.updateLocale(localeEn);
                Get.toNamed(AppRoute.menuView);
              },
            ),
            const SizedBox(height: 10),
            _myContainer(
              languageImage: 'ir',
              language: 'پارسی',
              onTap: () {
                var localeFa = const Locale('fa');
                Get.updateLocale(localeFa);
                Get.toNamed(AppRoute.menuView);
              },
              font: 'Yekan'
            ),
          ],
        ),
      ),
    );
  }

  Widget _myContainer({
    required String languageImage,
    required String language,
    required Function() onTap,
    String? font
  }) {
    return InkWell(
      onTap: (){

        onTap();

      },
      child: Container(
        width: Get.width / 2, // اندازه‌گیری عرض صفحه
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.teal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/png/$languageImage.png', height: 20),
            const SizedBox(width: 10),
            Text(
              language,
              style: Get.textTheme.bodyLarge?.copyWith(color: Colors.white,
              fontFamily: font
              ),
            ),
          ],
        ),
      ),
    );
  }
}