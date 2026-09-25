import 'package:get/get.dart';

import 'sync_data_controller.dart';

class SyncDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncDataController>(
      () => SyncDataController(),
    );
  }
}