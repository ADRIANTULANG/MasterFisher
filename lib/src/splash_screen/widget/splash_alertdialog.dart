import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashAlertDialog {
  static showMultipleLoginNotAllowed() async {
    Get.dialog(
        AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text("Okay"),
              )
            ],
            content: Container(
              height: 17.h,
              width: 100.w,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sorry!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Text(
                    "Multiple login not allowed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 11.sp),
                  ),
                  Text(
                    "Please try again later",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 11.sp),
                  ),
                ],
              ),
            )),
        barrierDismissible: false);
  }
}
