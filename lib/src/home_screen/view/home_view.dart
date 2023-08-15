import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smartfisher/src/home_screen/controller/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:smartfisher/src/profile_screen/view/profile_view.dart';
import '../../../services/location_services.dart';
import '../../create_marker_screen/view/create_marker_view.dart';
import '../../marker_detail_screen/view/marker_detail_view.dart';
import '../alertdialog/home_alertdialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Obx(
              () => GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      Get.find<LocationServices>().locationData!.latitude!,
                      Get.find<LocationServices>().locationData!.longitude!),
                  zoom: 14.4746,
                ),
                onLongPress: (LatLng location) {
                  Get.to(() => CreateMarkerView(), arguments: {
                    "lat": location.latitude,
                    "long": location.longitude
                  });
                },
                markers: controller.marker.toSet(),
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController g_controller) async {
                  if (controller.googleMapController.isCompleted) {
                  } else {
                    controller.googleMapController.complete(g_controller);
                  }
                  controller.camera_controller = await g_controller;
                },
              ),
            ),
            Positioned(
                top: 2.h,
                left: 17.w,
                child: InkWell(
                  onTap: () {
                    Get.to(() => ProfileView());
                  },
                  child: Container(
                    height: 5.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.person,
                      size: 25.sp,
                    ),
                  ),
                )),
            Positioned(
                top: 2.h,
                left: 5.w,
                child: InkWell(
                  onTap: () {
                    HomeAlertDialog.showLogoutDialog();
                  },
                  child: Container(
                    height: 5.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 25.sp,
                    ),
                  ),
                )),
            Positioned(
              child: Container(
                height: 20.h,
                width: 100.w,
                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                color: Colors.transparent,
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.markersList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
                          width: 65.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: .5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.markersList[index].userDetails
                                        .firstname +
                                    " " +
                                    controller.markersList[index].userDetails
                                        .lastname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                              Text(
                                DateFormat('yMMMd').format(controller
                                        .markersList[index].datecreated) +
                                    " " +
                                    DateFormat('jm').format(controller
                                        .markersList[index].datecreated),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.sp),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                height: 5.h,
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          LatLng location = LatLng(
                                              controller.markersList[index]
                                                  .location[0],
                                              controller.markersList[index]
                                                  .location[1]);
                                          controller.locateMarker(
                                              location: location);
                                        },
                                        child: Container(
                                          height: 5.h,
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "locate",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => MarkerDetailView(),
                                              arguments: {
                                                "markerDetails": controller
                                                    .markersList[index]
                                              });
                                        },
                                        child: Container(
                                          height: 5.h,
                                          decoration: BoxDecoration(
                                              color: Colors.green),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
