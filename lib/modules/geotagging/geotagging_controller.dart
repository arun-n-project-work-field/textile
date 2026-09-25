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

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:namma_kaimagga_app/routes/app_routes.dart';

// class GeoTaggingController extends GetxController {
//   // ==========================================================
//   // IMAGE PICKER
//   // ==========================================================

//   final ImagePicker _picker = ImagePicker();

//   // ==========================================================
//   // LOADING
//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   // ==========================================================
//   // LOCATION
//   // ==========================================================

//   final RxString latitude = "".obs;

//   final RxString longitude = "".obs;

//   final RxString accuracy = "".obs;

//   final RxString time = "".obs;

//   // ==========================================================
//   // PHOTOS
//   // ==========================================================

//   final RxString photo1Path = "".obs;

//   final RxString photo2Path = "".obs;

//   // ==========================================================
//   // REMARKS
//   // ==========================================================

//   final TextEditingController remarksController =
//       TextEditingController();

//   // ==========================================================
//   // MAP TYPE
//   // ==========================================================

//   final RxBool satelliteMap = false.obs;

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     getCurrentLocation();
//   }

//   // ==========================================================
//   // DISPOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     remarksController.dispose();

//     super.onClose();
//   }

//   // ==========================================================
//   // GET CURRENT LOCATION
//   // ==========================================================

//   Future<void> getCurrentLocation() async {
//     try {
//       isLoading.value = true;

//       bool serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         Get.snackbar(
//           "Location",
//           "Please enable location services.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//           "Location",
//           "Location permission denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       if (permission ==
//           LocationPermission.deniedForever) {
//         Get.snackbar(
//           "Location",
//           "Location permission permanently denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       final Position position =
//           await Geolocator.getCurrentPosition(
//         locationSettings:
//             const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       latitude.value =
//           position.latitude.toStringAsFixed(6);

//       longitude.value =
//           position.longitude.toStringAsFixed(6);

//       accuracy.value =
//           "${position.accuracy.toStringAsFixed(2)} m";

//       time.value =
//           DateFormat("dd-MM-yyyy HH:mm:ss")
//               .format(DateTime.now());
//     } catch (e) {
//       Get.snackbar(
//         "Location Error",
//         "Unable to get current location.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // CHANGE MAP TYPE
//   // ==========================================================

//   void changeMapType() {
//     satelliteMap.value = !satelliteMap.value;

//     Get.snackbar(
//       "Map",
//       satelliteMap.value
//           ? "Satellite map selected."
//           : "Normal map selected.",
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 1),
//     );
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 1
//   // ==========================================================

//   Future<void> capturePhoto1() async {
//     try {
//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       photo1Path.value = image.path;

//       Get.snackbar(
//         "Photo",
//         "Handloom photo captured.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 2
//   // ==========================================================

//   Future<void> capturePhoto2() async {
//     try {
//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       photo2Path.value = image.path;

//       Get.snackbar(
//         "Photo",
//         "Weaver and handloom photo captured.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================
//   // REMOVE PHOTO 1
//   // ==========================================================

//   void removePhoto1() {
//     photo1Path.value = "";

//     Get.snackbar(
//       "Photo",
//       "Handloom photo removed.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // REMOVE PHOTO 2
//   // ==========================================================

//   void removePhoto2() {
//     photo2Path.value = "";

//     Get.snackbar(
//       "Photo",
//       "Weaver and handloom photo removed.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // SAVE DRAFT
//   // ==========================================================

//   void saveDraft() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location first.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.snackbar(
//       "Saved",
//       "Geo tagging data saved as draft.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // NEXT
//   // ==========================================================

//   void next() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location before continuing.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Handloom Photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Weaver + Handloom Photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.toNamed(AppRoutes.productList);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:namma_kaimagga_app/routes/app_routes.dart';

// class GeoTaggingController extends GetxController {
//   // ==========================================================
//   // IMAGE PICKER
//   // ==========================================================

//   final ImagePicker _picker = ImagePicker();

//   // ==========================================================
//   // MAP
//   // ==========================================================

//   final MapController mapController = MapController();

//   // ==========================================================
//   // LOADING
//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   // ==========================================================
//   // LOCATION
//   // ==========================================================

//   final RxString latitude = "".obs;

//   final RxString longitude = "".obs;

//   final RxString accuracy = "".obs;

//   final RxString time = "".obs;

//   // ==========================================================
//   // MAP LOCATION
//   // ==========================================================

//   final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

//   // ==========================================================
//   // PHOTOS
//   // ==========================================================

//   final RxString photo1Path = "".obs;

//   final RxString photo2Path = "".obs;

//   // ==========================================================
//   // REMARKS
//   // ==========================================================

