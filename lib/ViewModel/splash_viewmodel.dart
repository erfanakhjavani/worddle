import 'package:get/get.dart';
import 'package:wordle/View/menu_view.dart';
import '../Core/Repositories/check_connectivity.dart';
import '../Model/splash_model.dart';


class SplashViewmodel extends GetxController {
  var connectionStatus = ConnectionStatus.initial.obs;
  final SplashRepository splashRepository = SplashRepository();

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }



  Future<void> checkConnection()  async {
    connectionStatus.value = ConnectionStatus.initial;
    Future.delayed(const Duration(seconds: 2),() async{
      bool isConnected = await splashRepository.checkConnectivity();
      if (isConnected == true) {
        connectionStatus.value = ConnectionStatus.connected;
        Get.offAll(const MenuView(),transition: Transition.fadeIn);
      } else {
       return connectionStatus.value = ConnectionStatus.disconnected;
      }
    });
  }
}
