import 'package:get/get.dart';

import 'weaver_list_controller.dart';

class WeaverListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeaverListController());
  }
}
