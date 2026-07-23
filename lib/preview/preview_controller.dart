// import 'package:get/get.dart';
// import '../product-list/product_list_controller.dart';
// import 'package:flutter/material.dart';

// class PreviewController extends GetxController {

//   //--------------------------------------------
//   // LOCATION
//   //--------------------------------------------

//   RxString latitude = "".obs;
//   RxString longitude = "".obs;
//   RxString accuracy = "".obs;
//   RxString date = "".obs;

//   //--------------------------------------------
//   // PHOTOS
//   //--------------------------------------------

//   RxString photo1 = "".obs;
//   RxString photo2 = "".obs;

//   //--------------------------------------------
//   // PRODUCTS
//   //--------------------------------------------

//   final ProductListController productController =
//       Get.find<ProductListController>();

//   //--------------------------------------------
//   // INIT
//   //--------------------------------------------

//   @override
//   void onInit() {
//     super.onInit();

//     loadData();
//   }

//   //--------------------------------------------
//   // LOAD DATA
//   //--------------------------------------------

//   void loadData() {

//     // TODO:
//     // Replace these with actual GeoTaggingController values

//     latitude.value = "13.028900";

//     longitude.value = "77.589400";

//     accuracy.value = "4.8 m";

//     date.value = "10 Jul 2026";

//     photo1.value = "";

//     photo2.value = "";

//     products.assignAll(productController.products);
//   }

//   //--------------------------------------------
//   // TOTAL VALUE
//   //--------------------------------------------

//   double get totalAmount {

//     double total = 0;

//     for (final product in products) {

//       total += product.price * product.quantity;
//     }

//     return total;
//   }
//     //--------------------------------------------
//   // SAVE OFFLINE
//   //--------------------------------------------

//   Future<void> saveOffline() async {

//     // TODO:
//     // Save GeoTag + Products to SQLite

//     Get.dialog(
//       const Center(
//         child: CircularProgressIndicator(),
//       ),
//       barrierDismissible: false,
//     );

//     await Future.delayed(
//       const Duration(seconds: 2),
//     );

//     Get.back();

//     Get.snackbar(
//       "Saved",
//       "Survey saved successfully.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   //--------------------------------------------
//   // SYNC DATA
//   //--------------------------------------------

//   Future<void> syncData() async {

//     // TODO:
//     // Upload GeoTag + Products + Images to API

//     Get.dialog(
//       const Center(
//         child: CircularProgressIndicator(),
//       ),
//       barrierDismissible: false,
//     );

//     await Future.delayed(
//       const Duration(seconds: 3),
//     );

//     Get.back();

//     Get.defaultDialog(
//       title: "Success",
//       middleText:
//           "Geo-tagging and product information uploaded successfully.",
//       textConfirm: "Finish",
//       confirmTextColor: Get.theme.colorScheme.onPrimary,
//       onConfirm: finishSurvey,
//     );
//   }

//   //--------------------------------------------
//   // EDIT PRODUCTS
//   //--------------------------------------------

//   void editProducts() {

//     Get.back();

//     Get.toNamed("/product-list");
//   }

//   //--------------------------------------------
//   // FINISH SURVEY
//   //--------------------------------------------

//   void finishSurvey() {

//     Get.back();

//     Get.offAllNamed("/dashboard");
//   }

//   //--------------------------------------------
//   // RESET SCREEN
//   //--------------------------------------------

//   void clearAll() {

//     latitude.value = "";

//     longitude.value = "";

//     accuracy.value = "";

//     date.value = "";

//     photo1.value = "";

//     photo2.value = "";

//     products.clear();
//   }

//   //--------------------------------------------
//   // REFRESH
//   //--------------------------------------------

//   Future<void> refreshData() async {

//     loadData();
//   }
// }

import 'dart:io';

import 'package:get/get.dart';
import 'package:namma_kaimagga_app/product-list/product_list_controller.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class PreviewController extends GetxController {
  //---------------------------------------------------
  // GEO TAG DETAILS
  //---------------------------------------------------

  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString accuracy = "".obs;
  RxString date = "".obs;

  //---------------------------------------------------
  // PHOTOS
  //---------------------------------------------------

  RxString photo1 = "".obs;
  RxString photo2 = "".obs;

  File get photo1File => File(photo1.value);

  File get photo2File => File(photo2.value);

  //---------------------------------------------------
  // PRODUCTS
  //---------------------------------------------------

  final ProductListController productController =
      Get.find<ProductListController>();

  List<ProductModel> get products => productController.products;

  //---------------------------------------------------
  // TOTALS
  //---------------------------------------------------

  int get totalQuantity {
    int total = 0;

    for (final item in products) {
      total += item.quantity;
    }

    return total;
  }

  double get totalAmount {
    double total = 0;

    for (final item in products) {
      total += item.price * item.quantity;
    }

    return total;
  }

  //---------------------------------------------------
  // INIT
  //---------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  //---------------------------------------------------
  // LOAD DATA
  //---------------------------------------------------

  void loadData() {
    // TODO
    // Load these values from GeoTaggingController
    // or SQLite database.

    latitude.value = "13.035240";

    longitude.value = "77.597800";

    accuracy.value = "3.5 m";

    date.value = DateTime.now().toString();

    photo1.value = "";

    photo2.value = "";
  }

  //---------------------------------------------------
  // SAVE OFFLINE
  //---------------------------------------------------

  Future<void> saveOffline() async {
    // TODO:
    // Save complete survey to SQLite

    Get.snackbar(
      "Saved",
      "Data saved successfully in offline storage.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //---------------------------------------------------
  // GENERATE QR REPORT
  //---------------------------------------------------

  Future<void> generateReport() async {
    // TODO:
    // Generate PDF containing
    // - Geo Tag
    // - Photos
    // - Product Details
    // - QR Codes

    Get.snackbar(
      "Report",
      "QR Report generated successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //---------------------------------------------------
  // SUBMIT TO SERVER
  //---------------------------------------------------

  Future<void> submitData() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    Get.back();

    // TODO:
    // Upload complete data to API
    // Upload images
    // Upload barcode information
    // Upload geo-tag

    Get.defaultDialog(
      title: "Success",

      middleText: "Handloom details have been submitted successfully.",

      textConfirm: "OK",

      confirmTextColor: Colors.white,

      onConfirm: () {
        Get.back();

        Get.offAllNamed("/dashboard");
      },
    );
  }

  //---------------------------------------------------
  // RESET
  //---------------------------------------------------

  void reset() {
    latitude.value = "";

    longitude.value = "";

    accuracy.value = "";

    date.value = "";

    photo1.value = "";

    photo2.value = "";
  }
}
