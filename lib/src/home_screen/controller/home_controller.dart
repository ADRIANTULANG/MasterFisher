import 'dart:async';
import 'dart:convert';
// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfisher/services/getstorage_services.dart';
import 'package:smartfisher/src/login_screen/view/login_view.dart';

import '../model/home_markers_model.dart';

class HomeController extends GetxController {
  final Completer<GoogleMapController> googleMapController = Completer();
  RxList<Marker> marker = <Marker>[].obs;
  GoogleMapController? camera_controller;

  RxBool hasSelectedMarker = false.obs;

  RxList<Markers> markersList = <Markers>[].obs;

  @override
  void onInit() {
    getMarkers();
    super.onInit();
  }

  getMarkers() async {
    var userDetail = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'))
        .get();
    bool isNew = userDetail.get('isNew');
    var res = await FirebaseFirestore.instance.collection('markers').get();
    var markers = res.docs;

    List data = [];
    for (var i = 0; i < markers.length; i++) {
      var user = await markers[i]['userDocumentReference'].get();
      Map map = {
        "userDetails": user.data(),
        "datecreated": markers[i]['datecreated'].toDate().toString(),
        "description": markers[i]['description'],
        "fishes": markers[i]['fishes'],
        "location": markers[i]['l'],
        "userid": markers[i]['userid'],
      };
      data.add(map);
      if (isNew == false) {
        if (Get.find<StorageServices>().storage.read('id') ==
            markers[i]['userid']) {
          marker.add(Marker(
            position: LatLng(markers[i]['l'][0], markers[i]['l'][1]),
            markerId: MarkerId(i.toString()),
          ));
        } else {
          marker.add(Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow),
            position: LatLng(markers[i]['l'][0], markers[i]['l'][1]),
            markerId: MarkerId(i.toString()),
          ));
        }
      }
    }
    // log((jsonEncode(data)));
    if (isNew == true) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .update({"isNew": false});
    } else {
      markersList.assignAll(await markersFromJson(jsonEncode(data)));
    }
  }

  locateMarker({required LatLng location}) async {
    await camera_controller!
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: location,
      zoom: 18.4746,
    )));
  }

  logout() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'))
        .update({"deviceID": "", "devicename": ""});
    Get.find<StorageServices>().removeStorageCredentials();
    Get.offAll(() => LoginScreenView());
  }
}
