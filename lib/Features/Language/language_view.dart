import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/Features/Menu/menu_view.dart';


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
                Get.updateLocale(const Locale('en'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'ir',
              language: 'پارسی',
              onTap: () {
                Get.updateLocale(const Locale('fa'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'ar',
              language: 'العربية',
              onTap: () {
                Get.updateLocale(const Locale('ar'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'fr',
              language: 'Français',
              onTap: () {
                Get.updateLocale(const Locale('fr'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'de',
              language: 'Deutsch',
              onTap: () {
                Get.updateLocale(const Locale('de'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'it',
              language: 'Italiano',
              onTap: () {
                Get.updateLocale(const Locale('it'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'pt',
              language: 'Português',
              onTap: () {
                Get.updateLocale(const Locale('pt'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'ru',
              language: 'Русский',
              onTap: () {
                Get.updateLocale(const Locale('ru'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'es',
              language: 'Español',
              onTap: () {
                Get.updateLocale(const Locale('es'));
                _navigateToMenu();
              },
            ),
            _myContainer(
              languageImage: 'tr',
              language: 'Türkçe',
              onTap: () {
                Get.updateLocale(const Locale('tr'));
                _navigateToMenu();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMenu() {
    Get.offAll(
      const MenuView(),
      transition: Transition.fadeIn,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  Widget _myContainer({
    required String languageImage,
    required String language,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () async{

          onTap();

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
      ),
    );
  }
}