import 'package:get/get.dart';

import 'sync_status_controller.dart';

class SyncStatusBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<SyncStatusController>(
      () => SyncStatusController(),
    );

  }
}