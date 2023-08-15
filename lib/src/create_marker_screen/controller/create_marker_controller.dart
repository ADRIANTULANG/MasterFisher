import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartfisher/services/getstorage_services.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:smartfisher/src/home_screen/controller/home_controller.dart';

class CreateMarkerController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  TextEditingController description = TextEditingController();
  TextEditingController fishname = TextEditingController();

  RxBool isCreating = false.obs;

  RxList<String> fishesList = <String>[].obs;
  @override
  void onInit() async {
    lat.value = await Get.arguments['lat'];
    long.value = await Get.arguments['long'];
    super.onInit();
  }

  createMarker() async {
    isCreating(true);
    try {
      var userDocumentReference = await FirebaseFirestore.instance
          .collection("users")
          .doc(Get.find<StorageServices>().storage.read('id'));
      var documentID =
          await FirebaseFirestore.instance.collection("markers").add({
        "userDocumentReference": userDocumentReference,
        "userid": Get.find<StorageServices>().storage.read('id'),
        "datecreated": DateTime.now(),
        "description": description.text,
        "fishes": fishesList
      });
      await setGeoPoint(documentID: documentID.id);
      Get.find<HomeController>().getMarkers();
      Get.back();
      isCreating(false);
    } on Exception catch (e) {
      print(e);
    }
    isCreating(false);
  }

  setGeoPoint({required String documentID}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    GeoFirestore geoFirestore = GeoFirestore(firestore.collection('markers'));
    await geoFirestore.setLocation(documentID, GeoPoint(lat.value, long.value));
  }
}
