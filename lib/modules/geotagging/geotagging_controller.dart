import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

class GeoTaggingController extends GetxController {
  //------------------------------------------
  // LOCATION
  //------------------------------------------

  RxString latitude = "--".obs;
  RxString longitude = "--".obs;
  RxString accuracy = "--".obs;
  RxString time = "--".obs;

  //------------------------------------------
  // TEXT CONTROLLERS
  //------------------------------------------

  final barcodeController = TextEditingController();
  final weightController = TextEditingController();
  final remarksController = TextEditingController();

  //------------------------------------------
  // PHOTO PATHS
  //------------------------------------------

  RxString photo1Path = "".obs;
  RxString photo2Path = "".obs;

  //------------------------------------------
  // MAP TYPE
  //------------------------------------------

  RxBool satelliteMap = true.obs;

  @override
  void onReady() {
    super.onReady();
    getCurrentLocation();
  }

  @override
  void onClose() {
    barcodeController.dispose();
    weightController.dispose();
    remarksController.dispose();
    super.onClose();
  }

  //--------------------------------------------------
  // GET CURRENT LOCATION
  //--------------------------------------------------

  Future<void> getCurrentLocation() async {
    // TODO:
    // Replace with Geolocator later

    latitude.value = "13.028900";
    longitude.value = "77.589400";
    accuracy.value = "4.8 m";
    time.value = DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now());

    debugPrint("Location Updated");
  }

  //--------------------------------------------------
  // CHANGE MAP TYPE
  //--------------------------------------------------

  void changeMapType() {
    satelliteMap.value = !satelliteMap.value;

    debugPrint(satelliteMap.value ? "Satellite View" : "Street View");
  }

  //--------------------------------------------------
  // CAPTURE PHOTO 1
  //--------------------------------------------------

  Future<void> capturePhoto1() async {
    // TODO:
    // ImagePicker / Camera

    photo1Path.value = "photo1.jpg";

    debugPrint("Photo 1 Captured");
  }

  //--------------------------------------------------
  // CAPTURE PHOTO 2
  //--------------------------------------------------

  Future<void> capturePhoto2() async {
    // TODO:
    // ImagePicker / Camera

    photo2Path.value = "photo2.jpg";

    debugPrint("Photo 2 Captured");
  }

  //--------------------------------------------------
  // BARCODE SCAN
  //--------------------------------------------------

  Future<void> scanBarcode() async {
    // TODO:
    // Barcode Scanner

    barcodeController.text = "HL-2026-000125";

    debugPrint("Barcode Scanned");
  }

  //--------------------------------------------------
  // SAVE DRAFT
  //--------------------------------------------------

  Future<void> saveDraft() async {
    // TODO:
    // Save to SQLite

    Get.snackbar(
      "Saved",
      "Draft saved successfully",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  //--------------------------------------------------
  // SUBMIT
  //--------------------------------------------------

  Future<void> submitData() async {
    if (barcodeController.text.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please scan barcode",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (photo1Path.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Capture Photo 1",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (photo2Path.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Capture Photo 2",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (weightController.text.isEmpty) {
      Get.snackbar(
        "Validation",
        "Enter Product Weight",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    Get.back();

    Get.snackbar(
      "Success",
      "Geo Tagging Completed",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void goToProductDetails() {
    Get.toNamed(AppRoutes.productDetails);
  }
}
