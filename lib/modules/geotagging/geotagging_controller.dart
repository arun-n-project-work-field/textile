// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import '../../routes/app_routes.dart';
// import '../../database/database_helper.dart';
// import '../../device_id_service.dart';

// class GeoTaggingController extends GetxController {
//   // ==========================================================

//   // SERVICES

//   // ==========================================================

//   final ImagePicker _picker = ImagePicker();

//   final MapController mapController = MapController();

//   final DatabaseHelper database = DatabaseHelper.instance;

//   // ==========================================================

//   // MAP

//   // ==========================================================

//   final double initialZoom = 18.0;

//   // The map is centered on the first available GPS fix only once. Subsequent
//   // GPS refreshes update the marker without interrupting the user's map panning.

//   // ==========================================================

//   // LOADING

//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   final RxBool isSaving = false.obs;

//   // ==========================================================

//   // CURRENT USER LOCATION

//   // ==========================================================

//   final RxString latitude = ''.obs;

//   final RxString longitude = ''.obs;

//   final RxString accuracy = ''.obs;

//   final RxString time = ''.obs;

//   final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

//   // ==========================================================

//   // SELECTED LOCATION ON MAP

//   // ==========================================================

//   final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

//   final RxString selectedLatitude = ''.obs;

//   final RxString selectedLongitude = ''.obs;

//   // ==========================================================

//   // DISTANCE

//   // ==========================================================

//   final RxDouble distanceFromSelectedLocation = 0.0.obs;

//   // ==========================================================

//   // PHOTOS

//   // ==========================================================

//   final RxString photo1Path = ''.obs;

//   final RxString photo2Path = ''.obs;

//   // ==========================================================

//   // PHOTO 1 GPS DETAILS

//   // ==========================================================

//   final RxString photo1Latitude = ''.obs;

//   final RxString photo1Longitude = ''.obs;

//   final RxString photo1DateTime = ''.obs;

//   // ==========================================================

//   // PHOTO 2 GPS DETAILS

//   // ==========================================================

//   final RxString photo2Latitude = ''.obs;

//   final RxString photo2Longitude = ''.obs;

//   final RxString photo2DateTime = ''.obs;

//   // ==========================================================

//   // REMARKS

//   // ==========================================================

//   final TextEditingController remarksController = TextEditingController();

//   // ==========================================================

//   // MAP TYPE

//   // ==========================================================

//   final RxBool satelliteMap = false.obs;

//   // ==========================================================

//   // GPS TIMER

//   // ==========================================================

//   Timer? _gpsTimer;

//   bool _gpsRequestInProgress = false;

//   bool _mapReady = false;

//   bool _initialMapCentered = false;

//   // ==========================================================

//   // CONSTANTS

//   // ==========================================================

//   static const double allowedPhotoRadius = 30.0;

//   static const double allowedMapSelectionRadius = 30.0;

//   static const double allowedGpsAccuracy = 10.0;

//   // ==========================================================

//   // INIT

//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     _startContinuousLocationTracking();
//   }

//   // ==========================================================

//   // DISPOSE

//   // ==========================================================

//   @override
//   void onClose() {
//     _gpsTimer?.cancel();

//     _gpsTimer = null;

//     remarksController.dispose();

//     super.onClose();
//   }

//   // ==========================================================

//   // LOCATION PERMISSION

//   // ==========================================================

//   Future<bool> _checkLocationPermission() async {
//     try {
//       final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         Get.snackbar(
//           'Location',

//           'Please enable location services.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//           'Location',

//           'Location permission denied.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       if (permission == LocationPermission.deniedForever) {
//         Get.snackbar(
//           'Location',

//           'Location permission permanently denied. Please enable it from Settings.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       return true;
//     } catch (e) {
//       debugPrint('LOCATION PERMISSION ERROR: $e');

//       return false;
//     }
//   }

//   // ==========================================================

//   // CONTINUOUS LOCATION TRACKING

//   // GPS REFRESH EVERY 1 SECOND

//   // ==========================================================

//   Future<void> _startContinuousLocationTracking() async {
//     final bool permitted = await _checkLocationPermission();

//     if (!permitted) {
//       return;
//     }

//     try {
//       final Position initialPosition = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );

//       _updateCurrentLocation(initialPosition);

//       _gpsTimer?.cancel();

//       _gpsTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
//         await _refreshGpsEverySecond();
//       });

//       debugPrint('GPS ACCURACY REFRESH STARTED - EVERY 1 SECOND');
//     } catch (e) {
//       debugPrint('START LOCATION TRACKING ERROR: $e');

//       Get.snackbar(
//         'Location Error',

//         'Unable to start continuous location tracking.',

//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================

//   // REFRESH GPS EVERY SECOND

//   // ==========================================================

//   Future<void> _refreshGpsEverySecond() async {
//     if (_gpsRequestInProgress) {
//       return;
//     }

//     _gpsRequestInProgress = true;

//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );

//       _updateCurrentLocation(position);

//       debugPrint(
//         'GPS REFRESH -> '
//         'LAT: ${position.latitude.toStringAsFixed(6)}, '
//         'LNG: ${position.longitude.toStringAsFixed(6)}, '
//         'ACCURACY: ${position.accuracy.toStringAsFixed(2)} m',
//       );
//     } catch (e) {
//       debugPrint('GPS 1 SECOND REFRESH ERROR: $e');
//     } finally {
//       _gpsRequestInProgress = false;
//     }
//   }

//   // ==========================================================

//   // UPDATE CURRENT LOCATION

//   // ==========================================================

//   void _updateCurrentLocation(Position position) {
//     final double lat = position.latitude;

//     final double lng = position.longitude;

//     latitude.value = lat.toStringAsFixed(6);

//     longitude.value = lng.toStringAsFixed(6);

//     accuracy.value = '${position.accuracy.toStringAsFixed(2)} m';

//     time.value = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

//     currentLocation.value = LatLng(lat, lng);

//     _calculateDistanceFromSelectedLocation();

//     // Center the map on the first available GPS fix, but never recenter on
//     // every refresh because that would prevent the user from panning the map.
//     _centerMapOnInitialLocationIfReady();
//   }

//   // ==========================================================
//   // MAP READY / INITIAL CENTER
//   // ==========================================================

//   void onMapReady() {
//     _mapReady = true;
//     _centerMapOnInitialLocationIfReady();
//   }

//   void _centerMapOnInitialLocationIfReady() {
//     if (!_mapReady || _initialMapCentered) return;

//     final LatLng? location = currentLocation.value;
//     if (location == null) return;

//     try {
//       mapController.move(location, initialZoom);
//       _initialMapCentered = true;
//     } catch (e) {
//       debugPrint('INITIAL MAP CENTER ERROR: $e');
//     }
//   }

//   // ==========================================================

//   // MOVE TO CURRENT LOCATION

//   // ==========================================================

//   Future<void> moveToCurrentLocation() async {
//     try {
//       isLoading.value = true;

//       final Position? position = await _getCurrentPosition();

//       if (position == null) {
//         return;
//       }

//       _updateCurrentLocation(position);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         try {
//           mapController.move(
//             LatLng(position.latitude, position.longitude),

//             initialZoom,
//           );
//         } catch (_) {}
//       });
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================

//   // GET CURRENT POSITION

//   // ==========================================================

//   Future<Position?> _getCurrentPosition() async {
//     final bool permitted = await _checkLocationPermission();

//     if (!permitted) {
//       return null;
//     }

//     try {
//       return await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );
//     } catch (e) {
//       debugPrint('GET CURRENT POSITION ERROR: $e');

//       Get.snackbar(
//         'Location Error',

//         'Unable to get current location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return null;
//     }
//   }

//   // ==========================================================

//   // MAP TAP

//   // ==========================================================

//   Future<void> onMapTap(TapPosition tapPosition, LatLng point) async {
//     final LatLng? current = currentLocation.value;
//     if (current == null) {
//       await Get.dialog<void>(
//         AlertDialog(
//           title: const Text('Current Location Unavailable'),
//           content: const Text(
//             'Please wait until your current GPS location is available, then select a location on the map.',
//           ),
//           actions: [
//             TextButton(onPressed: () => Get.back(), child: const Text('OK')),
//           ],
//         ),
//         barrierDismissible: false,
//       );
//       return;
//     }

