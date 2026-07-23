import 'package:get/get.dart';
import 'geotagging_controller.dart';

class GeoTaggingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeoTaggingController>(
      () => GeoTaggingController(),
    );
  }
}