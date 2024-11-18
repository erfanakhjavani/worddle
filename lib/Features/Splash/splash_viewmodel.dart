import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:wordle/Features/Language/language_view.dart';
import '../../Core/Repositories/check_connectivity.dart';
import 'splash_model.dart';

//! SplashViewModel class handles splash logic, including checking internet connection and navigation
class SplashViewmodel extends GetxController {
  var connectionStatus = ConnectionStatus.initial.obs; //* Observable for connection status
  final SplashRepository splashRepository = SplashRepository(); //* Repository to check connectivity

  @override
  void onInit() {
    super.onInit();
    checkConnection(); //! Check the connection status when the controller is initialized
  }

  @override
  void dispose() {
    super.dispose();
    checkConnection(); //* Check the connection again before disposing (though this is uncommon)
  }



  // initialization() {
  //   Appodeal.setTesting(true); //only not release mode
  //   Appodeal.setAutoCache(AppodealAdType.Banner, true);
  //   Appodeal.setAutoCache(AppodealAdType.RewardedVideo, true);
  //   Appodeal.setUseSafeArea(false);
  //
  //
  //   Appodeal.initialize(
  //     appKey: key,
  //     adTypes: [
  //       AppodealAdType.RewardedVideo,
  //       AppodealAdType.Banner,
  //     ],
  //     onInitializationFinished: (errors) {
  //       errors?.forEach((error) => print(error.description));
  //       print('onInitializationFinished: errors - ${errors?.length ?? 0}');
  //     },
  //   );
  // }

  //! Method to check internet connection and handle the navigation flow
  Future<void> checkConnection() async {
    connectionStatus.value = ConnectionStatus.initial; //* Set initial status
    Future.delayed(const Duration(seconds: 1), () async {
    //  await initialization();
     // Appodeal.destroy(AppodealAdType.BannerBottom);
      bool isConnected = await splashRepository.checkConnectivity(); //* Check if connected
      if (isConnected == true) {
        connectionStatus.value = ConnectionStatus.connected; //* Update status to connected
        Get.offAll(
          const LanguageView(), //* Navigate to the Language selection view if connected
          transition: Transition.fadeIn,
          duration: const Duration(seconds: 1), //* Smooth transition with 1-second duration
          curve: Curves.easeIn, //* Use easeIn curve for the animation
        );
      } else {
        return connectionStatus.value = ConnectionStatus.disconnected; //* Set status to disconnected if no internet
      }
    });
  }
}
