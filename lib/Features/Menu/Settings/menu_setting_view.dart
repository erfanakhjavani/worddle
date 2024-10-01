import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wordle/Core/Themes/theme_service.dart';
import 'package:wordle/Features/Menu/Settings/menu_setting_viewmodel.dart';

import '../../Language/language_view.dart';


class MenuSettingView extends GetView<MenuSettingViewmodel> {

  const MenuSettingView({super.key});

  @override
  Widget build(BuildContext context) {
   var theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
        title: Text(
        'back'.tr, //* Title for the AppBar
        style: theme.headlineSmall,
    ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Theme'.tr,style: theme.headlineSmall,),
                Obx(() => Switch(
                  value: controller.isDarkMode.value,
                  onChanged: (value) {
                   var theme = Get.find<ThemeService>();
                    controller.isDarkMode.value = value;
                    theme.switchTheme(value ? ThemeMode.dark : ThemeMode.light);

                  },
                )),
              ],
            ),
            const SizedBox(height: 20),

            // زبان
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${'Language'.tr}: ${controller.changeLanguageString()}",style: theme.headlineSmall,),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.to(
                      const LanguageView(), //* Navigate to the Language selection view if connected
                      transition: Transition.noTransition,
                      duration: const Duration(seconds: 1), //* Smooth transition with 1-second duration
                      curve: Curves.easeIn, //* Use easeIn curve for the animation
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('${'Contact'.tr}:',style: theme.headlineSmall,),
                TextButton(
                  onPressed: () async{
                    await launchUrlString('mailto:ehoseyni1383@gmail.com');
                  },
                  child:  Text('ehoseyni1383@gmail.com',
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontFamily: ''
                  ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),


             const Spacer(),
             Center(child: Text('${'Version'.tr}: 1.0.0',
                 style: theme.bodyMedium)),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _launchPrivacyPolicy,
                child:  Text(
                  'Privacy Policy'.tr,
                  style: theme.bodySmall!.copyWith(color:  const Color.fromARGB(
                      189, 34, 168, 255)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  void _launchPrivacyPolicy() async {
    const url = 'https://example.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch privacy policy';
    }
  }
}