//     final double distance = Geolocator.distanceBetween(
//       current.latitude,
//       current.longitude,
//       point.latitude,
//       point.longitude,
//     );

//     if (distance > allowedMapSelectionRadius) {
//       await Get.dialog<void>(
//         AlertDialog(
//           title: const Text('Location Beyond 30 Metres'),
//           content: Text(
//             'The selected location is ${distance.toStringAsFixed(1)} metres from your current location. '
//             'Please press OK and select a closer location within 30 metres.',
//           ),
//           actions: [
//             TextButton(onPressed: () => Get.back(), child: const Text('OK')),
//           ],
//         ),
//         barrierDismissible: false,
//         barrierColor: Colors.black54,
//       );
//       return;
//     }

//     selectedLocation.value = point;
//     selectedLatitude.value = point.latitude.toStringAsFixed(6);
//     selectedLongitude.value = point.longitude.toStringAsFixed(6);
//     distanceFromSelectedLocation.value = distance;

//     debugPrint(
//       'SELECTED LOCATION WITHIN 30M: '
//       '${point.latitude}, ${point.longitude}; distance=${distance.toStringAsFixed(2)}m',
//     );
//   }

//   // ==========================================================

//   // CALCULATE DISTANCE

//   // ==========================================================

//   void _calculateDistanceFromSelectedLocation() {
//     final LatLng? current = currentLocation.value;

//     final LatLng? selected = selectedLocation.value;

//     if (current == null || selected == null) {
//       distanceFromSelectedLocation.value = 0.0;

//       return;
//     }

//     final double distance = Geolocator.distanceBetween(
//       current.latitude,

//       current.longitude,

//       selected.latitude,

//       selected.longitude,
//     );

//     distanceFromSelectedLocation.value = distance;
//   }

//   // ==========================================================

//   // WITHIN PHOTO RADIUS

//   // ==========================================================

//   bool get isWithinPhotoRadius {
//     return selectedLocation.value != null &&
//         distanceFromSelectedLocation.value <= allowedPhotoRadius;
//   }

//   // ==========================================================

//   // ACCURACY CHECK

//   // ==========================================================

//   bool get isAccuracyAcceptable {
//     final double? value = double.tryParse(accuracy.value.replaceAll(' m', ''));

//     if (value == null) {
//       return false;
//     }

//     return value <= allowedGpsAccuracy;
//   }

//   // ==========================================================

//   // ACCURACY COLOR

//   // ==========================================================

//   Color get accuracyColor {
//     return isAccuracyAcceptable ? Colors.green.shade900 : Colors.red;
//   }

//   // ==========================================================

//   // MAP TYPE

//   // ==========================================================

//   void changeMapType() {
//     satelliteMap.value = !satelliteMap.value;
//   }

//   // ==========================================================

//   // CHECK PHOTO CAPTURE CONDITIONS

//   // ==========================================================

//   bool _canCapturePhoto() {
//     if (selectedLocation.value == null) {
//       Get.snackbar(
//         'Location Required',

//         'Please tap on the map and select a location first.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (!isAccuracyAcceptable) {
//       Get.snackbar(
//         'GPS Accuracy',

//         'GPS accuracy must be 30 metres or less before taking a photo.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (!isWithinPhotoRadius) {
//       Get.snackbar(
//         'Outside Geo-Tagging Radius',

//         'You must be within 30 metres of the selected location to take the photo.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     return true;
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 1 / PHOTO 2
//   // ==========================================================
//   // Validate GPS before opening the camera and immediately after it returns.
//   // Coordinates stored with the photo are the capture-time GPS fix, not the
//   // selected map pin's coordinates.

//   Future<void> capturePhoto1() => _capturePhoto(photoNumber: 1);

//   Future<void> capturePhoto2() => _capturePhoto(photoNumber: 2);

//   Future<void> _capturePhoto({required int photoNumber}) async {
//     if (!_canCapturePhoto()) return;

//     // Snapshot the selected map point so it cannot silently change mid-capture.
//     final LatLng selectedPoint = selectedLocation.value!;

//     try {
//       isLoading.value = true;

//       final Position? beforeCapture = await _getCurrentPosition();
//       if (beforeCapture == null) return;

//       if (beforeCapture.accuracy > allowedGpsAccuracy) {
//         Get.snackbar(
//           'GPS Accuracy',
//           'GPS accuracy must be 30 metres or less. Please wait for a better GPS fix.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final double distanceBefore = Geolocator.distanceBetween(
//         beforeCapture.latitude,
//         beforeCapture.longitude,
//         selectedPoint.latitude,
//         selectedPoint.longitude,
//       );
//       if (distanceBefore > allowedPhotoRadius) {
//         Get.snackbar(
//           'Outside Geo-Tagging Radius',
//           'You must be within 30 metres of the selected map point to take this photo.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );
//       if (image == null) return;

//       // Re-check after capture so moving outside the radius while using the
//       // camera cannot result in a wrongly tagged saved photo.
//       final Position? capturePosition = await _getCurrentPosition();
//       if (capturePosition == null) {
//         Get.snackbar(
//           'Photo Location Unavailable',
//           'The photo was not saved because its capture-time GPS could not be verified.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       if (capturePosition.accuracy > allowedGpsAccuracy) {
//         Get.snackbar(
//           'GPS Accuracy Too Low',
//           'The photo was not saved. Capture-time GPS accuracy must be 30 metres or less.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final double captureDistance = Geolocator.distanceBetween(
//         capturePosition.latitude,
//         capturePosition.longitude,
//         selectedPoint.latitude,
//         selectedPoint.longitude,
//       );
//       if (captureDistance > allowedPhotoRadius) {
//         Get.snackbar(
//           'Photo Outside 30 Metres',
//           'Photo rejected: capture-time location is ${captureDistance.toStringAsFixed(1)} m from the selected map point. Maximum allowed distance is 30 m.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 5),
//         );
//         return;
//       }

//       final String capturedLatitude = capturePosition.latitude.toStringAsFixed(
//         6,
//       );
//       final String capturedLongitude = capturePosition.longitude
//           .toStringAsFixed(6);
//       final String capturedAt = DateFormat(
//         'dd-MM-yyyy HH:mm:ss.SSS',
//       ).format(DateTime.now());

//       if (photoNumber == 1) {
//         photo1Path.value = image.path;
//         photo1Latitude.value = capturedLatitude;
//         photo1Longitude.value = capturedLongitude;
//         photo1DateTime.value = capturedAt;
//       } else {
//         photo2Path.value = image.path;
//         photo2Latitude.value = capturedLatitude;
//         photo2Longitude.value = capturedLongitude;
//         photo2DateTime.value = capturedAt;
//       }

//       Get.snackbar(
//         'Photo $photoNumber',
//         'Photo $photoNumber captured and location verified (${captureDistance.toStringAsFixed(1)} m from selected point).',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e, stackTrace) {
//       debugPrint('PHOTO $photoNumber ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);
//       Get.snackbar(
//         'Camera Error',
//         'Unable to capture and verify Photo $photoNumber.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================

//   // REMOVE PHOTO 1

//   // ==========================================================

//   void removePhoto1() {
//     photo1Path.value = '';

//     photo1Latitude.value = '';

//     photo1Longitude.value = '';

//     photo1DateTime.value = '';
//   }

//   // ==========================================================

//   // REMOVE PHOTO 2

//   // ==========================================================

//   void removePhoto2() {
//     photo2Path.value = '';

//     photo2Latitude.value = '';

//     photo2Longitude.value = '';

//     photo2DateTime.value = '';
//   }

//   // ==========================================================

//   // VALIDATE BEFORE SAVE

//   // ==========================================================

//   bool _validateBeforeSave() {
//     if (selectedLocation.value == null) {
//       Get.snackbar(
//         'Validation',

//         'Please tap on the map and select a location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // GPS ACCURACY CHECK

//     // ========================================================

//     // When BOTH photos are captured, GPS accuracy is NOT

//     // checked when Save Data is pressed.

//     //

//     // If either photo is missing, GPS accuracy must be

//     // 30 metres or less.

//     // ========================================================

//     final bool bothPhotosCaptured =
//         photo1Path.value.isNotEmpty && photo2Path.value.isNotEmpty;

//     if (!bothPhotosCaptured && !isAccuracyAcceptable) {
//       Get.snackbar(
//         'Validation',