//   final TextEditingController remarksController =
//       TextEditingController();

//   // ==========================================================
//   // MAP TYPE
//   // ==========================================================

//   final RxBool satelliteMap = false.obs;

//   // ==========================================================
//   // MAP ZOOM
//   // ==========================================================

//   final double initialZoom = 16.0;

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     getCurrentLocation();
//   }

//   // ==========================================================
//   // DISPOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     remarksController.dispose();

//     super.onClose();
//   }

//   // ==========================================================
//   // GET CURRENT LOCATION
//   // ==========================================================

//   Future<void> getCurrentLocation({
//     bool moveMap = true,
//   }) async {
//     try {
//       isLoading.value = true;

//       // --------------------------------------------------------
//       // CHECK LOCATION SERVICE
//       // --------------------------------------------------------

//       final bool serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         Get.snackbar(
//           "Location",
//           "Please enable location services.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       // --------------------------------------------------------
//       // CHECK PERMISSION
//       // --------------------------------------------------------

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//           "Location",
//           "Location permission denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       if (permission ==
//           LocationPermission.deniedForever) {
//         Get.snackbar(
//           "Location",
//           "Location permission permanently denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       // --------------------------------------------------------
//       // GET POSITION
//       // --------------------------------------------------------

//       final Position position =
//           await Geolocator.getCurrentPosition(
//         locationSettings:
//             const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       // --------------------------------------------------------
//       // SAVE LOCATION VALUES
//       // --------------------------------------------------------

//       final double lat = position.latitude;
//       final double lng = position.longitude;

//       latitude.value =
//           lat.toStringAsFixed(6);

//       longitude.value =
//           lng.toStringAsFixed(6);

//       accuracy.value =
//           "${position.accuracy.toStringAsFixed(2)} m";

//       time.value =
//           DateFormat("dd-MM-yyyy HH:mm:ss")
//               .format(DateTime.now());

//       // --------------------------------------------------------
//       // UPDATE MAP LOCATION
//       // --------------------------------------------------------

//       currentLocation.value =
//           LatLng(lat, lng);

//       // --------------------------------------------------------
//       // MOVE MAP TO CURRENT LOCATION
//       // --------------------------------------------------------

//       if (moveMap) {
//         WidgetsBinding.instance.addPostFrameCallback(
//           (_) {
//             try {
//               mapController.move(
//                 LatLng(lat, lng),
//                 initialZoom,
//               );
//             } catch (_) {
//               // Map may not be mounted yet.
//             }
//           },
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Location Error",
//         "Unable to get current location.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // MOVE MAP TO CURRENT LOCATION
//   // ==========================================================

//   Future<void> moveToCurrentLocation() async {
//     await getCurrentLocation(
//       moveMap: true,
//     );
//   }

//   // ==========================================================
//   // CHANGE MAP TYPE
//   // ==========================================================

//   void changeMapType() {
//     satelliteMap.value =
//         !satelliteMap.value;

//     Get.snackbar(
//       "Map",
//       satelliteMap.value
//           ? "Satellite map selected."
//           : "Normal map selected.",
//       snackPosition: SnackPosition.BOTTOM,
//       duration:
//           const Duration(seconds: 1),
//     );
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 1
//   // ==========================================================

//   Future<void> capturePhoto1() async {
//     try {
//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       photo1Path.value =
//           image.path;

//       Get.snackbar(
//         "Photo",
//         "Handloom photo captured.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 2
//   // ==========================================================

//   Future<void> capturePhoto2() async {
//     try {
//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       photo2Path.value =
//           image.path;

//       Get.snackbar(
//         "Photo",
//         "Weaver and handloom photo captured.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================
//   // REMOVE PHOTO 1
//   // ==========================================================

//   void removePhoto1() {
//     photo1Path.value = "";

//     Get.snackbar(
//       "Photo",
//       "Handloom photo removed.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // REMOVE PHOTO 2
//   // ==========================================================

//   void removePhoto2() {
//     photo2Path.value = "";

//     Get.snackbar(
//       "Photo",
//       "Weaver and handloom photo removed.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // SAVE DRAFT
//   // ==========================================================

//   void saveDraft() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location first.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.snackbar(
//       "Saved",
//       "Geo tagging data saved as draft.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // NEXT
//   // ==========================================================

//   void next() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location before continuing.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Handloom Photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Weaver + Handloom Photo.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.toNamed(
//       AppRoutes.productList,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:namma_kaimagga_app/routes/app_routes.dart';

// class GeoTaggingController extends GetxController {
//   // ==========================================================
//   // IMAGE PICKER
//   // ==========================================================

//   final ImagePicker _picker = ImagePicker();

