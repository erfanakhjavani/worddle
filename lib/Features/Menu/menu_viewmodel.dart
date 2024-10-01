import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! MenuViewModel handles the shaking animation for menu items
class MenuViewmodel extends GetxController {
  //* Rx variables for controlling the shaking animation of the items
  var isPlayShaking = false.obs;
  var isOnlinePvPShaking = false.obs;
  var isSettingsShaking = false.obs;


  @override
  void refresh() {
    // TODO: implement refresh
    super.refresh();
  }

  //! Private method to stop shaking all items
  void stopAllShaking(RxBool isAnimate) async{
    Future.delayed(const Duration(milliseconds: 100), () {
    isAnimate.value = false; //* Stop  shaking
    });
    update();
  }
}