//         'GPS accuracy must be 30 metres or less.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // 30 METRE RADIUS CHECK

//     // ========================================================

//     if (!isWithinPhotoRadius) {
//       Get.snackbar(
//         'Validation',

//         'You must be within 30 metres of the selected location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // PHOTO 1

//     // ========================================================

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         'Validation',

//         'Please capture Photo 1.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // PHOTO 2

//     // ========================================================

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         'Validation',

//         'Please capture Photo 2.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     return true;
//   }

//   // ==========================================================

//   // SAVE DATA

//   // ==========================================================

//   Future<void> saveData() async {
//     if (!_validateBeforeSave()) {
//       return;
//     }

//     try {
//       isSaving.value = true;

//       // Use the same persistent Device ID displayed on the dashboard.
//       final String deviceId = await DeviceIdService.getOrCreateDeviceId();

//       final arguments =
//           Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};

//       final String mobile = arguments['mobileNumber']?.toString() ?? '';

//       final String districtName = arguments['districtName']?.toString() ?? '';

//       final String talukName = arguments['talukName']?.toString() ?? '';

//       final String districtCode = arguments['districtCode']?.toString() ?? '';

//       final String talukCode = arguments['talukCode']?.toString() ?? '';

//       final PackageInfo packageInfo = await PackageInfo.fromPlatform();

//       final String collectedVersion = packageInfo.version;

//       final int runningNumber = await database.getNextRunningId();

//       final String runningId = runningNumber.toString().padLeft(3, '0');

//       final String uniqueId =
//           'NAMMAKAIMAGGA-'
//           '$districtCode-'
//           '$talukCode-'
//           '$mobile-'
//           '$runningId';

//       final String createdDate = DateFormat(
//         'dd-MM-yyyy HH:mm:ss',
//       ).format(DateTime.now());

//       final String photo1Details =
//           '${photo1DateTime.value} | '
//           'Latitude: ${photo1Latitude.value} | '
//           'Longitude: ${photo1Longitude.value}';

//       final String photo2Details =
//           '${photo2DateTime.value} | '
//           'Latitude: ${photo2Latitude.value} | '
//           'Longitude: ${photo2Longitude.value}';

//       final Map<String, dynamic> data = {
//         'p1': uniqueId,

//         'p2': districtName,

//         'p3': talukName,

//         'p4': districtCode,

//         'p5': talukCode,

//         'p6': selectedLatitude.value,

//         'p7': selectedLongitude.value,

//         'p8': photo1Path.value,

//         'p9': photo2Path.value,

//         'p10': photo1Details,

//         'p11': photo2Details,

//         'p12': mobile,

//         'p13': deviceId,

//         'p14': remarksController.text.trim(),

//         'p15': collectedVersion,

//         'p16': collectedVersion,

//         'p17': createdDate,

//         'p100': uniqueId,

//         'syncStatus': 'Pending',
//       };

//       await database.insertSurvey(data);

//       debugPrint('SURVEY SAVED SUCCESSFULLY');

//       debugPrint('UNIQUE ID: $uniqueId');

//       Get.snackbar(
//         'Success',

//         'Geo-tagged data saved successfully.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       // ======================================================

//       // DIRECTLY RETURN TO DASHBOARD

//       // ======================================================

//       Get.offAllNamed(AppRoutes.dashboard, arguments: arguments);
//     } catch (e) {
//       debugPrint('SAVE DATA ERROR: $e');

//       Get.snackbar(
//         'Save Error',

//         'Unable to save the geo-tagged data.',

//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isSaving.value = false;
//     }
//   }

//   // ==========================================================

//   // CANCEL

//   // ==========================================================

//   Future<void> cancel() async {
//     final bool? confirm = await Get.dialog<bool>(
//       AlertDialog(
//         title: const Text('Cancel Geo Tagging?'),

//         content: const Text('Any unsaved data on this screen will be lost.'),

//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back(result: false);
//             },

//             child: const Text('No'),
//           ),

//           ElevatedButton(
//             onPressed: () {
//               Get.back(result: true);
//             },

//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );

//     if (confirm == true) {
//       Get.offAllNamed(AppRoutes.dashboard, arguments: Get.arguments);
//     }
//   }
// }




// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import '../../routes/app_routes.dart';
// import '../../database/database_helper.dart';
// import '../../device_id_service.dart';

// class GeoTaggingController extends GetxController {
//   // ==========================================================

//   // SERVICES

//   // ==========================================================

//   final ImagePicker _picker = ImagePicker();

//   final MapController mapController = MapController();

//   final DatabaseHelper database = DatabaseHelper.instance;

//   // ==========================================================

//   // MAP

//   // ==========================================================

//   final double initialZoom = 18.0;

//   // The map is centered on the first available GPS fix only once. Subsequent
//   // GPS refreshes update the marker without interrupting the user's map panning.

//   // ==========================================================

//   // LOADING

//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   final RxBool isSaving = false.obs;

//   // Mock/fake GPS protection. When a mock location is detected, the screen
//   // stays blocked until a fresh, non-mocked GPS fix is confirmed.
//   final RxBool isMockLocationDetected = false.obs;
//   bool _mockGpsAlertShown = false;

//   // ==========================================================

//   // CURRENT USER LOCATION

//   // ==========================================================

//   final RxString latitude = ''.obs;

//   final RxString longitude = ''.obs;

//   final RxString accuracy = ''.obs;

//   final RxString time = ''.obs;

//   final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

//   // ==========================================================

//   // SELECTED LOCATION ON MAP

//   // ==========================================================

//   final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

//   final RxString selectedLatitude = ''.obs;

//   final RxString selectedLongitude = ''.obs;

//   // ==========================================================

//   // DISTANCE

//   // ==========================================================

//   final RxDouble distanceFromSelectedLocation = 0.0.obs;

//   // ==========================================================

//   // PHOTOS

//   // ==========================================================

//   final RxString photo1Path = ''.obs;

//   final RxString photo2Path = ''.obs;

//   // ==========================================================

//   // PHOTO 1 GPS DETAILS

//   // ==========================================================

//   final RxString photo1Latitude = ''.obs;

//   final RxString photo1Longitude = ''.obs;

//   final RxString photo1DateTime = ''.obs;

//   // ==========================================================

//   // PHOTO 2 GPS DETAILS

//   // ==========================================================

//   final RxString photo2Latitude = ''.obs;

//   final RxString photo2Longitude = ''.obs;

//   final RxString photo2DateTime = ''.obs;

//   // ==========================================================

//   // REMARKS

//   // ==========================================================

//   final TextEditingController remarksController = TextEditingController();

//   // ==========================================================

//   // MAP TYPE

//   // ==========================================================

//   final RxBool satelliteMap = false.obs;

//   // ==========================================================

//   // GPS TIMER

//   // ==========================================================

//   Timer? _gpsTimer;

//   bool _gpsRequestInProgress = false;

//   bool _mapReady = false;

//   bool _initialMapCentered = false;

//   // ==========================================================

//   // CONSTANTS

//   // ==========================================================

//   static const double allowedPhotoRadius = 30.0;

//   static const double allowedMapSelectionRadius = 30.0;

//   static const double allowedGpsAccuracy = 10.0;

//   // ==========================================================

//   // INIT

//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     _startContinuousLocationTracking();
//   }

//   // ==========================================================

//   // DISPOSE

//   // ==========================================================

//   @override
//   void onClose() {
//     _gpsTimer?.cancel();

//     _gpsTimer = null;

//     remarksController.dispose();

//     super.onClose();
//   }

//   // ==========================================================

//   // LOCATION PERMISSION

//   // ==========================================================

//   Future<bool> _checkLocationPermission() async {
//     try {
//       final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         Get.snackbar(
//           'Location',

//           'Please enable location services.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//           'Location',

//           'Location permission denied.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       if (permission == LocationPermission.deniedForever) {
//         Get.snackbar(
//           'Location',

//           'Location permission permanently denied. Please enable it from Settings.',

//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return false;
//       }

//       return true;
//     } catch (e) {
//       debugPrint('LOCATION PERMISSION ERROR: $e');

//       return false;
//     }
//   }

//   // ==========================================================

//   // CONTINUOUS LOCATION TRACKING

//   // GPS REFRESH EVERY 1 SECOND

//   // ==========================================================

//   Future<void> _startContinuousLocationTracking() async {
//     final bool permitted = await _checkLocationPermission();