//   // ==========================================================
//   // MAP
//   // ==========================================================

//   final MapController mapController = MapController();

//   final double initialZoom = 16.0;

//   // ==========================================================
//   // LOADING
//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   // ==========================================================
//   // CURRENT LOCATION
//   // ==========================================================

//   final RxString latitude = "".obs;
//   final RxString longitude = "".obs;
//   final RxString accuracy = "".obs;
//   final RxString time = "".obs;

//   final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

//   // ==========================================================
//   // PHOTO PATHS
//   // ==========================================================

//   final RxString photo1Path = "".obs;
//   final RxString photo2Path = "".obs;

//   // ==========================================================
//   // PHOTO 1 GPS DETAILS
//   // ==========================================================

//   final RxString photo1Latitude = "".obs;
//   final RxString photo1Longitude = "".obs;
//   final RxString photo1DateTime = "".obs;

//   // ==========================================================
//   // PHOTO 2 GPS DETAILS
//   // ==========================================================

//   final RxString photo2Latitude = "".obs;
//   final RxString photo2Longitude = "".obs;
//   final RxString photo2DateTime = "".obs;

//   // ==========================================================
//   // REMARKS
//   // ==========================================================

//   final TextEditingController remarksController =
//       TextEditingController();

//   // ==========================================================
//   // MAP TYPE
//   // ==========================================================

//   final RxBool satelliteMap = false.obs;

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     getCurrentLocation();
//   }

//   // ==========================================================
//   // DISPOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     remarksController.dispose();

//     super.onClose();
//   }

//   // ==========================================================
//   // GET CURRENT LOCATION
//   // ==========================================================

//   Future<Position?> _getPosition() async {
//     try {
//       final bool serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         Get.snackbar(
//           "Location",
//           "Please enable location services.",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return null;
//       }

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//           "Location",
//           "Location permission denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return null;
//       }

//       if (permission ==
//           LocationPermission.deniedForever) {
//         Get.snackbar(
//           "Location",
//           "Location permission permanently denied.",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return null;
//       }

//       final Position position =
//           await Geolocator.getCurrentPosition(
//         locationSettings:
//             const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       return position;
//     } catch (e) {
//       Get.snackbar(
//         "Location Error",
//         "Unable to get current location.",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return null;
//     }
//   }

//   // ==========================================================
//   // GET CURRENT LOCATION
//   // ==========================================================

//   Future<void> getCurrentLocation({
//     bool moveMap = true,
//   }) async {
//     try {
//       isLoading.value = true;

//       final Position? position =
//           await _getPosition();

//       if (position == null) {
//         return;
//       }

//       final double lat = position.latitude;
//       final double lng = position.longitude;

//       latitude.value =
//           lat.toStringAsFixed(6);

//       longitude.value =
//           lng.toStringAsFixed(6);

//       accuracy.value =
//           "${position.accuracy.toStringAsFixed(2)} m";

//       time.value =
//           DateFormat(
//             "dd-MM-yyyy HH:mm:ss",
//           ).format(DateTime.now());

//       currentLocation.value =
//           LatLng(lat, lng);

//       if (moveMap) {
//         WidgetsBinding.instance
//             .addPostFrameCallback((_) {
//           try {
//             mapController.move(
//               LatLng(lat, lng),
//               initialZoom,
//             );
//           } catch (_) {}
//         });
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // MOVE MAP TO CURRENT LOCATION
//   // ==========================================================

//   Future<void> moveToCurrentLocation() async {
//     await getCurrentLocation(
//       moveMap: true,
//     );
//   }

//   // ==========================================================
//   // CHANGE MAP TYPE
//   // ==========================================================

//   void changeMapType() {
//     satelliteMap.value =
//         !satelliteMap.value;

//     Get.snackbar(
//       "Map",
//       satelliteMap.value
//           ? "Satellite map selected."
//           : "Normal map selected.",
//       snackPosition:
//           SnackPosition.BOTTOM,
//       duration:
//           const Duration(seconds: 1),
//     );
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 1
//   // ==========================================================

//   Future<void> capturePhoto1() async {
//     try {
//       isLoading.value = true;

//       // --------------------------------------------------------
//       // CAPTURE GPS AT PHOTO TIME
//       // --------------------------------------------------------

//       final Position? position =
//           await _getPosition();

//       if (position == null) {
//         return;
//       }

//       // --------------------------------------------------------
//       // CAPTURE IMAGE
//       // --------------------------------------------------------

//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       // --------------------------------------------------------
//       // SAVE PHOTO
//       // --------------------------------------------------------

//       photo1Path.value =
//           image.path;

//       // --------------------------------------------------------
//       // SAVE PHOTO GPS
//       // --------------------------------------------------------

