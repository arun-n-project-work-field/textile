import 'package:get/get.dart';

import 'product_management_controller.dart';

class ProductManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductManagementController>(
      () => ProductManagementController(),
    );
  }
}