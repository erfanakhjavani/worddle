import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authentication_viewmodel.dart';

class AuthenticationView extends StatelessWidget {
  final AuthenticationViewModel controller = Get.put(AuthenticationViewModel());

   AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with Google'),
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator();
          } else if (controller.user != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Signed in as: ${controller.user!.displayName}'),
                Text('Email: ${controller.user!.email}'),
                Text('uid: ${controller.user!.uid}'),
                Text('phoneNumber: ${controller.user!.phoneNumber}'),

                CircleAvatar(
                  backgroundImage: NetworkImage(controller.user!.photoURL ?? ''),
                ),
                ElevatedButton(
                  onPressed: controller.signOut,
                  child: Text('Sign Out'),
                ),
              ],
            );
          } else {
            return ElevatedButton(
              onPressed: controller.signInWithGoogle,
              child: Text('Sign in with Google'),
            );
          }
        }),
      ),
    );
  }
}
