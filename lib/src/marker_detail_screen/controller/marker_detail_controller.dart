import 'package:get/get.dart';
import 'package:smartfisher/src/home_screen/model/home_markers_model.dart';

class MarkerDetailController extends GetxController {
  RxBool isLoading = true.obs;
  Markers markerDetail = Markers(
      userDetails: UserDetails(
          password: "",
          firstname: "",
          devicename: "",
          deviceId: "",
          username: "",
          lastname: ""),
      datecreated: DateTime.now(),
      description: "",
      fishes: [],
      location: [0.0, 0.0],
      userid: "");
  @override
  void onInit() async {
    markerDetail = await Get.arguments['markerDetails'];
    isLoading(false);
    super.onInit();
  }
}