//     if (!permitted) {
//       return;
//     }

//     try {
//       final Position initialPosition = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );

//       _updateCurrentLocation(initialPosition);

//       _gpsTimer?.cancel();

//       _gpsTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
//         await _refreshGpsEverySecond();
//       });

//       debugPrint('GPS ACCURACY REFRESH STARTED - EVERY 1 SECOND');
//     } catch (e) {
//       debugPrint('START LOCATION TRACKING ERROR: $e');

//       Get.snackbar(
//         'Location Error',

//         'Unable to start continuous location tracking.',

//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================

//   // REFRESH GPS EVERY SECOND

//   // ==========================================================

//   Future<void> _refreshGpsEverySecond() async {
//     if (_gpsRequestInProgress) {
//       return;
//     }

//     _gpsRequestInProgress = true;

//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );

//       _updateCurrentLocation(position);

//       debugPrint(
//         'GPS REFRESH -> '
//         'LAT: ${position.latitude.toStringAsFixed(6)}, '
//         'LNG: ${position.longitude.toStringAsFixed(6)}, '
//         'ACCURACY: ${position.accuracy.toStringAsFixed(2)} m',
//       );
//     } catch (e) {
//       debugPrint('GPS 1 SECOND REFRESH ERROR: $e');
//     } finally {
//       _gpsRequestInProgress = false;
//     }
//   }

//   // ==========================================================

//   // UPDATE CURRENT LOCATION

//   // ==========================================================

//   void _updateCurrentLocation(Position position) {
//     if (position.isMocked) {
//       isMockLocationDetected.value = true;
//       _showMockGpsAlert();
//       debugPrint('MOCK GPS DETECTED - GEO TAGGING BLOCKED');
//       return;
//     }

//     // Do not resume location updates while the blocking mock-GPS alert is
//     // active; the user must explicitly recheck after closing the mock app.
//     if (isMockLocationDetected.value) return;

//     final double lat = position.latitude;

//     final double lng = position.longitude;

//     latitude.value = lat.toStringAsFixed(6);

//     longitude.value = lng.toStringAsFixed(6);

//     accuracy.value = '${position.accuracy.toStringAsFixed(2)} m';

//     time.value = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

//     currentLocation.value = LatLng(lat, lng);

//     _calculateDistanceFromSelectedLocation();

//     // Center the map on the first available GPS fix, but never recenter on
//     // every refresh because that would prevent the user from panning the map.
//     _centerMapOnInitialLocationIfReady();
//   }

//   // ==========================================================
//   // MAP READY / INITIAL CENTER
//   // ==========================================================

//   void onMapReady() {
//     _mapReady = true;
//     _centerMapOnInitialLocationIfReady();
//   }

//   void _centerMapOnInitialLocationIfReady() {
//     if (!_mapReady || _initialMapCentered) return;

//     final LatLng? location = currentLocation.value;
//     if (location == null) return;

//     try {
//       mapController.move(location, initialZoom);
//       _initialMapCentered = true;
//     } catch (e) {
//       debugPrint('INITIAL MAP CENTER ERROR: $e');
//     }
//   }

//   // ==========================================================

//   // MOVE TO CURRENT LOCATION

//   // ==========================================================

//   Future<void> moveToCurrentLocation() async {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     try {
//       isLoading.value = true;

//       final Position? position = await _getCurrentPosition();

//       if (position == null) {
//         return;
//       }

//       _updateCurrentLocation(position);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         try {
//           mapController.move(
//             LatLng(position.latitude, position.longitude),

//             initialZoom,
//           );
//         } catch (_) {}
//       });
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // MOCK / FAKE GPS DETECTION AND SCREEN BLOCK
//   // ==========================================================

//   void _showMockGpsAlert() {
//     if (_mockGpsAlertShown || !isMockLocationDetected.value) return;
//     _mockGpsAlertShown = true;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!Get.isRegistered<GeoTaggingController>() || !isMockLocationDetected.value) {
//         _mockGpsAlertShown = false;
//         return;
//       }

//       Get.dialog<void>(
//         WillPopScope(
//           onWillPop: () async => false,
//           child: AlertDialog(
//             title: const Text('Mock / Fake GPS Detected'),
//             content: const Text(
//               'Please close the fake or mock GPS app before starting to geotag.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: _recheckMockGpsAndUnblock,
//                 child: const Text('CHECK AGAIN'),
//               ),
//             ],
//           ),
//         ),
//         barrierDismissible: false,
//       ).whenComplete(() {
//         _mockGpsAlertShown = false;
//       });
//     });
//   }

//   Future<void> _recheckMockGpsAndUnblock() async {
//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );

//       if (position.isMocked) {
//         Get.snackbar(
//           'Mock / Fake GPS Still Active',
//           'Close the fake or mock GPS app, disable mock location, then tap CHECK AGAIN.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       isMockLocationDetected.value = false;
//       _mockGpsAlertShown = false;
//       if (Get.isDialogOpen == true) Get.back<void>();
//       _updateCurrentLocation(position);
//     } catch (e) {
//       debugPrint('MOCK GPS RECHECK ERROR: $e');
//       Get.snackbar(
//         'Location Check Failed',
//         'Unable to verify GPS. Please check location services and try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   // ==========================================================

//   // GET CURRENT POSITION

//   // ==========================================================

//   Future<Position?> _getCurrentPosition() async {
//     final bool permitted = await _checkLocationPermission();

//     if (!permitted) {
//       return null;
//     }

//     try {
//       return await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.bestForNavigation,
//         ),
//       );
//     } catch (e) {
//       debugPrint('GET CURRENT POSITION ERROR: $e');

//       Get.snackbar(
//         'Location Error',

//         'Unable to get current location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return null;
//     }
//   }

//   // ==========================================================

//   // MAP TAP

//   // ==========================================================

//   Future<void> onMapTap(TapPosition tapPosition, LatLng point) async {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }

//     final LatLng? current = currentLocation.value;
//     if (current == null) {
//       await Get.dialog<void>(
//         AlertDialog(
//           title: const Text('Current Location Unavailable'),
//           content: const Text(
//             'Please wait until your current GPS location is available, then select a location on the map.',
//           ),
//           actions: [
//             TextButton(onPressed: () => Get.back(), child: const Text('OK')),
//           ],
//         ),
//         barrierDismissible: false,
//       );
//       return;
//     }

//     final double distance = Geolocator.distanceBetween(
//       current.latitude,
//       current.longitude,
//       point.latitude,
//       point.longitude,
//     );

//     if (distance > allowedMapSelectionRadius) {
//       await Get.dialog<void>(
//         AlertDialog(
//           title: const Text('Location Beyond 30 Metres'),
//           content: Text(
//             'The selected location is ${distance.toStringAsFixed(1)} metres from your current location. '
//             'Please press OK and select a closer location within 30 metres.',
//           ),
//           actions: [
//             TextButton(onPressed: () => Get.back(), child: const Text('OK')),
//           ],
//         ),
//         barrierDismissible: false,
//         barrierColor: Colors.black54,
//       );
//       return;
//     }

//     selectedLocation.value = point;
//     selectedLatitude.value = point.latitude.toStringAsFixed(6);
//     selectedLongitude.value = point.longitude.toStringAsFixed(6);
//     distanceFromSelectedLocation.value = distance;

//     debugPrint(
//       'SELECTED LOCATION WITHIN 30M: '
//       '${point.latitude}, ${point.longitude}; distance=${distance.toStringAsFixed(2)}m',
//     );
//   }

//   // ==========================================================

//   // CALCULATE DISTANCE

//   // ==========================================================

//   void _calculateDistanceFromSelectedLocation() {
//     final LatLng? current = currentLocation.value;

//     final LatLng? selected = selectedLocation.value;

//     if (current == null || selected == null) {
//       distanceFromSelectedLocation.value = 0.0;

//       return;
//     }

//     final double distance = Geolocator.distanceBetween(
//       current.latitude,

//       current.longitude,

//       selected.latitude,

//       selected.longitude,
//     );

//     distanceFromSelectedLocation.value = distance;
//   }

//   // ==========================================================

//   // WITHIN PHOTO RADIUS

//   // ==========================================================

//   bool get isWithinPhotoRadius {
//     return selectedLocation.value != null &&
//         distanceFromSelectedLocation.value <= allowedPhotoRadius;
//   }

