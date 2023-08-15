import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartfisher/src/marker_detail_screen/controller/marker_detail_controller.dart';
import 'package:intl/intl.dart';

class MarkerDetailView extends GetView<MarkerDetailController> {
  const MarkerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MarkerDetailController());
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.isLoading.value == true
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
                          "Marker Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Marked by:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          controller.markerDetail.userDetails.firstname +
                              " " +
                              controller.markerDetail.userDetails.lastname,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Location:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "latitude: " +
                              controller.markerDetail.location[0].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          "longitude: " +
                              controller.markerDetail.location[1].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Created at:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          DateFormat('yMMMd')
                                  .format(controller.markerDetail.datecreated) +
                              " " +
                              DateFormat('jm')
                                  .format(controller.markerDetail.datecreated),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Description:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(controller.markerDetail.description),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Fish Types:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.markerDetail.fishes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 1.h, left: 1.w, right: 3.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.markerDetail.fishes[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