//       photo1Latitude.value =
//           position.latitude.toStringAsFixed(6);

//       photo1Longitude.value =
//           position.longitude.toStringAsFixed(6);

//       photo1DateTime.value =
//           DateFormat(
//             "dd-MM-yyyy HH:mm:ss",
//           ).format(DateTime.now());

//       // --------------------------------------------------------
//       // ALSO UPDATE CURRENT LOCATION
//       // --------------------------------------------------------

//       latitude.value =
//           position.latitude.toStringAsFixed(6);

//       longitude.value =
//           position.longitude.toStringAsFixed(6);

//       accuracy.value =
//           "${position.accuracy.toStringAsFixed(2)} m";

//       time.value =
//           photo1DateTime.value;

//       currentLocation.value =
//           LatLng(
//         position.latitude,
//         position.longitude,
//       );

//       // --------------------------------------------------------
//       // MOVE MAP
//       // --------------------------------------------------------

//       WidgetsBinding.instance
//           .addPostFrameCallback((_) {
//         try {
//           mapController.move(
//             currentLocation.value!,
//             initialZoom,
//           );
//         } catch (_) {}
//       });

//       Get.snackbar(
//         "Photo",
//         "Handloom photo captured.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 2
//   // ==========================================================

//   Future<void> capturePhoto2() async {
//     try {
//       isLoading.value = true;

//       // --------------------------------------------------------
//       // CAPTURE GPS AT PHOTO TIME
//       // --------------------------------------------------------

//       final Position? position =
//           await _getPosition();

//       if (position == null) {
//         return;
//       }

//       // --------------------------------------------------------
//       // CAPTURE IMAGE
//       // --------------------------------------------------------

//       final XFile? image =
//           await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );

//       if (image == null) {
//         return;
//       }

//       // --------------------------------------------------------
//       // SAVE PHOTO
//       // --------------------------------------------------------

//       photo2Path.value =
//           image.path;

//       // --------------------------------------------------------
//       // SAVE PHOTO GPS
//       // --------------------------------------------------------

//       photo2Latitude.value =
//           position.latitude.toStringAsFixed(6);

//       photo2Longitude.value =
//           position.longitude.toStringAsFixed(6);

//       photo2DateTime.value =
//           DateFormat(
//             "dd-MM-yyyy HH:mm:ss",
//           ).format(DateTime.now());

//       Get.snackbar(
//         "Photo",
//         "Weaver and handloom photo captured.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Camera Error",
//         "Unable to capture photo.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // REMOVE PHOTO 1
//   // ==========================================================

//   void removePhoto1() {
//     photo1Path.value = "";

//     photo1Latitude.value = "";
//     photo1Longitude.value = "";
//     photo1DateTime.value = "";

//     Get.snackbar(
//       "Photo",
//       "Handloom photo removed.",
//       snackPosition:
//           SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // REMOVE PHOTO 2
//   // ==========================================================

//   void removePhoto2() {
//     photo2Path.value = "";

//     photo2Latitude.value = "";
//     photo2Longitude.value = "";
//     photo2DateTime.value = "";

//     Get.snackbar(
//       "Photo",
//       "Weaver and handloom photo removed.",
//       snackPosition:
//           SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // SAVE DRAFT
//   // ==========================================================

//   void saveDraft() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location first.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.snackbar(
//       "Saved",
//       "Geo tagging data saved as draft.",
//       snackPosition:
//           SnackPosition.BOTTOM,
//     );
//   }

//   // ==========================================================
//   // NEXT
//   // ==========================================================

