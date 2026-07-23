import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductManagementController extends GetxController {

  //-------------------------------------------------
  // HANDLOOM DETAILS
  //-------------------------------------------------

  RxString handloomId = "HL-2026-000001".obs;

  //-------------------------------------------------
  // PRODUCT LIST
  //-------------------------------------------------

  RxList<ProductModel> products = <ProductModel>[].obs;

  //-------------------------------------------------
  // INITIAL DATA
  //-------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    loadDummyProducts();
  }

  void loadDummyProducts() {

    products.addAll([

      ProductModel(
        name: "Cotton Saree",
        category: "Saree",
        barcode: "PRD-100001",
        weight: 0.75,
      ),

      ProductModel(
        name: "Silk Saree",
        category: "Saree",
        barcode: "PRD-100002",
        weight: 0.90,
      ),
    ]);
  }

  //-------------------------------------------------
  // ADD PRODUCT
  //-------------------------------------------------

  void addProduct() {

    Get.snackbar(
      "Add Product",
      "Navigate to Add Product Screen",
      snackPosition: SnackPosition.BOTTOM,
    );

    // Later:
    // Get.toNamed(AppRoutes.addProduct);
  }

  //-------------------------------------------------
  // EDIT PRODUCT
  //-------------------------------------------------

  void editProduct(int index) {

    Get.snackbar(
      "Edit Product",
      "Edit ${products[index].name}",
      snackPosition: SnackPosition.BOTTOM,
    );

    // Later:
    // Get.toNamed(AppRoutes.addProduct, arguments: products[index]);
  }

  //-------------------------------------------------
  // DELETE PRODUCT
  //-------------------------------------------------

  void deleteProduct(int index) {

    Get.defaultDialog(
      title: "Delete Product",
      middleText: "Are you sure you want to delete this product?",

      textCancel: "Cancel",

      textConfirm: "Delete",

      confirmTextColor: Colors.white,

      onConfirm: () {

        products.removeAt(index);

        Get.back();

        Get.snackbar(
          "Deleted",
          "Product removed successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  //-------------------------------------------------
  // SAVE DRAFT
  //-------------------------------------------------

  void saveDraft() {

    Get.snackbar(
      "Saved",
      "Products saved successfully",
      snackPosition: SnackPosition.BOTTOM,
    );

    // TODO
    // SQLite Save
  }

  //-------------------------------------------------
  // CONTINUE
  //-------------------------------------------------

  void continueNext() {

    if (products.isEmpty) {

      Get.snackbar(
        "Validation",
        "Please add at least one product",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    Get.snackbar(
      "Success",
      "Proceeding to Preview Screen",
      snackPosition: SnackPosition.BOTTOM,
    );

    // TODO
    // Get.toNamed(AppRoutes.preview);
  }
}