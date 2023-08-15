import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/getstorage_services.dart';
import '../../home_screen/view/home_view.dart';
import '../widget/login_screen_alertdialog.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  login() async {
    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username.text)
        .where('password', isEqualTo: password.text)
        .limit(1)
        .get();
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    if (res.docs.length > 0) {
      var userDetails = res.docs[0];
      if (userDetails['deviceID'] == '' ||
          userDetails['deviceID'] == androidDeviceInfo.id) {
        Get.find<StorageServices>().saveCredentials(
          id: userDetails.id,
          username: userDetails['username'],
          password: userDetails['password'],
          firstname: userDetails['firstname'],
          lastname: userDetails['lastname'],
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userDetails.id)
            .update({
          "deviceID": androidDeviceInfo.id,
          "devicename":
              androidDeviceInfo.brand + " " + androidDeviceInfo.product
        });
        Get.offAll(() => HomeView());
      } else {
        LoginAlertDialog.showLoginExist(devicename: userDetails['devicename']);
      }
    } else {
      LoginAlertDialog.showAccountNotFound();
    }
  }
}
