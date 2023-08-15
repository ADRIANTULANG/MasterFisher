import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/registration_alertdialog.dart';

class RegistrationController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  RxBool isRegistering = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  checkifAccountExist() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username.text)
          .get();
      var users = res.docs;
      if (users.length > 0) {
        RegisterAlertDialog.showEmailAlreadyExist();
      } else {
        registerAccount();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  registerAccount() async {
    try {
      var deviceInfo = DeviceInfoPlugin();
      var androidDeviceInfo = await deviceInfo.androidInfo;
      String deviceName =
          androidDeviceInfo.brand + " " + androidDeviceInfo.product;
      await FirebaseFirestore.instance.collection('users').add({
        "firstname": firstname.text,
        "lastname": lastname.text,
        "username": username.text,
        "password": password.text,
        "devicename": deviceName,
        "deviceID": androidDeviceInfo.id,
        "isNew": true
      });
      Get.back();
      Get.snackbar("Message", "Account successfully created",
          backgroundColor: Colors.white, duration: Duration(seconds: 4));
    } on Exception catch (e) {
      print(e);
    }
  }
}