//   // ==========================================================

//   // ACCURACY CHECK

//   // ==========================================================

//   bool get isAccuracyAcceptable {
//     final double? value = double.tryParse(accuracy.value.replaceAll(' m', ''));

//     if (value == null) {
//       return false;
//     }

//     return value <= allowedGpsAccuracy;
//   }

//   // ==========================================================

//   // ACCURACY COLOR

//   // ==========================================================

//   Color get accuracyColor {
//     return isAccuracyAcceptable ? Colors.green.shade900 : Colors.red;
//   }

//   // ==========================================================

//   // MAP TYPE

//   // ==========================================================

//   void changeMapType() {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     satelliteMap.value = !satelliteMap.value;
//   }

//   // ==========================================================
//   // MAP ZOOM CONTROLS
//   // ==========================================================

//   void zoomIn() {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     _zoomMapBy(1);
//   }

//   void zoomOut() {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     _zoomMapBy(-1);
//   }

//   void _zoomMapBy(double change) {
//     if (!_mapReady) return;

//     try {
//       final camera = mapController.camera;
//       final double nextZoom = (camera.zoom + change).clamp(2.0, 22.0).toDouble();
//       mapController.move(camera.center, nextZoom);
//     } catch (e) {
//       debugPrint('MAP ZOOM ERROR: $e');
//     }
//   }

//   // ==========================================================

//   // CHECK PHOTO CAPTURE CONDITIONS

//   // ==========================================================

//   bool _canCapturePhoto() {
//     if (selectedLocation.value == null) {
//       Get.snackbar(
//         'Location Required',

//         'Please tap on the map and select a location first.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (!isAccuracyAcceptable) {
//       Get.snackbar(
//         'GPS Accuracy',

//         'GPS accuracy must be 30 metres or less before taking a photo.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     if (!isWithinPhotoRadius) {
//       Get.snackbar(
//         'Outside Geo-Tagging Radius',

//         'You must be within 30 metres of the selected location to take the photo.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     return true;
//   }

//   // ==========================================================
//   // CAPTURE PHOTO 1 / PHOTO 2
//   // ==========================================================
//   // Validate GPS before opening the camera and immediately after it returns.
//   // Coordinates stored with the photo are the capture-time GPS fix, not the
//   // selected map pin's coordinates.

//   Future<void> capturePhoto1() => _capturePhoto(photoNumber: 1);

//   Future<void> capturePhoto2() => _capturePhoto(photoNumber: 2);

//   Future<void> _capturePhoto({required int photoNumber}) async {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     if (!_canCapturePhoto()) return;

//     // Snapshot the selected map point so it cannot silently change mid-capture.
//     final LatLng selectedPoint = selectedLocation.value!;

//     try {
//       isLoading.value = true;

//       final Position? beforeCapture = await _getCurrentPosition();
//       if (beforeCapture == null) return;
//       if (beforeCapture.isMocked) {
//         isMockLocationDetected.value = true;
//         _showMockGpsAlert();
//         return;
//       }

//       if (beforeCapture.accuracy > allowedGpsAccuracy) {
//         Get.snackbar(
//           'GPS Accuracy',
//           'GPS accuracy must be 30 metres or less. Please wait for a better GPS fix.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final double distanceBefore = Geolocator.distanceBetween(
//         beforeCapture.latitude,
//         beforeCapture.longitude,
//         selectedPoint.latitude,
//         selectedPoint.longitude,
//       );
//       if (distanceBefore > allowedPhotoRadius) {
//         Get.snackbar(
//           'Outside Geo-Tagging Radius',
//           'You must be within 30 metres of the selected map point to take this photo.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 85,
//       );
//       if (image == null) return;

//       // Re-check after capture so moving outside the radius while using the
//       // camera cannot result in a wrongly tagged saved photo.
//       final Position? capturePosition = await _getCurrentPosition();
//       if (capturePosition?.isMocked == true) {
//         isMockLocationDetected.value = true;
//         _showMockGpsAlert();
//         return;
//       }
//       if (capturePosition == null) {
//         Get.snackbar(
//           'Photo Location Unavailable',
//           'The photo was not saved because its capture-time GPS could not be verified.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       if (capturePosition.accuracy > allowedGpsAccuracy) {
//         Get.snackbar(
//           'GPS Accuracy Too Low',
//           'The photo was not saved. Capture-time GPS accuracy must be 30 metres or less.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       final double captureDistance = Geolocator.distanceBetween(
//         capturePosition.latitude,
//         capturePosition.longitude,
//         selectedPoint.latitude,
//         selectedPoint.longitude,
//       );
//       if (captureDistance > allowedPhotoRadius) {
//         Get.snackbar(
//           'Photo Outside 30 Metres',
//           'Photo rejected: capture-time location is ${captureDistance.toStringAsFixed(1)} m from the selected map point. Maximum allowed distance is 30 m.',
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 5),
//         );
//         return;
//       }

//       final String capturedLatitude = capturePosition.latitude.toStringAsFixed(
//         6,
//       );
//       final String capturedLongitude = capturePosition.longitude
//           .toStringAsFixed(6);
//       final String capturedAt = DateFormat(
//         'dd-MM-yyyy HH:mm:ss.SSS',
//       ).format(DateTime.now());

//       if (photoNumber == 1) {
//         photo1Path.value = image.path;
//         photo1Latitude.value = capturedLatitude;
//         photo1Longitude.value = capturedLongitude;
//         photo1DateTime.value = capturedAt;
//       } else {
//         photo2Path.value = image.path;
//         photo2Latitude.value = capturedLatitude;
//         photo2Longitude.value = capturedLongitude;
//         photo2DateTime.value = capturedAt;
//       }

//       Get.snackbar(
//         'Photo $photoNumber',
//         'Photo $photoNumber captured and location verified (${captureDistance.toStringAsFixed(1)} m from selected point).',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e, stackTrace) {
//       debugPrint('PHOTO $photoNumber ERROR: $e');
//       debugPrintStack(stackTrace: stackTrace);
//       Get.snackbar(
//         'Camera Error',
//         'Unable to capture and verify Photo $photoNumber.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================

//   // REMOVE PHOTO 1

//   // ==========================================================

//   void removePhoto1() {
//     photo1Path.value = '';

//     photo1Latitude.value = '';

//     photo1Longitude.value = '';

//     photo1DateTime.value = '';
//   }

//   // ==========================================================

//   // REMOVE PHOTO 2

//   // ==========================================================

//   void removePhoto2() {
//     photo2Path.value = '';

//     photo2Latitude.value = '';

//     photo2Longitude.value = '';

//     photo2DateTime.value = '';
//   }

//   // ==========================================================

//   // VALIDATE BEFORE SAVE

//   // ==========================================================

//   bool _validateBeforeSave() {
//     if (selectedLocation.value == null) {
//       Get.snackbar(
//         'Validation',

//         'Please tap on the map and select a location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // GPS ACCURACY CHECK

//     // ========================================================

//     // When BOTH photos are captured, GPS accuracy is NOT

//     // checked when Save Data is pressed.

//     //

//     // If either photo is missing, GPS accuracy must be

//     // 30 metres or less.

//     // ========================================================

//     final bool bothPhotosCaptured =
//         photo1Path.value.isNotEmpty && photo2Path.value.isNotEmpty;

//     if (!bothPhotosCaptured && !isAccuracyAcceptable) {
//       Get.snackbar(
//         'Validation',

//         'GPS accuracy must be 30 metres or less.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // 30 METRE RADIUS CHECK

//     // ========================================================

//     if (!isWithinPhotoRadius) {
//       Get.snackbar(
//         'Validation',

//         'You must be within 30 metres of the selected location.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // PHOTO 1

//     // ========================================================

//     if (photo1Path.value.isEmpty) {
//       Get.snackbar(
//         'Validation',

//         'Please capture Photo 1.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     // ========================================================

//     // PHOTO 2

//     // ========================================================

//     if (photo2Path.value.isEmpty) {
//       Get.snackbar(
//         'Validation',

//         'Please capture Photo 2.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     }

//     return true;
//   }

//   // ==========================================================

//   // SAVE DATA

//   // ==========================================================

//   Future<void> saveData() async {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     if (!_validateBeforeSave()) {
//       return;
//     }

//     try {
//       isSaving.value = true;

