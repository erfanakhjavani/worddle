import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class AuthenticationModel {
  Future<void> saveUserData(User user) async {
    var box = await Hive.openBox('userBox');
    await box.put('displayName', user.displayName);
    await box.put('email', user.email);
    await box.put('photoURL', user.photoURL);
  }

  Future<Map<String, String?>> getUserData() async {
    var box = await Hive.openBox('userBox');
    return {
      'displayName': box.get('displayName'),
      'email': box.get('email'),
      'photoURL': box.get('photoURL'),
    };
  }
}
