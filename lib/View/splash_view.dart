import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wordle/Core/Constants/app_colors.dart';
import 'package:wordle/Core/Themes/theme_service.dart';

import '../Model/splash_model.dart';
import '../ViewModel/splash_viewmodel.dart';



class SplashView extends GetView<SplashViewmodel> {
   const SplashView({super.key});



  @override
  Widget build(BuildContext context) {
    var theme = Get.find<ThemeService>().isDarkMode();
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Padding(
              padding: EdgeInsets.only(left: width / 10),
              child: Image.asset('assets/png/logo.png',
                fit: BoxFit.fitWidth,
                width: width * 0.8,
                height: height,
              ),
            ),

            Obx(() {
                  if (controller.connectionStatus.value == ConnectionStatus.connected
                 || controller.connectionStatus.value ==
                  ConnectionStatus.initial
                  ) {}
                  else if (controller.connectionStatus.value ==
                      ConnectionStatus.disconnected) {
                    return Padding(
                      padding: EdgeInsets.only(left: width / 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'please check your connection..!',
                            style: Get.textTheme.bodyLarge!.copyWith(
                                color: theme ? AppColors.primary : AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Irs"),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.checkConnection();
                            },
                            icon:  Icon(Icons.autorenew,
                                color: theme ? AppColors.primary : AppColors.secondary),
                          ),
                        ],
                      ),
                    );
                  }
                    return Padding(
                      padding: EdgeInsets.only(left: width / 8),
                      child: LoadingAnimationWidget.inkDrop(color: theme ? AppColors.primary : AppColors.secondary, size: 20),
                    );
                }),


          ],
        ),
      ),
    );
  }

}
