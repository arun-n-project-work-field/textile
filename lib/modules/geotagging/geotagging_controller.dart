import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  void onInit() {
    super.onInit();

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
  // GET LOCATION
  //--------------------------------------------------

  Future<void> getCurrentLocation() async {

    // Temporary values.
    // Replace with Geolocator later.

    latitude.value = "13.028900";

    longitude.value = "77.589400";

    accuracy.value = "4.8 m";

    time.value =
        DateFormat("dd-MM-yyyy  hh:mm a").format(DateTime.now());

    Get.snackbar(
      "Location",
      "Current location updated",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // MAP TYPE
  //--------------------------------------------------

  void changeMapType() {

    satelliteMap.value = !satelliteMap.value;

    Get.snackbar(
      "Map",
      satelliteMap.value
          ? "Satellite View"
          : "Street View",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // CAMERA 1
  //--------------------------------------------------

  Future<void> capturePhoto1() async {

    // TODO:
    // ImagePicker

    photo1Path.value = "photo1.jpg";

    Get.snackbar(
      "Photo",
      "Photo 1 Captured",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // CAMERA 2
  //--------------------------------------------------

  Future<void> capturePhoto2() async {

    // TODO:
    // ImagePicker

    photo2Path.value = "photo2.jpg";

    Get.snackbar(
      "Photo",
      "Photo 2 Captured",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // BARCODE
  //--------------------------------------------------

  Future<void> scanBarcode() async {

    // TODO:
    // Mobile Scanner

    barcodeController.text = "HL-2026-000125";

    Get.snackbar(
      "Barcode",
      "Barcode Scanned Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //--------------------------------------------------
  // SAVE
  //--------------------------------------------------

  Future<void> saveDraft() async {

    // TODO:
    // SQLite Save

    Get.snackbar(
      "Saved",
      "Draft saved successfully",
      snackPosition: SnackPosition.BOTTOM,
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
      );

      return;
    }

    if (photo1Path.value.isEmpty) {

      Get.snackbar(
        "Validation",
        "Capture Photo 1",
      );

      return;
    }

    if (photo2Path.value.isEmpty) {

      Get.snackbar(
        "Validation",
        "Capture Photo 2",
      );

      return;
    }

    if (weightController.text.isEmpty) {

      Get.snackbar(
        "Validation",
        "Enter Product Weight",
      );

      return;
    }

    // TODO

    // SQLite

    // API

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    Get.back();

    Get.snackbar(
      "Success",
      "Geo Tagging Completed",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}