import 'package:get/get.dart';

import 'family_info_controller.dart';

class FamilyInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FamilyInfoController());
  }
}
