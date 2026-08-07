// import 'package:get/get.dart';
// import 'package:namma_kaimagga_app/models/product_model.dart';
// import '../../routes/app_routes.dart';
// import 'package:flutter/material.dart';




// class ProductListController extends GetxController {

//   //------------------------------------------------
//   // Handloom ID
//   //------------------------------------------------

//   final String handloomId = "HLM000001";

//   //------------------------------------------------
//   // Product List
//   //------------------------------------------------

//   final RxList<ProductModel> products = <ProductModel>[].obs;

//   //------------------------------------------------
//   // Total Products
//   //------------------------------------------------

//   int get totalProducts => products.length;

//   //------------------------------------------------
//   // Total Amount
//   //------------------------------------------------

//   double get totalAmount {
//     double total = 0;

//     for (final product in products) {
//       total += product.price * product.quantity;
//     }

//     return total;
//   }

//   //------------------------------------------------
//   // Navigate to Add Product
//   //------------------------------------------------

//   void goToAddProduct() {
//     Get.toNamed(AppRoutes.addProduct);
//   }

//   //------------------------------------------------
//   // Add Product
//   //------------------------------------------------

//   void addProduct(ProductModel product) {
//     products.add(product);
//   }

//   //------------------------------------------------
//   // Edit Product
//   //------------------------------------------------

//   void editProduct(int index) {

//     Get.toNamed(
//       AppRoutes.addProduct,
//       arguments: {
//         "edit": true,
//         "index": index,
//         "product": products[index],
//       },
//     );
//   }

//   //------------------------------------------------
//   // Delete Product
//   //------------------------------------------------

//   void deleteProduct(int index) {

//     Get.defaultDialog(
//       title: "Delete Product",
//       middleText:
//           "Are you sure you want to delete this product?",

//       textConfirm: "Delete",
//       textCancel: "Cancel",

//       confirmTextColor: Colors.white,

//       onConfirm: () {

//         products.removeAt(index);

//         Get.back();

//         Get.snackbar(
//           "Deleted",
//           "Product deleted successfully.",
//         );
//       },
//     );
//   }

//   //------------------------------------------------
//   // Barcode
//   //------------------------------------------------

//   void viewBarcode(ProductModel product) {

//     Get.defaultDialog(

//       title: "Barcode",

//       middleText:
//           "Barcode Number\n\n${product.barcode}",

//       textConfirm: "Close",

//       confirmTextColor: Colors.white,

//       onConfirm: () {

//         Get.back();
//       },
//     );
//   }

//   //------------------------------------------------
//   // Finish
//   //------------------------------------------------

//   void continueNext() {

//     if (products.isEmpty) {

//       Get.snackbar(
//         "Products",
//         "Please add at least one product.",
//       );

//       return;
//     }

//     Get.toNamed(AppRoutes.preview);
//   }

//   //------------------------------------------------
//   // Dummy Data
//   //------------------------------------------------

//   @override
//   void onInit() {

//     super.onInit();

//     // Uncomment for testing

//     /*
//     products.addAll([
//       ProductModel(
//         id: "1",
//         productName: "Silk Saree",
//         category: "Saree",
//         barcode: "HL20260001",
//         quantity: 2,
//         weight: 1.2,
//         price: 3500,
//       ),
//       ProductModel(
//         id: "2",
//         productName: "Cotton Shawl",
//         category: "Shawl",
//         barcode: "HL20260002",
//         quantity: 5,
//         weight: 0.8,
//         price: 900,
//       ),
//     ]);
//     */
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:namma_kaimagga_app/models/product_model.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

class ProductListController extends GetxController {
  // ==========================================================
  // HANDLOOM ID
  // ==========================================================

  late String handloomId;

  // ==========================================================
  // PRODUCT LIST
  // ==========================================================

  final RxList<ProductModel> products =
      <ProductModel>[].obs;

  // ==========================================================
  // INITIALIZATION
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    _getHandloomId();
  }

  // ==========================================================
  // GET HANDLOOM ID
  // ==========================================================

  void _getHandloomId() {
    final arguments = Get.arguments;

    if (arguments is Map &&
        arguments["handloomId"] != null) {
      handloomId =
          arguments["handloomId"].toString();
    } else {
      // Fallback only for testing.
      handloomId = "HLM000001";
    }
  }

  // ==========================================================
  // TOTAL PRODUCTS
  // ==========================================================

  int get totalProducts =>
      products.length;

  // ==========================================================
  // TOTAL QUANTITY
  // ==========================================================

  int get totalQuantity {
    int total = 0;

    for (final product in products) {
      total += product.quantity;
    }

    return total;
  }

  // ==========================================================
  // TOTAL AMOUNT
  // ==========================================================

  double get totalAmount {
    double total = 0;

    for (final product in products) {
      total +=
          product.price *
          product.quantity;
    }

    return total;
  }

  // ==========================================================
  // ADD PRODUCT SCREEN
  // ==========================================================

  void goToAddProduct() {
    Get.toNamed(
      AppRoutes.addProduct,
      arguments: {
        "handloomId": handloomId,
      },
    );
  }

  // ==========================================================
  // ADD PRODUCT
  // ==========================================================

  void addProduct(
    ProductModel product,
  ) {
    products.add(product);
  }

  // ==========================================================
  // EDIT PRODUCT
  // ==========================================================

  void editProduct(
    int index,
  ) {
    if (index < 0 ||
        index >= products.length) {
      return;
    }

    Get.toNamed(
      AppRoutes.addProduct,
      arguments: {
        "edit": true,
        "index": index,
        "product": products[index],
        "handloomId": handloomId,
      },
    );
  }

  // ==========================================================
  // DELETE PRODUCT
  // ==========================================================

  void deleteProduct(
    int index,
  ) {
    if (index < 0 ||
        index >= products.length) {
      return;
    }

    Get.defaultDialog(
      title: "Delete Product",
      middleText:
          "Are you sure you want to delete this product?",

      textConfirm: "Delete",
      textCancel: "Cancel",

      confirmTextColor:
          Colors.white,

      onConfirm: () {
        products.removeAt(index);

        Get.back();

        Get.snackbar(
          "Deleted",
          "Product deleted successfully.",
          snackPosition:
              SnackPosition.BOTTOM,
        );
      },
    );
  }

  // ==========================================================
  // VIEW BARCODE
  // ==========================================================

  void viewBarcode(
    ProductModel product,
  ) {
    Get.defaultDialog(
      title: "Barcode",
      middleText:
          "Barcode Number\n\n${product.barcode}",
      textConfirm: "Close",
      confirmTextColor:
          Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }

  // ==========================================================
  // CONTINUE TO PREVIEW
  // ==========================================================

  void continueNext() {
    if (products.isEmpty) {
      Get.snackbar(
        "Products",
        "Please add at least one product.",
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    Get.toNamed(
      AppRoutes.preview,
      arguments: {
        "handloomId": handloomId,
      },
    );
  }

  // ==========================================================
  // CLEAR PRODUCTS
  // ==========================================================

  void clearProducts() {
    products.clear();
  }
}