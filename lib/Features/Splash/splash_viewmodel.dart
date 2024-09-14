import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:wordle/Features/Language/language_view.dart';
import '../../Core/Repositories/check_connectivity.dart';
import 'splash_model.dart';


class SplashViewmodel extends GetxController {
  var connectionStatus = ConnectionStatus.initial.obs;
  final SplashRepository splashRepository = SplashRepository();

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }

  @override
  void dispose() {
    super.dispose();
    checkConnection();
  }

  Future<void> checkConnection()  async {
    connectionStatus.value = ConnectionStatus.initial;
    Future.delayed(const Duration(seconds: 2),() async{
      bool isConnected = await splashRepository.checkConnectivity();
      if (isConnected == true) {
        connectionStatus.value = ConnectionStatus.connected;
        Get.offAll(const LanguageView(),transition: Transition.fadeIn,duration: const Duration(seconds: 1),curve: Curves.easeIn);
      } else {
       return connectionStatus.value = ConnectionStatus.disconnected;
      }
    });
  }
}