//       // Use the same persistent Device ID displayed on the dashboard.
//       final String deviceId = await DeviceIdService.getOrCreateDeviceId();

//       final arguments =
//           Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};

//       final String mobile = arguments['mobileNumber']?.toString() ?? '';

//       final String districtName = arguments['districtName']?.toString() ?? '';

//       final String talukName = arguments['talukName']?.toString() ?? '';

//       final String districtCode = arguments['districtCode']?.toString() ?? '';

//       final String talukCode = arguments['talukCode']?.toString() ?? '';

//       final PackageInfo packageInfo = await PackageInfo.fromPlatform();

//       final String collectedVersion = packageInfo.version;

//       final int runningNumber = await database.getNextRunningId();

//       final String runningId = runningNumber.toString().padLeft(3, '0');

//       final String uniqueId =
//           'NAMMAKAIMAGGA-'
//           '$districtCode-'
//           '$talukCode-'
//           '$mobile-'
//           '$runningId';

//       final String createdDate = DateFormat(
//         'dd-MM-yyyy HH:mm:ss',
//       ).format(DateTime.now());

//       final String photo1Details =
//           '${photo1DateTime.value} | '
//           'Latitude: ${photo1Latitude.value} | '
//           'Longitude: ${photo1Longitude.value}';

//       final String photo2Details =
//           '${photo2DateTime.value} | '
//           'Latitude: ${photo2Latitude.value} | '
//           'Longitude: ${photo2Longitude.value}';

//       final Map<String, dynamic> data = {
//         'p1': uniqueId,

//         'p2': districtName,

//         'p3': talukName,

//         'p4': districtCode,

//         'p5': talukCode,

//         'p6': selectedLatitude.value,

//         'p7': selectedLongitude.value,

//         'p8': photo1Path.value,

//         'p9': photo2Path.value,

//         'p10': photo1Details,

//         'p11': photo2Details,

//         'p12': mobile,

//         'p13': deviceId,

//         'p14': remarksController.text.trim(),

//         'p15': collectedVersion,

//         'p16': collectedVersion,

//         'p17': createdDate,

//         'p100': uniqueId,

//         'syncStatus': 'Pending',
//       };

//       await database.insertSurvey(data);

//       debugPrint('SURVEY SAVED SUCCESSFULLY');

//       debugPrint('UNIQUE ID: $uniqueId');

//       Get.snackbar(
//         'Success',

//         'Geo-tagged data saved successfully.',

//         snackPosition: SnackPosition.BOTTOM,
//       );

//       // ======================================================

//       // DIRECTLY RETURN TO DASHBOARD

//       // ======================================================

//       Get.offAllNamed(AppRoutes.dashboard, arguments: arguments);
//     } catch (e) {
//       debugPrint('SAVE DATA ERROR: $e');

//       Get.snackbar(
//         'Save Error',

//         'Unable to save the geo-tagged data.',

//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isSaving.value = false;
//     }
//   }

//   // ==========================================================

//   // CANCEL

//   // ==========================================================

//   Future<void> cancel() async {
//     if (isMockLocationDetected.value) {
//       _showMockGpsAlert();
//       return;
//     }
//     final bool? confirm = await Get.dialog<bool>(
//       AlertDialog(
//         title: const Text('Cancel Geo Tagging?'),

//         content: const Text('Any unsaved data on this screen will be lost.'),

//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back(result: false);
//             },

//             child: const Text('No'),
//           ),

//           ElevatedButton(
//             onPressed: () {
//               Get.back(result: true);
//             },

//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );

//     if (confirm == true) {
//       Get.offAllNamed(AppRoutes.dashboard, arguments: Get.arguments);
//     }
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
import '../../device_id_service.dart';

class GeoTaggingController extends GetxController {
  // ==========================================================

  // SERVICES

  // ==========================================================

  final ImagePicker _picker = ImagePicker();

  final MapController mapController = MapController();

  final DatabaseHelper database = DatabaseHelper.instance;

  // ==========================================================

  // MAP

  // ==========================================================

  final double initialZoom = 18.0;

  // The map is centered on the first available GPS fix only once. Subsequent
  // GPS refreshes update the marker without interrupting the user's map panning.

  // ==========================================================

  // LOADING

  // ==========================================================

  final RxBool isLoading = false.obs;

  final RxBool isSaving = false.obs;

  // Mock/fake GPS protection. When a mock location is detected, the screen
  // stays blocked until a fresh, non-mocked GPS fix is confirmed.
  final RxBool isMockLocationDetected = false.obs;
  bool _mockGpsAlertShown = false;

  // ==========================================================

  // CURRENT USER LOCATION

  // ==========================================================

  final RxString latitude = ''.obs;

  final RxString longitude = ''.obs;

  final RxString accuracy = ''.obs;

