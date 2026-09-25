import 'package:get/get.dart';

import 'data_view_controller.dart';

class DataViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataViewController>(
      () => DataViewController(),
    );
  }
}