//   void next() {
//     if (latitude.value.isEmpty ||
//         longitude.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the location before continuing.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Handloom Photo.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         "Validation",
//         "Please capture the Weaver + Handloom Photo.",
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.toNamed(
//       AppRoutes.productList,
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../routes/app_routes.dart';
import '../../database/database_helper.dart';

class GeoTaggingController extends GetxController {
  // ==========================================================
  // SERVICES
  // ==========================================================

  final ImagePicker _picker = ImagePicker();

  final MapController mapController = MapController();

  final DatabaseHelper database =
      DatabaseHelper.instance;

  // ==========================================================
  // MAP
  // ==========================================================

  final double initialZoom = 18.0;

  // ==========================================================
  // LOADING
  // ==========================================================

  final RxBool isLoading = false.obs;

  final RxBool isSaving = false.obs;

  // ==========================================================
  // CURRENT USER LOCATION
  // ==========================================================

  final RxString latitude = ''.obs;

  final RxString longitude = ''.obs;

  final RxString accuracy = ''.obs;

  final RxString time = ''.obs;

  final Rx<LatLng?> currentLocation =
      Rx<LatLng?>(null);

  // ==========================================================
  // SELECTED LOCATION ON MAP
  // ==========================================================

  final Rx<LatLng?> selectedLocation =
      Rx<LatLng?>(null);

  final RxString selectedLatitude =
      ''.obs;

  final RxString selectedLongitude =
      ''.obs;

  // ==========================================================
  // DISTANCE
  // ==========================================================

  final RxDouble distanceFromSelectedLocation =
      0.0.obs;

  // ==========================================================
  // PHOTOS
  // ==========================================================

  final RxString photo1Path =
      ''.obs;

  final RxString photo2Path =
      ''.obs;

  // ==========================================================
  // PHOTO 1 GPS DETAILS
  // ==========================================================

  final RxString photo1Latitude =
      ''.obs;

  final RxString photo1Longitude =
      ''.obs;

  final RxString photo1DateTime =
      ''.obs;

  // ==========================================================
  // PHOTO 2 GPS DETAILS
  // ==========================================================

  final RxString photo2Latitude =
      ''.obs;

  final RxString photo2Longitude =
      ''.obs;

  final RxString photo2DateTime =
      ''.obs;

  // ==========================================================
  // REMARKS
  // ==========================================================

  final TextEditingController remarksController =
      TextEditingController();

  // ==========================================================
  // MAP TYPE
  // ==========================================================

  final RxBool satelliteMap =
      false.obs;

  // ==========================================================
  // GPS TIMER
  // ==========================================================

  Timer? _gpsTimer;

  bool _gpsRequestInProgress = false;

  // ==========================================================
  // CONSTANTS
  // ==========================================================

  static const double allowedPhotoRadius = 15.0;

  static const double allowedGpsAccuracy = 10.0;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    _startContinuousLocationTracking();
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void onClose() {
    _gpsTimer?.cancel();

    _gpsTimer = null;

    remarksController.dispose();

    super.onClose();
  }

  // ==========================================================
  // LOCATION PERMISSION
  // ==========================================================

  Future<bool> _checkLocationPermission() async {
    try {
      final bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar(
          'Location',
          'Please enable location services.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission ==
          LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission ==
          LocationPermission.denied) {
        Get.snackbar(
          'Location',
          'Location permission denied.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      if (permission ==
          LocationPermission.deniedForever) {
        Get.snackbar(
          'Location',
          'Location permission permanently denied. Please enable it from Settings.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      return true;
    } catch (e) {
      debugPrint(
        'LOCATION PERMISSION ERROR: $e',
      );

      return false;
    }
  }

  // ==========================================================
  // CONTINUOUS LOCATION TRACKING
  // GPS REFRESH EVERY 1 SECOND
  // ==========================================================

  Future<void>
      _startContinuousLocationTracking() async {
    final bool permitted =
        await _checkLocationPermission();

    if (!permitted) {
      return;
    }

    try {
      final Position initialPosition =
          await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(
          accuracy:
              LocationAccuracy.bestForNavigation,
        ),
      );

      _updateCurrentLocation(
        initialPosition,
      );

      _gpsTimer?.cancel();

      _gpsTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) async {
          await _refreshGpsEverySecond();
        },
      );

      debugPrint(
        'GPS ACCURACY REFRESH STARTED - EVERY 1 SECOND',
      );
    } catch (e) {
      debugPrint(
        'START LOCATION TRACKING ERROR: $e',
      );

      Get.snackbar(
        'Location Error',
        'Unable to start continuous location tracking.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ==========================================================
  // REFRESH GPS EVERY SECOND
  // ==========================================================

  Future<void>
      _refreshGpsEverySecond() async {
    if (_gpsRequestInProgress) {
      return;
    }

    _gpsRequestInProgress = true;

    try {
      final Position position =
          await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(
          accuracy:
              LocationAccuracy.bestForNavigation,
        ),
      );

      _updateCurrentLocation(
        position,
      );

      debugPrint(
        'GPS REFRESH -> '
        'LAT: ${position.latitude.toStringAsFixed(6)}, '
        'LNG: ${position.longitude.toStringAsFixed(6)}, '
        'ACCURACY: ${position.accuracy.toStringAsFixed(2)} m',
      );
    } catch (e) {
      debugPrint(
        'GPS 1 SECOND REFRESH ERROR: $e',
      );
    } finally {
      _gpsRequestInProgress = false;
    }
  }

  // ==========================================================
  // UPDATE CURRENT LOCATION
  // ==========================================================

  void _updateCurrentLocation(
    Position position,
  ) {
    final double lat =
        position.latitude;

    final double lng =
        position.longitude;

    latitude.value =
        lat.toStringAsFixed(6);

    longitude.value =
        lng.toStringAsFixed(6);

    accuracy.value =
        '${position.accuracy.toStringAsFixed(2)} m';

    time.value =
        DateFormat(
          'dd-MM-yyyy HH:mm:ss',
        ).format(
          DateTime.now(),
        );

    currentLocation.value =
        LatLng(
          lat,
          lng,
        );

    _calculateDistanceFromSelectedLocation();

    if (selectedLocation.value == null) {
      WidgetsBinding.instance
          .addPostFrameCallback(
        (_) {
          try {
            mapController.move(
              LatLng(
                lat,
                lng,
              ),
              initialZoom,
            );
          } catch (_) {}
        },
      );
    }
  }

  // ==========================================================
  // MOVE TO CURRENT LOCATION
  // ==========================================================

  Future<void>
      moveToCurrentLocation() async {
    try {
      isLoading.value = true;

      final Position? position =
          await _getCurrentPosition();

      if (position == null) {
        return;
      }

      _updateCurrentLocation(
        position,
      );

      WidgetsBinding.instance
          .addPostFrameCallback(
        (_) {
          try {
            mapController.move(
              LatLng(
                position.latitude,
                position.longitude,
              ),
              initialZoom,
            );
          } catch (_) {}
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // GET CURRENT POSITION
  // ==========================================================

  Future<Position?>
      _getCurrentPosition() async {
    final bool permitted =
        await _checkLocationPermission();

    if (!permitted) {
      return null;
    }

    try {
      return await Geolocator
          .getCurrentPosition(
        locationSettings:
            const LocationSettings(
          accuracy:
              LocationAccuracy.bestForNavigation,
        ),
      );
    } catch (e) {
      debugPrint(
        'GET CURRENT POSITION ERROR: $e',
      );

      Get.snackbar(
        'Location Error',
        'Unable to get current location.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return null;
    }
  }

  // ==========================================================
  // MAP TAP
  // ==========================================================

  void onMapTap(
    TapPosition tapPosition,
    LatLng point,
  ) {
    selectedLocation.value =
        point;

    selectedLatitude.value =
        point.latitude.toStringAsFixed(6);

    selectedLongitude.value =
        point.longitude.toStringAsFixed(6);

    _calculateDistanceFromSelectedLocation();

    debugPrint(
      'SELECTED LOCATION: '
      '${point.latitude}, ${point.longitude}',
    );
  }

  // ==========================================================
  // CALCULATE DISTANCE
  // ==========================================================

  void
      _calculateDistanceFromSelectedLocation() {
    final LatLng? current =
        currentLocation.value;

    final LatLng? selected =
        selectedLocation.value;

    if (current == null ||
        selected == null) {
      distanceFromSelectedLocation
          .value = 0.0;

      return;
    }

    final double distance =
        Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      selected.latitude,
      selected.longitude,
    );

    distanceFromSelectedLocation
        .value = distance;
  }

  // ==========================================================
  // WITHIN PHOTO RADIUS
  // ==========================================================

  bool get isWithinPhotoRadius {
    return selectedLocation.value != null &&
        distanceFromSelectedLocation
                .value <=
            allowedPhotoRadius;
  }

  // ==========================================================
  // ACCURACY CHECK
  // ==========================================================

  bool get isAccuracyAcceptable {
    final double? value =
        double.tryParse(
      accuracy.value.replaceAll(
        ' m',
        '',
      ),
    );

    if (value == null) {
      return false;
    }

    return value <=
        allowedGpsAccuracy;
  }

  // ==========================================================
  // ACCURACY COLOR
  // ==========================================================

  Color get accuracyColor {
    return isAccuracyAcceptable
        ? Colors.green.shade900
        : Colors.red;
  }

  // ==========================================================
  // MAP TYPE
  // ==========================================================

  void changeMapType() {
    satelliteMap.value =
        !satelliteMap.value;
  }

  // ==========================================================
  // CHECK PHOTO CAPTURE CONDITIONS
  // ==========================================================

  bool _canCapturePhoto() {
    if (selectedLocation.value ==
        null) {
      Get.snackbar(
        'Location Required',
        'Please tap on the map and select a location first.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isAccuracyAcceptable) {
      Get.snackbar(
        'GPS Accuracy',
        'GPS accuracy must be 10 metres or less before taking a photo.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isWithinPhotoRadius) {
      Get.snackbar(
        'Outside Geo-Tagging Radius',
        'You must be within 15 metres of the selected location to take the photo.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    return true;
  }

  // ==========================================================
  // CAPTURE PHOTO 1
  // ==========================================================

  Future<void>
      capturePhoto1() async {
    if (!_canCapturePhoto()) {
      return;
    }

    try {
      isLoading.value = true;

      final Position? position =
          await _getCurrentPosition();

      if (position == null) {
        return;
      }

      _updateCurrentLocation(
        position,
      );

      if (position.accuracy >
          allowedGpsAccuracy) {
        Get.snackbar(
          'GPS Accuracy',
          'GPS accuracy is greater than 10 metres. Please wait for better accuracy.',
          snackPosition:
              SnackPosition.BOTTOM,
        );

        return;
      }

      final double distance =
          Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        selectedLocation.value!
            .latitude,
        selectedLocation.value!
            .longitude,
      );

      if (distance >
          allowedPhotoRadius) {
        Get.snackbar(
          'Outside Radius',
          'You must be within 15 metres of the selected location.',
          snackPosition:
              SnackPosition.BOTTOM,
        );

        return;
      }

      final XFile? image =
          await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      photo1Path.value =
          image.path;

      photo1Latitude.value =
          selectedLocation.value!
              .latitude
              .toStringAsFixed(6);

      photo1Longitude.value =
          selectedLocation.value!
              .longitude
              .toStringAsFixed(6);

      photo1DateTime.value =
          DateFormat(
        'dd-MM-yyyy HH:mm:ss.SSS',
      ).format(
        DateTime.now(),
      );

      Get.snackbar(
        'Photo 1',
        'Photo 1 captured successfully.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(
        'PHOTO 1 ERROR: $e',
      );

      Get.snackbar(
        'Camera Error',
        'Unable to capture Photo 1.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // CAPTURE PHOTO 2
  // ==========================================================

  Future<void>
      capturePhoto2() async {
    if (!_canCapturePhoto()) {
      return;
    }

    try {
      isLoading.value = true;

      final Position? position =
          await _getCurrentPosition();

      if (position == null) {
        return;
      }

      _updateCurrentLocation(
        position,
      );

      if (position.accuracy >
          allowedGpsAccuracy) {
        Get.snackbar(
          'GPS Accuracy',
          'GPS accuracy is greater than 10 metres. Please wait for better accuracy.',
          snackPosition:
              SnackPosition.BOTTOM,
        );

        return;
      }

      final double distance =
          Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        selectedLocation.value!
            .latitude,
        selectedLocation.value!
            .longitude,
      );

      if (distance >
          allowedPhotoRadius) {
        Get.snackbar(
          'Outside Radius',
          'You must be within 15 metres of the selected location.',
          snackPosition:
              SnackPosition.BOTTOM,
        );

        return;
      }

      final XFile? image =
          await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      photo2Path.value =
          image.path;

      photo2Latitude.value =
          selectedLocation.value!
              .latitude
              .toStringAsFixed(6);

      photo2Longitude.value =
          selectedLocation.value!
              .longitude
              .toStringAsFixed(6);

      photo2DateTime.value =
          DateFormat(
        'dd-MM-yyyy HH:mm:ss.SSS',
      ).format(
        DateTime.now(),
      );

      Get.snackbar(
        'Photo 2',
        'Photo 2 captured successfully.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(
        'PHOTO 2 ERROR: $e',
      );

      Get.snackbar(
        'Camera Error',
        'Unable to capture Photo 2.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // REMOVE PHOTO 1
  // ==========================================================

  void removePhoto1() {
    photo1Path.value = '';

    photo1Latitude.value = '';

    photo1Longitude.value = '';

    photo1DateTime.value = '';
  }

  // ==========================================================
  // REMOVE PHOTO 2
  // ==========================================================

  void removePhoto2() {
    photo2Path.value = '';

    photo2Latitude.value = '';

    photo2Longitude.value = '';

    photo2DateTime.value = '';
  }

  // ==========================================================
  // VALIDATE BEFORE SAVE
  // ==========================================================

  bool _validateBeforeSave() {
    if (selectedLocation.value ==
        null) {
      Get.snackbar(
        'Validation',
        'Please tap on the map and select a location.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isAccuracyAcceptable) {
      Get.snackbar(
        'Validation',
        'GPS accuracy must be 10 metres or less.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isWithinPhotoRadius) {
      Get.snackbar(
        'Validation',
        'You must be within 15 metres of the selected location.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (photo1Path.value.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please capture Photo 1.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    if (photo2Path.value.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please capture Photo 2.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return false;
    }

    return true;
  }

  // ==========================================================
  // SAVE DATA
  // ==========================================================

  Future<void> saveData() async {
    if (!_validateBeforeSave()) {
      return;
    }

    try {
      isSaving.value = true;

      final arguments =
          Get.arguments
              as Map<String, dynamic>? ??
          <String, dynamic>{};

      final String mobile =
          arguments['mobileNumber']
                  ?.toString() ??
              '';

      final String districtName =
          arguments['districtName']
                  ?.toString() ??
              '';

      final String talukName =
          arguments['talukName']
                  ?.toString() ??
              '';

      final String districtCode =
          arguments['districtCode']
                  ?.toString() ??
              '';

      final String talukCode =
          arguments['talukCode']
                  ?.toString() ??
              '';

      final PackageInfo packageInfo =
          await PackageInfo.fromPlatform();

      final String collectedVersion =
          packageInfo.version;

      final int runningNumber =
          await database.getNextRunningId();

      final String runningId =
          runningNumber
              .toString()
              .padLeft(3, '0');

      final String uniqueId =
          'NAMMAKAIMAGGA-'
          '$districtCode-'
          '$talukCode-'
          '$mobile-'
          '$runningId';

      final String createdDate =
          DateFormat(
        'dd-MM-yyyy HH:mm:ss',
      ).format(
        DateTime.now(),
      );

      final String photo1Details =
          '${photo1DateTime.value} | '
          'Latitude: ${photo1Latitude.value} | '
          'Longitude: ${photo1Longitude.value}';

      final String photo2Details =
          '${photo2DateTime.value} | '
          'Latitude: ${photo2Latitude.value} | '
          'Longitude: ${photo2Longitude.value}';

      final Map<String, dynamic> data =
          {
        'p1': uniqueId,

        'p2': districtName,

        'p3': talukName,

        'p4': districtCode,

        'p5': talukCode,

        'p6': selectedLatitude.value,

        'p7': selectedLongitude.value,

        'p8': photo1Path.value,

        'p9': photo2Path.value,

        'p10': photo1Details,

        'p11': photo2Details,

        'p12': mobile,

        'p13': '',

        'p14':
            remarksController.text.trim(),

        'p15': collectedVersion,

        'p16': '',

        'p17': createdDate,

        'p100': uniqueId,

        'syncStatus': 'Pending',
      };

      await database.insertSurvey(
        data,
      );

      debugPrint(
        'SURVEY SAVED SUCCESSFULLY',
      );

      debugPrint(
        'UNIQUE ID: $uniqueId',
      );

      Get.snackbar(
        'Success',
        'Geo-tagged data saved successfully.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      await _showMoreDataDialog();
    } catch (e) {
      debugPrint(
        'SAVE DATA ERROR: $e',
      );

      Get.snackbar(
        'Save Error',
        'Unable to save the geo-tagged data.',
        snackPosition:
            SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // ==========================================================
  // AFTER SAVE DIALOG
  // ==========================================================

  Future<void>
      _showMoreDataDialog() async {
    final bool? result =
        await Get.dialog<bool>(
      AlertDialog(
        title:
            const Text(
          'Data Saved',
        ),
        content:
            const Text(
          'Do you want to Geo-Tag more data?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(
                result: false,
              );
            },
            child:
                const Text(
              'No',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(
                result: true,
              );
            },
            child:
                const Text(
              'Yes',
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (result == true) {
      _clearForNewRecord();
    } else {
      Get.offAllNamed(
        AppRoutes.dashboard,
        arguments: Get.arguments,
      );
    }
  }

  // ==========================================================
  // CLEAR FOR NEW RECORD
  // ==========================================================

  void _clearForNewRecord() {
    selectedLocation.value = null;

    selectedLatitude.value = '';

    selectedLongitude.value = '';

    distanceFromSelectedLocation.value =
        0.0;

    photo1Path.value = '';

    photo2Path.value = '';

    photo1Latitude.value = '';

    photo1Longitude.value = '';

    photo1DateTime.value = '';

    photo2Latitude.value = '';

    photo2Longitude.value = '';

    photo2DateTime.value = '';

    remarksController.clear();

    if (currentLocation.value != null) {
      WidgetsBinding.instance
          .addPostFrameCallback(
        (_) {
          try {
            mapController.move(
              currentLocation.value!,
              initialZoom,
            );
          } catch (_) {}
        },
      );
    }

    Get.snackbar(
      'Ready',
      'You can now Geo-Tag another location.',
      snackPosition:
          SnackPosition.BOTTOM,
    );
  }

  // ==========================================================
  // CANCEL
  // ==========================================================

  Future<void> cancel() async {
    final bool? confirm =
        await Get.dialog<bool>(
      AlertDialog(
        title:
            const Text(
          'Cancel Geo Tagging?',
        ),
        content:
            const Text(
          'Any unsaved data on this screen will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(
                result: false,
              );
            },
            child:
                const Text(
              'No',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(
                result: true,
              );
            },
            child:
                const Text(
              'Yes',
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      Get.offAllNamed(
        AppRoutes.dashboard,
        arguments: Get.arguments,
      );
    }
  }
}