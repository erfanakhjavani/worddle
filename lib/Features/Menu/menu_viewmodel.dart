import 'package:get/get.dart';

//! MenuViewModel handles the shaking animation for menu items
class MenuViewmodel extends GetxController {
  //* Rx variables for controlling the shaking animation of the items
  var isPlayShaking = false.obs;
  var isOnlinePvPShaking = false.obs;
  var isSettingsShaking = false.obs;
  var isExitShaking = false.obs;

  //! Method to start shaking the selected menu item
  void startShaking(String menuItem) {
    _stopAllShaking(); //* Stop any ongoing shaking
    switch (menuItem) {
      case 'Play':
        isPlayShaking.value = true; //* Start shaking for "Play"
        break;
      case 'Online PvP':
        isOnlinePvPShaking.value = true; //* Start shaking for "Online PvP"
        break;
      case 'Settings':
        isSettingsShaking.value = true; //* Start shaking for "Settings"
        break;
      case 'Exit':
        isExitShaking.value = true; //* Start shaking for "Exit"
        break;
    }

    //! Stop shaking after a short duration (100 ms)
    Future.delayed(const Duration(milliseconds: 100), () {
      _stopAllShaking(); //* Stop all shaking after the delay
    });
  }

  //! Private method to stop shaking all items
  void _stopAllShaking() {
    isPlayShaking.value = false; //* Stop "Play" shaking
    isOnlinePvPShaking.value = false; //* Stop "Online PvP" shaking
    isSettingsShaking.value = false; //* Stop "Settings" shaking
    isExitShaking.value = false; //* Stop "Exit" shaking
  }
}
