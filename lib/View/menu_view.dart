import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class MenuView extends StatelessWidget {
  const MenuView({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Lottie.asset('assets/json/worddle.json',reverse: true),
    );
  }
}
