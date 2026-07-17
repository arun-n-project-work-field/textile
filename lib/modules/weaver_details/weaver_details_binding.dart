import 'package:get/get.dart';

import 'weaver_details_controller.dart';

class WeaverDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeaverDetailsController());
  }
}
