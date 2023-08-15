import 'dart:async';

import 'package:get/get.dart';
import 'package:smartfisher/src/home_screen/view/home_view.dart';
import 'package:smartfisher/src/login_screen/view/login_view.dart';

import '../../../services/getstorage_services.dart';
// import '../../../services/notification_services.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigate_to_homescreen();
    super.onInit();
  }

  navigate_to_homescreen() async {
    Timer(Duration(seconds: 4), () async {
      if (Get.find<StorageServices>().storage.read('id') == null) {
        Get.offAll(() => LoginScreenView());
      } else {
        Get.offAll(() => HomeView());
        // Get.find<NotificationServices>().getToken();
      }
    });
  }
}
