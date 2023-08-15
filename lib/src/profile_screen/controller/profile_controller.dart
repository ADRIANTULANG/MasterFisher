import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/getstorage_services.dart';
import '../widget/profile_alertdialogs.dart';

class ProfileController extends GetxController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? picked_image;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  RxBool isUpdating = false.obs;

  getUserDetails() async {
    try {
      var userDetails = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .get();

      firstname.text = userDetails.get('firstname');
      lastname.text = userDetails.get('lastname');
      username.text = userDetails.get('username');
      password.text = userDetails.get('password');
    } on Exception catch (e) {
      print(e);
    }
  }

  updateAccount() async {
    try {
      isUpdating.value = true;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .update({
        "firstname": firstname.text,
        "lastname": lastname.text,
        "username": username.text,
        "password": password.text,
      });

      ProfileAlertDialogs.showSuccessUpdate();
      isUpdating.value = false;
    } catch (e) {
      isUpdating.value = false;
    }
  }
}
