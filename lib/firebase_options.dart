// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAvwZXvwRwl7SHpzlpkFxyw7KKaCZaOGOM',
    appId: '1:300228468940:web:bba2ab141f0b502ce62269',
    messagingSenderId: '300228468940',
    projectId: 'worddle-f834d',
    authDomain: 'worddle-f834d.firebaseapp.com',
    storageBucket: 'worddle-f834d.appspot.com',
    measurementId: 'G-J5DS9TRD1K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo8GtOnbBalLoeJSO03Mt18RSyFx_SJmI',
    appId: '1:300228468940:android:f8e02e6008040c95e62269',
    messagingSenderId: '300228468940',
    projectId: 'worddle-f834d',
    storageBucket: 'worddle-f834d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDv_rN2aNx9297m5BrgNIY6TpwW6g1tccg',
    appId: '1:300228468940:ios:ebb46798f8830dc4e62269',
    messagingSenderId: '300228468940',
    projectId: 'worddle-f834d',
    storageBucket: 'worddle-f834d.appspot.com',
    iosBundleId: 'com.example.wordle.raviar.wordle',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDv_rN2aNx9297m5BrgNIY6TpwW6g1tccg',
    appId: '1:300228468940:ios:ebb46798f8830dc4e62269',
    messagingSenderId: '300228468940',
    projectId: 'worddle-f834d',
    storageBucket: 'worddle-f834d.appspot.com',
    iosBundleId: 'com.example.wordle.raviar.wordle',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAvwZXvwRwl7SHpzlpkFxyw7KKaCZaOGOM',
    appId: '1:300228468940:web:cc0cffeedf90f5b8e62269',
    messagingSenderId: '300228468940',
    projectId: 'worddle-f834d',
    authDomain: 'worddle-f834d.firebaseapp.com',
    storageBucket: 'worddle-f834d.appspot.com',
    measurementId: 'G-Z4JKB6H8QM',
  );
}