  final RxString time = ''.obs;

  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);

  // ==========================================================

  // SELECTED LOCATION ON MAP

  // ==========================================================

  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  final RxString selectedLatitude = ''.obs;

  final RxString selectedLongitude = ''.obs;

  // ==========================================================

  // DISTANCE

  // ==========================================================

  final RxDouble distanceFromSelectedLocation = 0.0.obs;

  // ==========================================================

  // PHOTOS

  // ==========================================================

  final RxString photo1Path = ''.obs;

  final RxString photo2Path = ''.obs;

  // ==========================================================

  // PHOTO 1 GPS DETAILS

  // ==========================================================

  final RxString photo1Latitude = ''.obs;

  final RxString photo1Longitude = ''.obs;

  final RxString photo1DateTime = ''.obs;

  // ==========================================================

  // PHOTO 2 GPS DETAILS

  // ==========================================================

  final RxString photo2Latitude = ''.obs;

  final RxString photo2Longitude = ''.obs;

  final RxString photo2DateTime = ''.obs;

  // ==========================================================

  // REMARKS

  // ==========================================================

  final TextEditingController remarksController = TextEditingController();

  // ==========================================================

  // MAP TYPE

  // ==========================================================

  final RxBool satelliteMap = false.obs;

  // ==========================================================

  // GPS TIMER

  // ==========================================================

  Timer? _gpsTimer;

  bool _gpsRequestInProgress = false;

  // Prevent overlapping CHECK AGAIN requests while the modal alert is open.
  final RxBool _mockGpsCheckInProgress = false.obs;

  bool _mapReady = false;

  bool _initialMapCentered = false;

  // ==========================================================

  // CONSTANTS

  // ==========================================================

  static const double allowedPhotoRadius = 30.0;

  static const double allowedMapSelectionRadius = 30.0;

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
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar(
          'Location',

          'Please enable location services.',

          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'Location',

          'Location permission denied.',

          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Location',

          'Location permission permanently denied. Please enable it from Settings.',

          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }

      return true;
    } catch (e) {
      debugPrint('LOCATION PERMISSION ERROR: $e');

      return false;
    }
  }

  // ==========================================================

  // CONTINUOUS LOCATION TRACKING

  // GPS REFRESH EVERY 1 SECOND

  // ==========================================================

  Future<void> _startContinuousLocationTracking() async {
    final bool permitted = await _checkLocationPermission();

    if (!permitted) {
      return;
    }

    try {
      final Position initialPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );

      _updateCurrentLocation(initialPosition);

      _gpsTimer?.cancel();

      _gpsTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
        await _refreshGpsEverySecond();
      });

      debugPrint('GPS ACCURACY REFRESH STARTED - EVERY 1 SECOND');
    } catch (e) {
      debugPrint('START LOCATION TRACKING ERROR: $e');

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

  Future<void> _refreshGpsEverySecond() async {
    // Stop periodic requests while the blocking alert is open or a manual
    // CHECK AGAIN request is running. This prevents a timer request from
    // racing with the user's fresh GPS check.
    if (_gpsRequestInProgress ||
        isMockLocationDetected.value ||
        _mockGpsCheckInProgress.value) {
      return;
    }

    _gpsRequestInProgress = true;

    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );

      _updateCurrentLocation(position);

      if (!position.isMocked && !isMockLocationDetected.value) {
        debugPrint(
          'GPS REFRESH -> '
          'LAT: ${position.latitude.toStringAsFixed(6)}, '
          'LNG: ${position.longitude.toStringAsFixed(6)}, '
          'ACCURACY: ${position.accuracy.toStringAsFixed(2)} m',
        );
      }
    } catch (e) {
      debugPrint('GPS 1 SECOND REFRESH ERROR: $e');
    } finally {
      _gpsRequestInProgress = false;
    }
  }

  // ==========================================================

  // UPDATE CURRENT LOCATION

  // ==========================================================

  void _updateCurrentLocation(Position position) {
    if (position.isMocked) {
      isMockLocationDetected.value = true;
      _showMockGpsAlert();
      debugPrint('MOCK GPS DETECTED - GEO TAGGING BLOCKED');
      return;
    }

    // Do not resume location updates while the blocking mock-GPS alert is
    // active; the user must explicitly recheck after closing the mock app.
    if (isMockLocationDetected.value) return;

    final double lat = position.latitude;

    final double lng = position.longitude;

    latitude.value = lat.toStringAsFixed(6);

    longitude.value = lng.toStringAsFixed(6);

    accuracy.value = '${position.accuracy.toStringAsFixed(2)} m';

    time.value = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    currentLocation.value = LatLng(lat, lng);

    _calculateDistanceFromSelectedLocation();

    // Center the map on the first available GPS fix, but never recenter on
    // every refresh because that would prevent the user from panning the map.
    _centerMapOnInitialLocationIfReady();
  }

  // ==========================================================
  // MAP READY / INITIAL CENTER
  // ==========================================================

  void onMapReady() {
    _mapReady = true;
    _centerMapOnInitialLocationIfReady();
  }

  void _centerMapOnInitialLocationIfReady() {
    if (!_mapReady || _initialMapCentered) return;

    final LatLng? location = currentLocation.value;
    if (location == null) return;

    try {
      mapController.move(location, initialZoom);
      _initialMapCentered = true;
    } catch (e) {
      debugPrint('INITIAL MAP CENTER ERROR: $e');
    }
  }

  // ==========================================================

  // MOVE TO CURRENT LOCATION

  // ==========================================================

  Future<void> moveToCurrentLocation() async {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    try {
      isLoading.value = true;

      final Position? position = await _getCurrentPosition();

      if (position == null) {
        return;
      }

      _updateCurrentLocation(position);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          mapController.move(
            LatLng(position.latitude, position.longitude),

            initialZoom,
          );
        } catch (_) {}
      });
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // MOCK / FAKE GPS DETECTION AND SCREEN BLOCK
  // ==========================================================

  void _showMockGpsAlert() {
    if (_mockGpsAlertShown || !isMockLocationDetected.value) return;
    _mockGpsAlertShown = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Get.isRegistered<GeoTaggingController>() ||
          !isMockLocationDetected.value) {
        _mockGpsAlertShown = false;
        return;
      }

      Get.dialog<void>(
        PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Mock / Fake GPS Detected'),
            content: const Text(
              'Please close the fake or mock GPS app before starting to geotag.',
            ),
            actions: [
              TextButton(
                onPressed: _mockGpsCheckInProgress.value
                    ? null
                    : _recheckMockGpsAndUnblock,
                child: Obx(
                  () => _mockGpsCheckInProgress.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('CHECK AGAIN'),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      ).whenComplete(() {
        _mockGpsAlertShown = false;
      });
    });
  }

  Future<void> _recheckMockGpsAndUnblock() async {
    if (_mockGpsCheckInProgress.value) return;

    _mockGpsCheckInProgress.value = true;
    try {
      // Confirm the GPS service and permission are still available before
      // requesting a fresh position.
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Location Services Disabled',
          'Enable location services, then tap CHECK AGAIN.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Location Permission Required',
          'Allow location permission, then tap CHECK AGAIN.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // This request is separate from the periodic timer, which is paused
      // while the mock-GPS alert is active.
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );

      if (position.isMocked) {
        Get.snackbar(
          'Mock / Fake GPS Still Active',
          'Close the fake or mock GPS app, disable mock location, then tap CHECK AGAIN.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Unblock first so _updateCurrentLocation can accept this valid fix.
      isMockLocationDetected.value = false;
      if (Get.isDialogOpen == true) {
        Get.back<void>();
      }
      _updateCurrentLocation(position);
      debugPrint('MOCK GPS CHECK PASSED - GEO TAGGING UNBLOCKED');
    } catch (e) {
      debugPrint('MOCK GPS RECHECK ERROR: $e');
      Get.snackbar(
        'Location Check Failed',
        'Unable to verify GPS. Please check location services and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _mockGpsCheckInProgress.value = false;
    }
  }

  // ==========================================================

  // GET CURRENT POSITION

  // ==========================================================

  Future<Position?> _getCurrentPosition() async {
    final bool permitted = await _checkLocationPermission();

    if (!permitted) {
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );
    } catch (e) {
      debugPrint('GET CURRENT POSITION ERROR: $e');

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

  Future<void> onMapTap(TapPosition tapPosition, LatLng point) async {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }

    final LatLng? current = currentLocation.value;
    if (current == null) {
      await Get.dialog<void>(
        AlertDialog(
          title: const Text('Current Location Unavailable'),
          content: const Text(
            'Please wait until your current GPS location is available, then select a location on the map.',
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('OK')),
          ],
        ),
        barrierDismissible: false,
      );
      return;
    }

    final double distance = Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      point.latitude,
      point.longitude,
    );

    if (distance > allowedMapSelectionRadius) {
      await Get.dialog<void>(
        AlertDialog(
          title: const Text('Location Beyond 30 Metres'),
          content: Text(
            'The selected location is ${distance.toStringAsFixed(1)} metres from your current location. '
            'Please press OK and select a closer location within 30 metres.',
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('OK')),
          ],
        ),
        barrierDismissible: false,
        barrierColor: Colors.black54,
      );
      return;
    }

    selectedLocation.value = point;
    selectedLatitude.value = point.latitude.toStringAsFixed(6);
    selectedLongitude.value = point.longitude.toStringAsFixed(6);
    distanceFromSelectedLocation.value = distance;

    debugPrint(
      'SELECTED LOCATION WITHIN 30M: '
      '${point.latitude}, ${point.longitude}; distance=${distance.toStringAsFixed(2)}m',
    );
  }

  // ==========================================================

  // CALCULATE DISTANCE

  // ==========================================================

  void _calculateDistanceFromSelectedLocation() {
    final LatLng? current = currentLocation.value;

    final LatLng? selected = selectedLocation.value;

    if (current == null || selected == null) {
      distanceFromSelectedLocation.value = 0.0;

      return;
    }

    final double distance = Geolocator.distanceBetween(
      current.latitude,

      current.longitude,

      selected.latitude,

      selected.longitude,
    );

    distanceFromSelectedLocation.value = distance;
  }

  // ==========================================================

  // WITHIN PHOTO RADIUS

  // ==========================================================

  bool get isWithinPhotoRadius {
    return selectedLocation.value != null &&
        distanceFromSelectedLocation.value <= allowedPhotoRadius;
  }

  // ==========================================================

  // ACCURACY CHECK

  // ==========================================================

  bool get isAccuracyAcceptable {
    final double? value = double.tryParse(accuracy.value.replaceAll(' m', ''));

    if (value == null) {
      return false;
    }

    return value <= allowedGpsAccuracy;
  }

  // ==========================================================

  // ACCURACY COLOR

  // ==========================================================

  Color get accuracyColor {
    return isAccuracyAcceptable ? Colors.green.shade900 : Colors.red;
  }

  // ==========================================================

  // MAP TYPE

  // ==========================================================

  void changeMapType() {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    satelliteMap.value = !satelliteMap.value;
  }

  // ==========================================================
  // MAP ZOOM CONTROLS
  // ==========================================================

  void zoomIn() {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    _zoomMapBy(1);
  }

  void zoomOut() {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    _zoomMapBy(-1);
  }

  void _zoomMapBy(double change) {
    if (!_mapReady) return;

    try {
      final camera = mapController.camera;
      final double nextZoom = (camera.zoom + change).clamp(2.0, 22.0).toDouble();
      mapController.move(camera.center, nextZoom);
    } catch (e) {
      debugPrint('MAP ZOOM ERROR: $e');
    }
  }

  // ==========================================================

  // CHECK PHOTO CAPTURE CONDITIONS

  // ==========================================================

  bool _canCapturePhoto() {
    if (selectedLocation.value == null) {
      Get.snackbar(
        'Location Required',

        'Please tap on the map and select a location first.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isAccuracyAcceptable) {
      Get.snackbar(
        'GPS Accuracy',

        'GPS accuracy must be 30 metres or less before taking a photo.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    if (!isWithinPhotoRadius) {
      Get.snackbar(
        'Outside Geo-Tagging Radius',

        'You must be within 30 metres of the selected location to take the photo.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    return true;
  }

  // ==========================================================
  // CAPTURE PHOTO 1 / PHOTO 2
  // ==========================================================
  // Validate GPS before opening the camera and immediately after it returns.
  // Coordinates stored with the photo are the capture-time GPS fix, not the
  // selected map pin's coordinates.

  Future<void> capturePhoto1() => _capturePhoto(photoNumber: 1);

  Future<void> capturePhoto2() => _capturePhoto(photoNumber: 2);

  Future<void> _capturePhoto({required int photoNumber}) async {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    if (!_canCapturePhoto()) return;

    // Snapshot the selected map point so it cannot silently change mid-capture.
    final LatLng selectedPoint = selectedLocation.value!;

    try {
      isLoading.value = true;

      final Position? beforeCapture = await _getCurrentPosition();
      if (beforeCapture == null) return;
      if (beforeCapture.isMocked) {
        isMockLocationDetected.value = true;
        _showMockGpsAlert();
        return;
      }

      if (beforeCapture.accuracy > allowedGpsAccuracy) {
        Get.snackbar(
          'GPS Accuracy',
          'GPS accuracy must be 30 metres or less. Please wait for a better GPS fix.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final double distanceBefore = Geolocator.distanceBetween(
        beforeCapture.latitude,
        beforeCapture.longitude,
        selectedPoint.latitude,
        selectedPoint.longitude,
      );
      if (distanceBefore > allowedPhotoRadius) {
        Get.snackbar(
          'Outside Geo-Tagging Radius',
          'You must be within 30 metres of the selected map point to take this photo.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (image == null) return;

      // Re-check after capture so moving outside the radius while using the
      // camera cannot result in a wrongly tagged saved photo.
      final Position? capturePosition = await _getCurrentPosition();
      if (capturePosition?.isMocked == true) {
        isMockLocationDetected.value = true;
        _showMockGpsAlert();
        return;
      }
      if (capturePosition == null) {
        Get.snackbar(
          'Photo Location Unavailable',
          'The photo was not saved because its capture-time GPS could not be verified.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (capturePosition.accuracy > allowedGpsAccuracy) {
        Get.snackbar(
          'GPS Accuracy Too Low',
          'The photo was not saved. Capture-time GPS accuracy must be 30 metres or less.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final double captureDistance = Geolocator.distanceBetween(
        capturePosition.latitude,
        capturePosition.longitude,
        selectedPoint.latitude,
        selectedPoint.longitude,
      );
      if (captureDistance > allowedPhotoRadius) {
        Get.snackbar(
          'Photo Outside 30 Metres',
          'Photo rejected: capture-time location is ${captureDistance.toStringAsFixed(1)} m from the selected map point. Maximum allowed distance is 30 m.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        return;
      }

      final String capturedLatitude = capturePosition.latitude.toStringAsFixed(
        6,
      );
      final String capturedLongitude = capturePosition.longitude
          .toStringAsFixed(6);
      final String capturedAt = DateFormat(
        'dd-MM-yyyy HH:mm:ss.SSS',
      ).format(DateTime.now());

      if (photoNumber == 1) {
        photo1Path.value = image.path;
        photo1Latitude.value = capturedLatitude;
        photo1Longitude.value = capturedLongitude;
        photo1DateTime.value = capturedAt;
      } else {
        photo2Path.value = image.path;
        photo2Latitude.value = capturedLatitude;
        photo2Longitude.value = capturedLongitude;
        photo2DateTime.value = capturedAt;
      }

      Get.snackbar(
        'Photo $photoNumber',
        'Photo $photoNumber captured and location verified (${captureDistance.toStringAsFixed(1)} m from selected point).',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, stackTrace) {
      debugPrint('PHOTO $photoNumber ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar(
        'Camera Error',
        'Unable to capture and verify Photo $photoNumber.',
        snackPosition: SnackPosition.BOTTOM,
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
    if (selectedLocation.value == null) {
      Get.snackbar(
        'Validation',

        'Please tap on the map and select a location.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    // ========================================================

    // GPS ACCURACY CHECK

    // ========================================================

    // When BOTH photos are captured, GPS accuracy is NOT

    // checked when Save Data is pressed.

    //

    // If either photo is missing, GPS accuracy must be

    // 30 metres or less.

    // ========================================================

    final bool bothPhotosCaptured =
        photo1Path.value.isNotEmpty && photo2Path.value.isNotEmpty;

    if (!bothPhotosCaptured && !isAccuracyAcceptable) {
      Get.snackbar(
        'Validation',

        'GPS accuracy must be 30 metres or less.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    // ========================================================

    // 30 METRE RADIUS CHECK

    // ========================================================

    if (!isWithinPhotoRadius) {
      Get.snackbar(
        'Validation',

        'You must be within 30 metres of the selected location.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    // ========================================================

    // PHOTO 1

    // ========================================================

    if (photo1Path.value.isEmpty) {
      Get.snackbar(
        'Validation',

        'Please capture Photo 1.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    // ========================================================

    // PHOTO 2

    // ========================================================

    if (photo2Path.value.isEmpty) {
      Get.snackbar(
        'Validation',

        'Please capture Photo 2.',

        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    return true;
  }

  // ==========================================================

  // SAVE DATA

  // ==========================================================

  Future<void> saveData() async {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    if (!_validateBeforeSave()) {
      return;
    }

    try {
      isSaving.value = true;

      // Use the same persistent Device ID displayed on the dashboard.
      final String deviceId = await DeviceIdService.getOrCreateDeviceId();

      final arguments =
          Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};

      final String mobile = arguments['mobileNumber']?.toString() ?? '';

      final String districtName = arguments['districtName']?.toString() ?? '';

      final String talukName = arguments['talukName']?.toString() ?? '';

      final String districtCode = arguments['districtCode']?.toString() ?? '';

      final String talukCode = arguments['talukCode']?.toString() ?? '';

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final String collectedVersion = packageInfo.version;

      final int runningNumber = await database.getNextRunningId();

      final String runningId = runningNumber.toString().padLeft(3, '0');

      final String uniqueId =
          'NAMMAKAIMAGGA-'
          '$districtCode-'
          '$talukCode-'
          '$mobile-'
          '$runningId';

      final String createdDate = DateFormat(
        'dd-MM-yyyy HH:mm:ss',
      ).format(DateTime.now());

      final String photo1Details =
          '${photo1DateTime.value} | '
          'Latitude: ${photo1Latitude.value} | '
          'Longitude: ${photo1Longitude.value}';

      final String photo2Details =
          '${photo2DateTime.value} | '
          'Latitude: ${photo2Latitude.value} | '
          'Longitude: ${photo2Longitude.value}';

      final Map<String, dynamic> data = {
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

        'p13': deviceId,

        'p14': remarksController.text.trim(),

        'p15': collectedVersion,

        'p16': collectedVersion,

        'p17': createdDate,

        'p100': uniqueId,

        'syncStatus': 'Pending',
      };

      await database.insertSurvey(data);

      debugPrint('SURVEY SAVED SUCCESSFULLY');

      debugPrint('UNIQUE ID: $uniqueId');

      Get.snackbar(
        'Success',

        'Geo-tagged data saved successfully.',

        snackPosition: SnackPosition.BOTTOM,
      );

      // ======================================================

      // DIRECTLY RETURN TO DASHBOARD

      // ======================================================

      Get.offAllNamed(AppRoutes.dashboard, arguments: arguments);
    } catch (e) {
      debugPrint('SAVE DATA ERROR: $e');

      Get.snackbar(
        'Save Error',

        'Unable to save the geo-tagged data.',

        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // ==========================================================

  // CANCEL

  // ==========================================================

  Future<void> cancel() async {
    if (isMockLocationDetected.value) {
      _showMockGpsAlert();
      return;
    }
    final bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Cancel Geo Tagging?'),

        content: const Text('Any unsaved data on this screen will be lost.'),

        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },

            child: const Text('No'),
          ),

          ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },

            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      Get.offAllNamed(AppRoutes.dashboard, arguments: Get.arguments);
    }
  }
}
