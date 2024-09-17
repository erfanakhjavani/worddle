import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'splash_model.dart';
import 'splash_viewmodel.dart';

//! SplashView class to display the splash screen and handle connection status
class SplashView extends GetView<SplashViewmodel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width; //* Get the width of the screen
    var height = MediaQuery.sizeOf(context).width; //* Get the height of the screen

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //* Center the content vertically
          children: [
            Padding(
              padding: EdgeInsets.only(left: width / 10), //* Add padding to center the logo
              child: Image.asset(
                'assets/png/logo.png', //* Display the logo image
                fit: BoxFit.fitWidth, //* Fit the image to the screen width
                width: width * 0.8, //* Set the width to 80% of the screen width
                height: height, //* Set the height based on the screen height
              ),
            ),

            //! Handle connection status with reactive programming
            Obx(() {
              //* Check if the app is connected to the internet or in the initial state
              if (controller.connectionStatus.value == ConnectionStatus.connected ||
                  controller.connectionStatus.value == ConnectionStatus.initial) {}
              //* If the connection is lost, show an error message and a retry button
              else if (controller.connectionStatus.value == ConnectionStatus.disconnected) {
                return Padding(
                  padding: EdgeInsets.only(left: width / 8), //* Add padding for alignment
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, //* Center content vertically
                    children: [
                      Text(
                        'please check your connection..!',
                        style: Get.textTheme.bodyLarge, //* Style the message
                      ),
                      IconButton(
                        onPressed: () {
                          controller.checkConnection(); //* Retry connection on button press
                        },
                        icon: Icon(Icons.autorenew, color: Get.theme.primaryColor), //* Retry icon
                      ),
                    ],
                  ),
                );
              }
              //* If still loading, show a loading animation
              return Padding(
                padding: EdgeInsets.only(left: width / 8), //* Align loading animation
                child: LoadingAnimationWidget.newtonCradle(
                  color: Get.theme.primaryColor, //* Use the theme’s primary color for the animation
                  size: 100, //* Set the size of the animation
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
