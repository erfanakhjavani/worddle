import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'authentication_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationViewModel extends GetxController {
  var isLoading = false.obs;
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar('Error', 'Sign-in failed');
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
      await AuthenticationModel().saveUserData(user!);
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      Get.defaultDialog(title: 'Error', middleText: 'Failed to sign in with Google');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    update();
  }
}
