import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashRepository extends GetConnect {

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      //! No network connection.
      return false;
    } else {
      //! Connected to a network (Wi-Fi or mobile).
      try {
        final response = await get('https://www.google.com', ).timeout(const Duration(seconds: 3));
        if (response.statusCode == 200) {
          //! Internet connection is available.
          return true;
        } else {
          //! Connected to a network but no internet access.
          return false;
        }
      } on TimeoutException catch (_) {
        print(_.toString());
        //! Request timed out (considered as no internet access).
        return true;
      } catch (e) {
        e.toString();
        //! Other errors.
        return false;
      }
    }
  }
}
