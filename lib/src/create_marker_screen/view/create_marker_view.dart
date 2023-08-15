import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartfisher/src/create_marker_screen/controller/create_marker_controller.dart';

class CreateMarkerView extends GetView<CreateMarkerController> {
  const CreateMarkerView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateMarkerController());
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.isCreating.value == true
              ? Container(
                  color: Colors.white,
                  height: 100.h,
                  width: 100.w,
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Marker",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          height: 20.h,
                          width: 100.w,
                          child: TextField(
                            controller: controller.description,
                            maxLines: 20,
                            maxLength: 300,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 3.w, top: 2.h),
                                alignLabelWithHint: false,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                hintText: 'Say something here..'),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Fish Types",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 7.h,
                              width: 75.w,
                              child: TextField(
                                controller: controller.fishname,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(left: 3.w),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: 'Enter fish types'),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (controller.fishname.text.isNotEmpty) {
                                    controller.fishesList
                                        .add(controller.fishname.text);
                                    controller.fishname.clear();
                                  }
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Icon(Icons.add_box),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.fishesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 1.h, left: 1.w, right: 3.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.fishesList[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            controller.fishesList
                                                .removeAt(index);
                                          },
                                          child: Icon(Icons.clear))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Obx(
          () => controller.isCreating.value == true
              ? SizedBox()
              : Container(
                  height: 9.h,
                  width: 100.w,
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: SizedBox(
                      width: 100.w,
                      height: 7.h,
                      child: ElevatedButton(
                          child: Text("CREATE",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.white)))),
                          onPressed: () {
                            if (controller.fishesList.length == 0 ||
                                controller.description.text.isEmpty) {
                              Get.snackbar("Message", "Missing inputs",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.black);
                            } else {
                              controller.createMarker();
                            }
                          }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
