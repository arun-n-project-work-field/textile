// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:namma_kaimagga_app/routes/app_routes.dart';

// class GeoTaggingController extends GetxController {
//   //------------------------------------------
//   // LOCATION
//   //------------------------------------------

//   RxString latitude = "--".obs;
//   RxString longitude = "--".obs;
//   RxString accuracy = "--".obs;
//   RxString time = "--".obs;

//   //------------------------------------------
//   // TEXT CONTROLLERS
//   //------------------------------------------

//   final barcodeController = TextEditingController();
//   final weightController = TextEditingController();
//   final remarksController = TextEditingController();

//   //------------------------------------------
//   // PHOTO PATHS
//   //------------------------------------------

//   RxString photo1Path = "".obs;
//   RxString photo2Path = "".obs;

//   //------------------------------------------
//   // MAP TYPE
//   //------------------------------------------

//   RxBool satelliteMap = true.obs;

//   @override
//   void onReady() {
//     super.onReady();
//     getCurrentLocation();
//   }

//   @override
//   void onClose() {
//     barcodeController.dispose();
//     weightController.dispose();
//     remarksController.dispose();
//     super.onClose();
//   }

//   //--------------------------------------------------
//   // GET CURRENT LOCATION
//   //--------------------------------------------------

//   Future<void> getCurrentLocation() async {
//     // TODO:
//     // Replace with Geolocator later

//     latitude.value = "13.028900";
//     longitude.value = "77.589400";
//     accuracy.value = "4.8 m";
//     time.value = DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now());

//     debugPrint("Location Updated");
//   }

//   //--------------------------------------------------
//   // CHANGE MAP TYPE
//   //--------------------------------------------------

//   void changeMapType() {
//     satelliteMap.value = !satelliteMap.value;

//     debugPrint(satelliteMap.value ? "Satellite View" : "Street View");
//   }

//   //--------------------------------------------------
//   // CAPTURE PHOTO 1
//   //--------------------------------------------------

//   Future<void> capturePhoto1() async {
//     // TODO:
//     // ImagePicker / Camera

//     photo1Path.value = "photo1.jpg";

//     debugPrint("Photo 1 Captured");
//   }

//   //--------------------------------------------------
//   // CAPTURE PHOTO 2
//   //--------------------------------------------------

//   Future<void> capturePhoto2() async {
//     // TODO:
//     // ImagePicker / Camera

//     photo2Path.value = "photo2.jpg";

//     debugPrint("Photo 2 Captured");
//   }

//   //--------------------------------------------------
//   // BARCODE SCAN
//   //--------------------------------------------------

//   Future<void> scanBarcode() async {
//     // TODO:
//     // Barcode Scanner

//     barcodeController.text = "HL-2026-000125";

//     debugPrint("Barcode Scanned");
//   }

//   //--------------------------------------------------
//   // SAVE DRAFT
//   //--------------------------------------------------

//   Future<void> saveDraft() async {
//     // TODO:
//     // Save to SQLite

//     Get.snackbar(
//       "Saved",
//       "Draft saved successfully",
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   //--------------------------------------------------
//   // SUBMIT
//   //--------------------------------------------------

//   Future<void> submitData() async {
//     if (barcodeController.text.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please scan barcode",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Capture Photo 1",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Capture Photo 2",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (weightController.text.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Enter Product Weight",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );

//     await Future.delayed(const Duration(seconds: 2));

//     Get.back();

//     Get.snackbar(
//       "Success",
//       "Geo Tagging Completed",
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   void goToProductDetails() {
//     Get.toNamed(AppRoutes.productDetails);
//   }
// }




import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';



class GeoTaggingController extends GetxController {
  // ==========================================================
  // IMAGE PICKER
  // ==========================================================

  final ImagePicker _picker = ImagePicker();

  // ==========================================================
  // LOADING
  // ==========================================================

  final RxBool isLoading = false.obs;

  // ==========================================================
  // LOCATION
  // ==========================================================

  final RxString latitude = "".obs;

  final RxString longitude = "".obs;

  final RxString accuracy = "".obs;

  final RxString time = "".obs;

  // ==========================================================
  // PHOTOS
  // ==========================================================

  final RxString photo1Path = "".obs;

  final RxString photo2Path = "".obs;

  // ==========================================================
  // REMARKS
  // ==========================================================

  final TextEditingController remarksController =
      TextEditingController();

  // ==========================================================
  // MAP TYPE
  // ==========================================================

  final RxBool satelliteMap = false.obs;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    getCurrentLocation();
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void onClose() {
    remarksController.dispose();

    super.onClose();
  }

  // ==========================================================
  // GET CURRENT LOCATION
  // ==========================================================

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar(
          "Location",
          "Please enable location services.",
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location",
          "Location permission denied.",
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      if (permission ==
          LocationPermission.deniedForever) {
        Get.snackbar(
          "Location",
          "Location permission permanently denied.",
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      final Position position =
          await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude.value =
          position.latitude.toStringAsFixed(6);

      longitude.value =
          position.longitude.toStringAsFixed(6);

      accuracy.value =
          "${position.accuracy.toStringAsFixed(2)} m";

      time.value =
          DateFormat("dd-MM-yyyy HH:mm:ss")
              .format(DateTime.now());
    } catch (e) {
      Get.snackbar(
        "Location Error",
        "Unable to get current location.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // CHANGE MAP TYPE
  // ==========================================================

  void changeMapType() {
    satelliteMap.value = !satelliteMap.value;

    Get.snackbar(
      "Map",
      satelliteMap.value
          ? "Satellite map selected."
          : "Normal map selected.",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  // ==========================================================
  // CAPTURE PHOTO 1
  // ==========================================================

  Future<void> capturePhoto1() async {
    try {
      final XFile? image =
          await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      photo1Path.value = image.path;

      Get.snackbar(
        "Photo",
        "Handloom photo captured.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Camera Error",
        "Unable to capture photo.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ==========================================================
  // CAPTURE PHOTO 2
  // ==========================================================

  Future<void> capturePhoto2() async {
    try {
      final XFile? image =
          await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      photo2Path.value = image.path;

      Get.snackbar(
        "Photo",
        "Weaver and handloom photo captured.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Camera Error",
        "Unable to capture photo.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ==========================================================
  // REMOVE PHOTO 1
  // ==========================================================

  void removePhoto1() {
    photo1Path.value = "";

    Get.snackbar(
      "Photo",
      "Handloom photo removed.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ==========================================================
  // REMOVE PHOTO 2
  // ==========================================================

  void removePhoto2() {
    photo2Path.value = "";

    Get.snackbar(
      "Photo",
      "Weaver and handloom photo removed.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ==========================================================
  // SAVE DRAFT
  // ==========================================================

  void saveDraft() {
    if (latitude.value.isEmpty ||
        longitude.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please capture the location first.",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    Get.snackbar(
      "Saved",
      "Geo tagging data saved as draft.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ==========================================================
  // NEXT
  // ==========================================================

  void next() {
    if (latitude.value.isEmpty ||
        longitude.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please capture the location before continuing.",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (photo1Path.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please capture the Handloom Photo.",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (photo2Path.value.isEmpty) {
      Get.snackbar(
        "Validation",
        "Please capture the Weaver + Handloom Photo.",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    Get.toNamed(AppRoutes.productList);
  }
}