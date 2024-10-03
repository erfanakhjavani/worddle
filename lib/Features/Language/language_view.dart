import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:wordle/Features/Menu/menu_view.dart';


class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                Get.offAll(
                  const MenuView(),
                  transition: Transition.fadeIn,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              },
            ),
            const SizedBox(height: 10),
            _myContainer(
              languageImage: 'ir',
              language: 'پارسی',
              onTap: () {
                var localeFa = const Locale('fa');
                Get.updateLocale(localeFa);
                Get.offAll(
                  const MenuView(),
                  transition: Transition.fadeIn,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              },
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
  }) {
    return GestureDetector(
      onTap: () async{

        onTap();
      //  await Appodeal.show(AppodealAdType.RewardedVideo);
      },
      child: Container(
        width: Get.width / 2,
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

              ),
            ),
          ],
        ),
      ),
    );
  }
}