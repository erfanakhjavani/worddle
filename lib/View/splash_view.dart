import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Model/splash_model.dart';
import '../ViewModel/splash_viewmodel.dart';



class SplashView extends GetView<SplashViewmodel> {
   const SplashView({super.key});



  @override
  Widget build(BuildContext context) {
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
                  ) {
                  }
                  else if (controller.connectionStatus.value ==
                      ConnectionStatus.disconnected) {
                    return Padding(
                      padding: EdgeInsets.only(left: width / 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            'please check your connection..!',
                            style: Get.textTheme.bodyLarge
                          ),
                          IconButton(
                            onPressed: () {
                              controller.checkConnection();
                            },
                            icon:  Icon(Icons.autorenew,
                                color: Get.theme.primaryColor),
                          ),
                        ],
                      ),
                    );
                  }
                    return Padding(
                      padding: EdgeInsets.only(left: width / 8),
                      child: LoadingAnimationWidget.inkDrop(color: Get.theme.primaryColor, size: 20),
                    );
                }),


          ],
        ),
      ),
    );
  }

}
