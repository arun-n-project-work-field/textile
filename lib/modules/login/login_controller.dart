// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../routes/app_routes.dart';

// class LoginController extends GetxController {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   final usernameList = <String>[
//     "Officer001",
//     "Officer002",
//     "Admin",
//     "Surveyor01",
//     "Surveyor02",
//     "District Officer",
//   ].obs;

//   final obscurePassword = true.obs;

//   void togglePassword() {
//     obscurePassword.value = !obscurePassword.value;
//   }

//   Future<void> login() async {
//     if (usernameController.text.trim().isEmpty) {
//       Get.snackbar(
//         "Username",
//         "Please enter username",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (passwordController.text.trim().isEmpty) {
//       Get.snackbar(
//         "Password",
//         "Please enter password",
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     Get.offAllNamed(AppRoutes.dashboard);
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../services/api_service.dart';
// import '../../core/services/pref_service.dart';
// import '../../routes/app_routes.dart';

// class LoginController extends GetxController {

//   // ==========================================================
//   // CONTROLLERS
//   // ==========================================================

//   final mobileController =
//       TextEditingController();

//   final otpController =
//       TextEditingController();

//   // ==========================================================
//   // SERVICE
//   // ==========================================================

//   final ApiService apiService =
//       ApiService();

//   // ==========================================================
//   // STATE
//   // ==========================================================

//   final RxBool isLoading =
//       false.obs;

//   final RxBool otpSent =
//       false.obs;

//   final RxBool obscureOtp =
//       true.obs;

//   // ==========================================================
//   // SEND OTP
//   // ==========================================================

//   Future<void> sendOtp() async {

//     final mobile =
//         mobileController.text.trim();

//     if (mobile.isEmpty) {

//       Get.snackbar(
//         'Validation',
//         'Enter mobile number',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (mobile.length != 10) {

//       Get.snackbar(
//         'Validation',
//         'Enter a valid 10 digit mobile number',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {

//       isLoading.value = true;

//       final response =
//           await apiService.sendOtp(
//         mobile,
//       );

//       debugPrint(
//         'OTP RESPONSE: $response',
//       );

//       if (response['status'] == true) {

//         otpSent.value = true;

//         Get.snackbar(
//           'Success',
//           response['message'] ??
//               'OTP sent successfully',
//           snackPosition:
//               SnackPosition.BOTTOM,
//         );

//       } else {

//         Get.snackbar(
//           'OTP Failed',
//           response['message'] ??
//               'Unable to send OTP',
//           snackPosition:
//               SnackPosition.BOTTOM,
//         );
//       }

//     } catch (e) {

//       debugPrint(
//         'OTP ERROR: $e',
//       );

//       Get.snackbar(
//         'Error',
//         'Unable to send OTP. Please try again.',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//     } finally {

//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // LOGIN
//   // ==========================================================

//   Future<void> login() async {

//     final otp =
//         otpController.text.trim();

//     if (!otpSent.value) {

//       Get.snackbar(
//         'Validation',
//         'Please request OTP first',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (otp.isEmpty) {

//       Get.snackbar(
//         'Validation',
//         'Enter OTP',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (otp.length != 4) {

//       Get.snackbar(
//         'Validation',
//         'Enter a valid 4 digit OTP',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {

//       isLoading.value = true;

//       // ======================================================
//       // IMPORTANT
//       // ======================================================
//       //
//       // You have currently provided ONLY the OTP sending API.
//       //
//       // There is no OTP verification API yet.
//       //
//       // Therefore this is temporarily accepting the entered OTP.
//       //
//       // Once backend provides the OTP verification API,
//       // replace this section with the actual API call.
//       // ======================================================

//       await Future.delayed(
//         const Duration(
//           milliseconds: 500,
//         ),
//       );

//       // ------------------------------------------------------
//       // SAVE LOGIN STATE
//       // ------------------------------------------------------

//       await PrefService.setLoggedIn(
//         true,
//       );

//       // ------------------------------------------------------
//       // GO TO DASHBOARD
//       // ------------------------------------------------------

//       Get.offAllNamed(
//         AppRoutes.dashboard,
//       );

//     } catch (e) {

//       Get.snackbar(
//         'Login Failed',
//         'Unable to login',
//         snackPosition:
//             SnackPosition.BOTTOM,
//       );

//     } finally {

//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // OTP VISIBILITY
//   // ==========================================================

//   void toggleOtpVisibility() {

//     obscureOtp.value =
//         !obscureOtp.value;
//   }

//   // ==========================================================
//   // CHANGE MOBILE
//   // ==========================================================

//   void changeMobile() {

//     otpSent.value = false;

//     otpController.clear();
//   }

//   // ==========================================================
//   // LOGOUT
//   // ==========================================================

//   Future<void> logout() async {

//     await PrefService.logout();

//     Get.offAllNamed(
//       AppRoutes.login,
//     );
//   }

//   // ==========================================================
//   // DISPOSE
//   // ==========================================================

//   @override
//   void onClose() {

//     mobileController.dispose();

//     otpController.dispose();

//     super.onClose();
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../services/api_service.dart';

// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();

//   // ==========================================================
//   // TEXT CONTROLLERS
//   // ==========================================================

//   final TextEditingController mobileController =
//       TextEditingController();

//   final TextEditingController otpController =
//       TextEditingController();

//   // ==========================================================
//   // OBSERVABLE VARIABLES
//   // ==========================================================

//   // Sending OTP API loading
//   final RxBool isLoading = false.obs;

//   // OTP successfully sent
//   final RxBool otpSent = false.obs;

//   // OTP entered by user
//   final RxString enteredOtp = ''.obs;

//   // OTP received from API
//   final RxString apiOtp = ''.obs;

//   // Resend OTP countdown
//   final RxInt resendSeconds = 0.obs;

//   // OTP visibility
//   final RxBool obscureOtp = true.obs;

//   // OTP verification loading
//   final RxBool isVerifyingOtp = false.obs;

//   // ==========================================================
//   // TIMER
//   // ==========================================================

//   Timer? _resendTimer;

//   // ==========================================================
//   // SEND OTP
//   // ==========================================================

//   Future<void> sendOtp() async {
//     // ----------------------------------------------------------
//     // Do not send while timer is running
//     // ----------------------------------------------------------

//     if (resendSeconds.value > 0) {
//       return;
//     }

//     // ----------------------------------------------------------
//     // Validate mobile number
//     // ----------------------------------------------------------

//     final String mobile =
//         mobileController.text.trim();

//     if (mobile.length != 10 ||
//         !RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
//       Get.snackbar(
//         'Invalid Mobile Number',
//         'Please enter a valid 10 digit mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       // --------------------------------------------------------
//       // START LOADING
//       // --------------------------------------------------------

//       isLoading.value = true;

//       // --------------------------------------------------------
//       // CALL OTP API
//       // --------------------------------------------------------

//       final response =
//           await apiService.sendOtp(mobile);

//       debugPrint(
//         'OTP API RESPONSE: $response',
//       );

//       // --------------------------------------------------------
//       // GET OTP FROM API RESPONSE
//       // --------------------------------------------------------

//       final dynamic receivedOtp =
//           response['OTP'] ??
//           response['Otp'] ??
//           response['otp'];

//       if (receivedOtp == null) {
//         throw Exception(
//           'OTP not found in API response',
//         );
//       }

//       // --------------------------------------------------------
//       // STORE OTP
//       // --------------------------------------------------------

//       apiOtp.value =
//           receivedOtp.toString().trim();

//       debugPrint(
//         'OTP RECEIVED FROM API: ${apiOtp.value}',
//       );

//       // --------------------------------------------------------
//       // OTP SENT
//       // --------------------------------------------------------

//       otpSent.value = true;

//       // Clear previous OTP
//       otpController.clear();

//       enteredOtp.value = '';

//       // --------------------------------------------------------
//       // START 30 SECOND TIMER
//       // --------------------------------------------------------

//       startResendTimer();

//       Get.snackbar(
//         'OTP Sent',
//         'OTP has been sent successfully.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint(
//         'Send OTP error: $e',
//       );

//       Get.snackbar(
//         'OTP Error',
//         'Unable to send OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // START RESEND TIMER
//   // ==========================================================

//   void startResendTimer() {
//     _resendTimer?.cancel();

//     resendSeconds.value = 30;

//     _resendTimer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (resendSeconds.value > 0) {
//           resendSeconds.value--;
//         } else {
//           timer.cancel();
//         }
//       },
//     );
//   }

//   // ==========================================================
//   // OTP TEXT FIELD CHANGE
//   // ==========================================================

//   void onOtpChanged(String value) {
//     // Keep only numbers
//     String numericValue =
//         value.replaceAll(
//       RegExp(r'[^0-9]'),
//       '',
//     );

//     // Maximum 4 digits
//     if (numericValue.length > 4) {
//       numericValue =
//           numericValue.substring(0, 4);
//     }

//     // Keep controller synchronized
//     if (otpController.text != numericValue) {
//       otpController.value =
//           TextEditingValue(
//         text: numericValue,
//         selection:
//             TextSelection.collapsed(
//           offset: numericValue.length,
//         ),
//       );
//     }

//     enteredOtp.value = numericValue;
//   }

//   // ==========================================================
//   // OTP VALIDATION
//   // ==========================================================

//   bool get isOtpValid {
//     return enteredOtp.value.length == 4 &&
//         RegExp(r'^[0-9]{4}$')
//             .hasMatch(enteredOtp.value);
//   }

//   // ==========================================================
//   // LOGIN / VERIFY OTP
//   // ==========================================================

//   Future<void> login() async {
//     // ----------------------------------------------------------
//     // Validate OTP
//     // ----------------------------------------------------------

//     if (!isOtpValid) {
//       Get.snackbar(
//         'Invalid OTP',
//         'Please enter a valid 4 digit OTP.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // ----------------------------------------------------------
//     // Make sure OTP was requested
//     // ----------------------------------------------------------

//     if (apiOtp.value.isEmpty) {
//       Get.snackbar(
//         'OTP Required',
//         'Please request an OTP first.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       // --------------------------------------------------------
//       // START VERIFICATION
//       // --------------------------------------------------------

//       isVerifyingOtp.value = true;

//       final String entered =
//           otpController.text.trim();

//       final String received =
//           apiOtp.value.trim();

//       debugPrint(
//         'ENTERED OTP: $entered',
//       );

//       debugPrint(
//         'API OTP: $received',
//       );

//       // --------------------------------------------------------
//       // COMPARE OTP
//       // --------------------------------------------------------

//       if (entered != received) {
//         debugPrint(
//           'OTP VERIFICATION FAILED',
//         );

//         Get.snackbar(
//           'Invalid OTP',
//           'The OTP entered is incorrect.',
//           snackPosition:
//               SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       // --------------------------------------------------------
//       // OTP VERIFIED
//       // --------------------------------------------------------

//       debugPrint(
//         'OTP VERIFIED SUCCESSFULLY',
//       );

//       // --------------------------------------------------------
//       // NAVIGATE TO HOME
//       // --------------------------------------------------------

//       debugPrint(
//         'NAVIGATING TO HOME',
//       );

//       await Get.offAllNamed('/dashboard');

//       debugPrint(
//         'HOME NAVIGATION COMPLETED',
//       );
//     } catch (e, stackTrace) {
//       debugPrint(
//         'OTP verification error: $e',
//       );

//       debugPrint(
//         'STACK TRACE: $stackTrace',
//       );

//       Get.snackbar(
//         'Login Error',
//         'Unable to complete login. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isVerifyingOtp.value = false;
//     }
//   }

//   // ==========================================================
//   // CHANGE MOBILE NUMBER
//   // ==========================================================

//   void changeMobile() {
//     // Stop timer
//     _resendTimer?.cancel();

//     resendSeconds.value = 0;

//     // Hide OTP section
//     otpSent.value = false;

//     // Clear OTP
//     otpController.clear();

//     enteredOtp.value = '';

//     // Clear API OTP
//     apiOtp.value = '';

//     // Clear mobile number
//     mobileController.clear();
//   }

//   // ==========================================================
//   // TOGGLE OTP VISIBILITY
//   // ==========================================================

//   void toggleOtpVisibility() {
//     obscureOtp.value =
//         !obscureOtp.value;
//   }

//   // ==========================================================
//   // DISPOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     _resendTimer?.cancel();

//     mobileController.dispose();
//     otpController.dispose();

//     super.onClose();
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../routes/app_routes.dart';
// import '../../services/api_service.dart';

// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();

//   // ============================================================
//   // TEXT CONTROLLERS
//   // ============================================================

//   final mobileController = TextEditingController();
//   final otpController = TextEditingController();

//   // ============================================================
//   // DISTRICT / TALUK
//   // ============================================================

//   final districts = <Map<String, dynamic>>[].obs;
//   final taluks = <Map<String, dynamic>>[].obs;

//   final selectedDistrict = Rxn<Map<String, dynamic>>();
//   final selectedTaluk = Rxn<Map<String, dynamic>>();

//   final isLoadingDistricts = false.obs;
//   final isLoadingTaluks = false.obs;

//   // ============================================================
//   // OTP
//   // ============================================================

//   final otpSent = false.obs;

//   final apiOtp = ''.obs;
//   final enteredOtp = ''.obs;

//   final isLoading = false.obs;
//   final isVerifyingOtp = false.obs;

//   final isOtpObscured = true.obs;

//   // ============================================================
//   // RESEND TIMER
//   // ============================================================

//   final resendSeconds = 0.obs;

//   Timer? _resendTimer;

//   // ============================================================
//   // LIFECYCLE
//   // ============================================================

//   @override
//   void onInit() {
//     super.onInit();

//     loadDistricts();
//   }

//   // ============================================================
//   // GET DISTRICTS
//   // ============================================================

//   Future<void> loadDistricts() async {
//     try {
//       isLoadingDistricts.value = true;

//       final response = await apiService.getDistricts();

//       districts.assignAll(response);

//       debugPrint('DISTRICTS COUNT: ${districts.length}');
//       debugPrint('DISTRICTS: $districts');
//     } catch (e) {
//       debugPrint('LOAD DISTRICTS ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to load districts.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingDistricts.value = false;
//     }
//   }

//   // ============================================================
//   // DISTRICT SELECTED
//   // ============================================================

//   Future<void> onDistrictSelected(Map<String, dynamic>? district) async {
//     if (district == null) {
//       return;
//     }

//     selectedDistrict.value = district;

//     // Clear previous taluk
//     selectedTaluk.value = null;
//     taluks.clear();

//     // Reset OTP state
//     resetOtpState();

//     final districtCode = district['Code']?.toString().trim() ?? '';

//     debugPrint('SELECTED DISTRICT: ${district['Name']}');

//     debugPrint('DISTRICT CODE: $districtCode');

//     if (districtCode.isEmpty) {
//       debugPrint('ERROR: District Code is empty');
//       return;
//     }

//     await loadTaluks(districtCode);
//   }

//   // ============================================================
//   // GET TALUKS
//   // ============================================================

//   Future<void> loadTaluks(String districtCode) async {
//     try {
//       isLoadingTaluks.value = true;

//       final response = await apiService.getTaluks(districtCode);

//       taluks.assignAll(response);

//       debugPrint('TALUKS COUNT: ${taluks.length}');
//       debugPrint('TALUKS: $taluks');
//     } catch (e) {
//       debugPrint('LOAD TALUKS ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to load taluks.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingTaluks.value = false;
//     }
//   }

//   // ============================================================
//   // TALUK SELECTED
//   // ============================================================

//   void onTalukSelected(Map<String, dynamic>? taluk) {
//     if (taluk == null) {
//       return;
//     }

//     selectedTaluk.value = taluk;

//     debugPrint('SELECTED TALUK: ${taluk['Name']}');

//     debugPrint('TALUK CODE: ${taluk['Code']}');

//     // Reset OTP whenever taluk changes
//     resetOtpState();
//   }

//   // ============================================================
//   // SEND OTP
//   // ============================================================

//   Future<void> sendOtp() async {
//     final mobile = mobileController.text.trim();

//     /*
//      * IMPORTANT:
//      *
//      * Send OTP button does NOT have to become active only
//      * after entering exactly 10 digits.
//      *
//      * Validation remains here when the user presses the button.
//      */

//     if (mobile.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please enter mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final response = await apiService.sendOtp(mobile);

//       debugPrint('SEND OTP RESPONSE: $response');

//       // --------------------------------------------------------
//       // API SERVICE returns Map<String, dynamic>
//       // --------------------------------------------------------

//       String otp = '';

//       otp =
//           response['OTP']?.toString() ??
//           response['Otp']?.toString() ??
//           response['otp']?.toString() ??
//           '';

//       debugPrint('API OTP: $otp');

//       if (otp.isEmpty) {
//         Get.snackbar(
//           'Error',
//           'OTP was not received from the server.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       // Store API OTP
//       apiOtp.value = otp;

//       // Show OTP section
//       otpSent.value = true;

//       // Clear previously entered OTP
//       enteredOtp.value = '';
//       otpController.clear();

//       // Start 30 second resend timer
//       startResendTimer();

//       Get.snackbar(
//         'Success',
//         'OTP sent successfully.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint('SEND OTP ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Failed to send OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ============================================================
//   // START RESEND TIMER
//   // ============================================================

//   void startResendTimer() {
//     _resendTimer?.cancel();

//     resendSeconds.value = 30;

//     _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (resendSeconds.value > 0) {
//         resendSeconds.value--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   // ============================================================
//   // OTP TEXT CHANGE
//   // ============================================================

//   void onOtpChanged(String value) {
//     // Keep only numbers
//     String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

//     // Maximum 4 digits
//     if (cleanedValue.length > 4) {
//       cleanedValue = cleanedValue.substring(0, 4);
//     }

//     enteredOtp.value = cleanedValue;

//     // Keep TextEditingController synchronized
//     if (otpController.text != cleanedValue) {
//       otpController.value = TextEditingValue(
//         text: cleanedValue,
//         selection: TextSelection.collapsed(offset: cleanedValue.length),
//       );
//     }

//     debugPrint('ENTERED OTP: ${enteredOtp.value}');
//   }

//   // ============================================================
//   // OTP VALIDATION
//   // ============================================================

//   bool get isOtpValid {
//     return enteredOtp.value.length == 4 &&
//         RegExp(r'^[0-9]{4}$').hasMatch(enteredOtp.value);
//   }

//   // ============================================================
//   // LOGIN / VERIFY OTP
//   // ============================================================

//   Future<void> login() async {
//     if (!isOtpValid) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid 4 digit OTP.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isVerifyingOtp.value = true;

//       final entered = enteredOtp.value;
//       final apiOtpValue = apiOtp.value;

//       debugPrint('ENTERED OTP: $entered');

//       debugPrint('API OTP: $apiOtpValue');

//       // --------------------------------------------------------
//       // Compare entered OTP with API OTP
//       // --------------------------------------------------------

//       if (entered == apiOtpValue) {
//         debugPrint('OTP VERIFIED SUCCESSFULLY');

//         // ------------------------------------------------------
//         // GET LOGIN DETAILS
//         // ------------------------------------------------------

//         final mobileNumber = mobileController.text.trim();

//         final districtName = selectedDistrict.value?['Name']?.toString() ?? '';

//         final talukName = selectedTaluk.value?['Name']?.toString() ?? '';

//         debugPrint('LOGIN MOBILE: $mobileNumber');

//         debugPrint('LOGIN DISTRICT: $districtName');

//         debugPrint('LOGIN TALUK: $talukName');

//         // ------------------------------------------------------
//         // NAVIGATE TO DASHBOARD
//         //
//         // Pass the login details through Get.arguments.
//         // ------------------------------------------------------

//         await Get.offAllNamed(
//           AppRoutes.dashboard,
//           arguments: {
//             'mobileNumber': mobileNumber,
//             'districtName': districtName,
//             'talukName': talukName,
//           },
//         );
//       } else {
//         debugPrint('OTP VERIFICATION FAILED');

//         Get.snackbar(
//           'Invalid OTP',
//           'Please enter the correct OTP.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint('OTP verification error: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to verify OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isVerifyingOtp.value = false;
//     }
//   }

//   // ============================================================
//   // CHANGE MOBILE NUMBER
//   // ============================================================

//   void changeMobile() {
//     resetOtpState();

//     mobileController.clear();

//     debugPrint('Mobile number changed');
//   }

//   // ============================================================
//   // TOGGLE OTP VISIBILITY
//   // ============================================================

//   void toggleOtpVisibility() {
//     isOtpObscured.value = !isOtpObscured.value;
//   }

//   // ============================================================
//   // RESET OTP STATE
//   // ============================================================

//   void resetOtpState() {
//     otpSent.value = false;

//     apiOtp.value = '';
//     enteredOtp.value = '';

//     otpController.clear();

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//     _resendTimer = null;
//   }

//   // ============================================================
//   // CLEANUP
//   // ============================================================

//   @override
//   void onClose() {
//     _resendTimer?.cancel();

//     mobileController.dispose();
//     otpController.dispose();

//     super.onClose();
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../routes/app_routes.dart';
// import '../../services/api_service.dart';

// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();

//   // ============================================================
//   // TEXT CONTROLLERS
//   // ============================================================

//   final mobileController = TextEditingController();
//   final otpController = TextEditingController();

//   // ============================================================
//   // DISTRICT / TALUK
//   // ============================================================

//   final districts = <Map<String, dynamic>>[].obs;
//   final taluks = <Map<String, dynamic>>[].obs;

//   final selectedDistrict = Rxn<Map<String, dynamic>>();
//   final selectedTaluk = Rxn<Map<String, dynamic>>();

//   final isLoadingDistricts = false.obs;
//   final isLoadingTaluks = false.obs;

//   // ============================================================
//   // OTP
//   // ============================================================

//   final otpSent = false.obs;

//   final apiOtp = ''.obs;
//   final enteredOtp = ''.obs;

//   final isLoading = false.obs;
//   final isVerifyingOtp = false.obs;

//   final isOtpObscured = true.obs;

//   // ============================================================
//   // RESEND TIMER
//   // ============================================================

//   final resendSeconds = 0.obs;

//   Timer? _resendTimer;

//   // ============================================================
//   // LIFECYCLE
//   // ============================================================

//   @override
//   void onInit() {
//     super.onInit();

//     loadDistricts();
//   }

//   // ============================================================
//   // GET DISTRICTS
//   // ============================================================

//   Future<void> loadDistricts() async {
//     try {
//       isLoadingDistricts.value = true;

//       final response = await apiService.getDistricts();

//       districts.assignAll(response);

//       debugPrint('DISTRICTS COUNT: ${districts.length}');
//       debugPrint('DISTRICTS: $districts');
//     } catch (e) {
//       debugPrint('LOAD DISTRICTS ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to load districts.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingDistricts.value = false;
//     }
//   }

//   // ============================================================
//   // DISTRICT SELECTED
//   // ============================================================

//   Future<void> onDistrictSelected(Map<String, dynamic>? district) async {
//     if (district == null) {
//       return;
//     }

//     selectedDistrict.value = district;

//     // Clear previous taluk
//     selectedTaluk.value = null;
//     taluks.clear();

//     // Reset OTP state
//     resetOtpState();

//     final districtCode = district['Code']?.toString().trim() ?? '';

//     debugPrint('SELECTED DISTRICT: ${district['Name']}');

//     debugPrint('DISTRICT CODE: $districtCode');

//     if (districtCode.isEmpty) {
//       debugPrint('ERROR: District Code is empty');
//       return;
//     }

//     await loadTaluks(districtCode);
//   }

//   // ============================================================
//   // GET TALUKS
//   // ============================================================

//   Future<void> loadTaluks(String districtCode) async {
//     try {
//       isLoadingTaluks.value = true;

//       final response = await apiService.getTaluks(districtCode);

//       taluks.assignAll(response);

//       debugPrint('TALUKS COUNT: ${taluks.length}');
//       debugPrint('TALUKS: $taluks');
//     } catch (e) {
//       debugPrint('LOAD TALUKS ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to load taluks.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingTaluks.value = false;
//     }
//   }

//   // ============================================================
//   // TALUK SELECTED
//   // ============================================================

//   void onTalukSelected(Map<String, dynamic>? taluk) {
//     if (taluk == null) {
//       return;
//     }

//     selectedTaluk.value = taluk;

//     debugPrint('SELECTED TALUK: ${taluk['Name']}');

//     debugPrint('TALUK CODE: ${taluk['Code']}');

//     // Reset OTP whenever taluk changes
//     resetOtpState();
//   }

//   // ============================================================
//   // SEND OTP
//   // ============================================================

//   Future<void> sendOtp() async {
//     final mobile = mobileController.text.trim();

//     /*
//      * IMPORTANT:
//      *
//      * Send OTP button does NOT have to become active only
//      * after entering exactly 10 digits.
//      *
//      * Validation remains here when the user presses the button.
//      */

//     if (mobile.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please enter mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final response = await apiService.sendOtp(mobile);

//       debugPrint('SEND OTP RESPONSE: $response');

//       // --------------------------------------------------------
//       // API SERVICE returns Map<String, dynamic>
//       // --------------------------------------------------------

//       String otp = '';

//       otp =
//           response['OTP']?.toString() ??
//           response['Otp']?.toString() ??
//           response['otp']?.toString() ??
//           '';

//       debugPrint('API OTP: $otp');

//       if (otp.isEmpty) {
//         Get.snackbar(
//           'Error',
//           'OTP was not received from the server.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }

//       // Store API OTP
//       apiOtp.value = otp;

//       // Show OTP section
//       otpSent.value = true;

//       // Clear previously entered OTP
//       enteredOtp.value = '';
//       otpController.clear();

//       // Start 30 second resend timer
//       startResendTimer();

//       Get.snackbar(
//         'Success',
//         'OTP sent successfully.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint('SEND OTP ERROR: $e');

//       Get.snackbar(
//         'Error',
//         'Failed to send OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ============================================================
//   // START RESEND TIMER
//   // ============================================================

//   void startResendTimer() {
//     _resendTimer?.cancel();

//     resendSeconds.value = 30;

//     _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (resendSeconds.value > 0) {
//         resendSeconds.value--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   // ============================================================
//   // OTP TEXT CHANGE
//   // ============================================================

//   void onOtpChanged(String value) {
//     // Keep only numbers
//     String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

//     // Maximum 4 digits
//     if (cleanedValue.length > 4) {
//       cleanedValue = cleanedValue.substring(0, 4);
//     }

//     enteredOtp.value = cleanedValue;

//     // Keep TextEditingController synchronized
//     if (otpController.text != cleanedValue) {
//       otpController.value = TextEditingValue(
//         text: cleanedValue,
//         selection: TextSelection.collapsed(offset: cleanedValue.length),
//       );
//     }

//     debugPrint('ENTERED OTP: ${enteredOtp.value}');
//   }

//   // ============================================================
//   // OTP VALIDATION
//   // ============================================================

//   bool get isOtpValid {
//     return enteredOtp.value.length == 4 &&
//         RegExp(r'^[0-9]{4}$').hasMatch(enteredOtp.value);
//   }

//   // ============================================================
//   // LOGIN / VERIFY OTP
//   // ============================================================

//   Future<void> login() async {
//     if (!isOtpValid) {
//       Get.snackbar(
//         'Error',
//         'Please enter a valid 4 digit OTP.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isVerifyingOtp.value = true;

//       final entered = enteredOtp.value;
//       final apiOtpValue = apiOtp.value;

//       debugPrint('ENTERED OTP: $entered');

//       debugPrint('API OTP: $apiOtpValue');

//       // --------------------------------------------------------
//       // Compare entered OTP with API OTP
//       // --------------------------------------------------------

//       if (entered == apiOtpValue) {
//         debugPrint('OTP VERIFIED SUCCESSFULLY');

//         // ------------------------------------------------------
//         // GET LOGIN DETAILS
//         // ------------------------------------------------------

//         final mobileNumber = mobileController.text.trim();

//         final districtName = selectedDistrict.value?['Name']?.toString() ?? '';

//         final talukName = selectedTaluk.value?['Name']?.toString() ?? '';

//         debugPrint('LOGIN MOBILE: $mobileNumber');

//         debugPrint('LOGIN DISTRICT: $districtName');

//         debugPrint('LOGIN TALUK: $talukName');

//         // ------------------------------------------------------
//         // NAVIGATE TO DASHBOARD
//         //
//         // Pass the login details through Get.arguments.
//         // ------------------------------------------------------

//         await Get.offAllNamed(
//           AppRoutes.dashboard,
//           arguments: {
//             'mobileNumber': mobileNumber,
//             'districtName': districtName,
//             'talukName': talukName,
//           },
//         );
//       } else {
//         debugPrint('OTP VERIFICATION FAILED');

//         Get.snackbar(
//           'Invalid OTP',
//           'Please enter the correct OTP.',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint('OTP verification error: $e');

//       Get.snackbar(
//         'Error',
//         'Unable to verify OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isVerifyingOtp.value = false;
//     }
//   }

//   // ============================================================
//   // CHANGE MOBILE NUMBER
//   // ============================================================

//   void changeMobile() {
//     resetOtpState();

//     mobileController.clear();

//     debugPrint('Mobile number changed');
//   }

//   // ============================================================
//   // TOGGLE OTP VISIBILITY
//   // ============================================================

//   void toggleOtpVisibility() {
//     isOtpObscured.value = !isOtpObscured.value;
//   }

//   // ============================================================
//   // RESET OTP STATE
//   // ============================================================

//   void resetOtpState() {
//     otpSent.value = false;

//     apiOtp.value = '';
//     enteredOtp.value = '';

//     otpController.clear();

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//     _resendTimer = null;
//   }

//   // ============================================================
//   // CLEANUP
//   // ============================================================

//   @override
//   void onClose() {
//     _resendTimer?.cancel();

//     mobileController.dispose();
//     otpController.dispose();

//     super.onClose();
//   }
// }


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:namma_kaimagga_app/core/services/app_session.dart';

// import '../../routes/app_routes.dart';
// import '../../services/api_service.dart';


// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();

//   // ==========================================================
//   // TEXT CONTROLLERS
//   // ==========================================================

//   final TextEditingController mobileController =
//       TextEditingController();

//   final TextEditingController otpController =
//       TextEditingController();

//   // ==========================================================
//   // DISTRICTS
//   // ==========================================================

//   final RxList<Map<String, dynamic>> districts =
//       <Map<String, dynamic>>[].obs;

//   final Rxn<Map<String, dynamic>> selectedDistrict =
//       Rxn<Map<String, dynamic>>();

//   final RxBool isLoadingDistricts = false.obs;

//   // ==========================================================
//   // TALUKS
//   // ==========================================================

//   final RxList<Map<String, dynamic>> taluks =
//       <Map<String, dynamic>>[].obs;

//   final Rxn<Map<String, dynamic>> selectedTaluk =
//       Rxn<Map<String, dynamic>>();

//   final RxBool isLoadingTaluks = false.obs;

//   // ==========================================================
//   // LOADING
//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   final RxBool isVerifyingOtp = false.obs;

//   // ==========================================================
//   // OTP
//   // ==========================================================

//   final RxBool otpSent = false.obs;

//   final RxString enteredOtp = ''.obs;

//   final RxBool isOtpObscured = true.obs;

//   String receivedOtp = '';

//   final RxInt resendSeconds = 0.obs;

//   Timer? _resendTimer;

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     loadDistricts();
//   }

//   // ==========================================================
//   // DISTRICT NAME
//   // ==========================================================

//   String get districtName {
//     return selectedDistrict.value?['Name']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // DISTRICT CODE
//   // ==========================================================

//   String get districtCode {
//     return selectedDistrict.value?['Code']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // TALUK NAME
//   // ==========================================================

//   String get talukName {
//     return selectedTaluk.value?['Name']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // TALUK CODE
//   // ==========================================================

//   String get talukCode {
//     return selectedTaluk.value?['Code']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // LOAD DISTRICTS
//   // ==========================================================

//   Future<void> loadDistricts() async {
//     try {
//       isLoadingDistricts.value = true;

//       debugPrint('LOADING DISTRICTS...');

//       final result = await apiService.getDistricts();

//       debugPrint(
//         'DISTRICTS RESPONSE: $result',
//       );

//       districts.assignAll(result);

//       debugPrint(
//         'DISTRICTS COUNT: ${districts.length}',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOAD DISTRICTS ERROR: $e',
//       );

//       Get.snackbar(
//         'Error',
//         'Unable to load districts.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingDistricts.value = false;
//     }
//   }

//   // ==========================================================
//   // DISTRICT SELECTED
//   // ==========================================================

//   Future<void> onDistrictSelected(
//     Map<String, dynamic>? district,
//   ) async {
//     selectedDistrict.value = district;

//     selectedTaluk.value = null;

//     taluks.clear();

//     if (district == null) {
//       return;
//     }

//     debugPrint(
//       'SELECTED DISTRICT: ${district['Name']}',
//     );

//     debugPrint(
//       'DISTRICT CODE: ${district['Code']}',
//     );

//     final districtCode =
//         district['Code']?.toString().trim() ?? '';

//     if (districtCode.isEmpty) {
//       return;
//     }

//     await loadTaluks(districtCode);
//   }

//   // ==========================================================
//   // LOAD TALUKS
//   // ==========================================================

//   Future<void> loadTaluks(
//     String districtCode,
//   ) async {
//     if (districtCode.isEmpty) {
//       return;
//     }

//     try {
//       isLoadingTaluks.value = true;

//       debugPrint(
//         'LOADING TALUKS FOR DISTRICT: $districtCode',
//       );

//       final result =
//           await apiService.getTaluks(districtCode);

//       debugPrint(
//         'TALUKS RESPONSE: $result',
//       );

//       taluks.assignAll(result);

//       debugPrint(
//         'TALUKS COUNT: ${taluks.length}',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOAD TALUKS ERROR: $e',
//       );

//       Get.snackbar(
//         'Error',
//         'Unable to load taluks.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingTaluks.value = false;
//     }
//   }

//   // ==========================================================
//   // TALUK SELECTED
//   // ==========================================================

//   void onTalukSelected(
//     Map<String, dynamic>? taluk,
//   ) {
//     selectedTaluk.value = taluk;

//     if (taluk == null) {
//       return;
//     }

//     debugPrint(
//       'SELECTED TALUK: ${taluk['Name']}',
//     );

//     debugPrint(
//       'TALUK CODE: ${taluk['Code']}',
//     );
//   }

//   // ==========================================================
//   // SEND OTP
//   // ==========================================================

//   Future<void> sendOtp() async {
//     final mobileNumber =
//         mobileController.text.trim();

//     // --------------------------------------------------------
//     // MOBILE VALIDATION
//     // --------------------------------------------------------

//     if (mobileNumber.length != 10) {
//       Get.snackbar(
//         'Invalid Mobile Number',
//         'Please enter a valid 10-digit mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // DISTRICT VALIDATION
//     // --------------------------------------------------------

//     if (selectedDistrict.value == null) {
//       Get.snackbar(
//         'Select District',
//         'Please select a district.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // TALUK VALIDATION
//     // --------------------------------------------------------

//     if (selectedTaluk.value == null) {
//       Get.snackbar(
//         'Select Taluk',
//         'Please select a taluk.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       isLoading.value = true;

//       debugPrint(
//         'SENDING OTP TO: $mobileNumber',
//       );

//       final response =
//           await apiService.sendOtp(mobileNumber);

//       debugPrint(
//         'OTP RESPONSE: $response',
//       );

//       // ------------------------------------------------------
//       // EXTRACT OTP
//       // ------------------------------------------------------

//       receivedOtp = _extractOtp(response);

//       debugPrint(
//         'RECEIVED OTP: $receivedOtp',
//       );

//       if (receivedOtp.isEmpty) {
//         Get.snackbar(
//           'OTP Error',
//           'OTP was not received from the server.',
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       otpSent.value = true;

//       enteredOtp.value = '';

//       otpController.clear();

//       isOtpObscured.value = true;

//       startResendTimer();

//       Get.snackbar(
//         'OTP Sent',
//         'OTP has been sent to your mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint(
//         'SEND OTP ERROR: $e',
//       );

//       Get.snackbar(
//         'OTP Error',
//         'Unable to send OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // EXTRACT OTP
//   // ==========================================================

//   String _extractOtp(
//     Map<String, dynamic> response,
//   ) {
//     debugPrint(
//       'OTP API MAP: $response',
//     );

//     // Common possible OTP field names.
//     const keys = [
//       'OTP',
//       'Otp',
//       'otp',
//       'OTPCode',
//       'OtpCode',
//       'otpCode',
//       'OTPNumber',
//       'OtpNumber',
//       'otpNumber',
//     ];

//     for (final key in keys) {
//       final value = response[key];

//       if (value != null) {
//         final text = value.toString().trim();

//         if (text.isNotEmpty) {
//           return text;
//         }
//       }
//     }

//     // --------------------------------------------------------
//     // NESTED DATA
//     // --------------------------------------------------------

//     final data = response['data'];

//     if (data is Map) {
//       for (final key in keys) {
//         final value = data[key];

//         if (value != null) {
//           final text = value.toString().trim();

//           if (text.isNotEmpty) {
//             return text;
//           }
//         }
//       }
//     }

//     // --------------------------------------------------------
//     // NESTED RESULT
//     // --------------------------------------------------------

//     final result = response['result'];

//     if (result is Map) {
//       for (final key in keys) {
//         final value = result[key];

//         if (value != null) {
//           final text = value.toString().trim();

//           if (text.isNotEmpty) {
//             return text;
//           }
//         }
//       }
//     }

//     return '';
//   }

//   // ==========================================================
//   // OTP TIMER
//   // ==========================================================

//   void startResendTimer() {
//     _resendTimer?.cancel();

//     resendSeconds.value = 30;

//     _resendTimer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (resendSeconds.value <= 1) {
//           resendSeconds.value = 0;

//           timer.cancel();
//         } else {
//           resendSeconds.value--;
//         }
//       },
//     );
//   }

//   // ==========================================================
//   // RESEND OTP
//   // ==========================================================

//   Future<void> resendOtp() async {
//     if (resendSeconds.value > 0) {
//       return;
//     }

//     await sendOtp();
//   }

//   // ==========================================================
//   // OTP CHANGED
//   // ==========================================================

//   void onOtpChanged(
//     String value,
//   ) {
//     var otp = value;

//     if (otp.length > 4) {
//       otp = otp.substring(0, 4);

//       otpController.text = otp;

//       otpController.selection =
//           TextSelection.fromPosition(
//         TextPosition(
//           offset: otp.length,
//         ),
//       );
//     }

//     enteredOtp.value = otp;
//   }

//   // ==========================================================
//   // OTP VISIBILITY
//   // ==========================================================

//   void toggleOtpVisibility() {
//     isOtpObscured.value =
//         !isOtpObscured.value;
//   }

//   // ==========================================================
//   // OTP VALIDATION
//   // ==========================================================

//   bool get isOtpValid {
//     return enteredOtp.value.length == 4 &&
//         RegExp(
//           r'^[0-9]{4}$',
//         ).hasMatch(
//           enteredOtp.value,
//         );
//   }

//   // ==========================================================
//   // LOGIN
//   // ==========================================================

//   Future<void> login() async {
//     final mobileNumber =
//         mobileController.text.trim();

//     // --------------------------------------------------------
//     // VALIDATE MOBILE
//     // --------------------------------------------------------

//     if (mobileNumber.length != 10) {
//       Get.snackbar(
//         'Invalid Mobile Number',
//         'Please enter a valid 10-digit mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE DISTRICT
//     // --------------------------------------------------------

//     if (selectedDistrict.value == null) {
//       Get.snackbar(
//         'Select District',
//         'Please select a district.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE TALUK
//     // --------------------------------------------------------

//     if (selectedTaluk.value == null) {
//       Get.snackbar(
//         'Select Taluk',
//         'Please select a taluk.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE OTP
//     // --------------------------------------------------------

//     if (!otpSent.value) {
//       Get.snackbar(
//         'OTP Required',
//         'Please send OTP first.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (!isOtpValid) {
//       Get.snackbar(
//         'Invalid OTP',
//         'Please enter the 4-digit OTP.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       isVerifyingOtp.value = true;

//       debugPrint(
//         'ENTERED OTP: ${enteredOtp.value}',
//       );

//       debugPrint(
//         'SERVER OTP: $receivedOtp',
//       );

//       // ------------------------------------------------------
//       // VERIFY OTP
//       // ------------------------------------------------------

//       if (enteredOtp.value.trim() !=
//           receivedOtp.trim()) {
//         Get.snackbar(
//           'Invalid OTP',
//           'The OTP entered is incorrect.',
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       debugPrint(
//         'OTP VERIFIED SUCCESSFULLY',
//       );

//       // ------------------------------------------------------
//       // GET SELECTED VALUES
//       // ------------------------------------------------------

//       final mobile = mobileNumber;

//       final district =
//           districtName;

//       final districtCodeValue =
//           districtCode;

//       final taluk =
//           talukName;

//       final talukCodeValue =
//           talukCode;

//       debugPrint(
//         'LOGIN MOBILE: $mobile',
//       );

//       debugPrint(
//         'LOGIN DISTRICT: $district',
//       );

//       debugPrint(
//         'LOGIN DISTRICT CODE: $districtCodeValue',
//       );

//       debugPrint(
//         'LOGIN TALUK: $taluk',
//       );

//       debugPrint(
//         'LOGIN TALUK CODE: $talukCodeValue',
//       );

//       // ------------------------------------------------------
//       // SAVE SESSION
//       // ------------------------------------------------------

//       await AppSession.saveLoginCredentials(
//         mobileNumber: mobile,
//         districtName: district,
//         districtCode: districtCodeValue,
//         talukName: taluk,
//         talukCode: talukCodeValue,
//       );

//       debugPrint(
//         'LOGIN SESSION SAVED',
//       );

//       // ------------------------------------------------------
//       // DASHBOARD ARGUMENTS
//       // ------------------------------------------------------

//       final loginData = {
//         'mobileNumber': mobile,
//         'districtName': district,
//         'districtCode': districtCodeValue,
//         'talukName': taluk,
//         'talukCode': talukCodeValue,
//       };

//       // ------------------------------------------------------
//       // DASHBOARD
//       // ------------------------------------------------------

//       Get.offAllNamed(
//         AppRoutes.dashboard,
//         arguments: loginData,
//       );
//     } catch (e) {
//       debugPrint(
//         'LOGIN ERROR: $e',
//       );

//       Get.snackbar(
//         'Login Failed',
//         'Unable to complete login. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isVerifyingOtp.value = false;
//     }
//   }

//   // ==========================================================
//   // CHANGE MOBILE
//   // ==========================================================

//   void changeMobile() {
//     otpSent.value = false;

//     receivedOtp = '';

//     enteredOtp.value = '';

//     otpController.clear();

//     isOtpObscured.value = true;

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//   }

//   // ==========================================================
//   // RESET OTP STATE
//   // ==========================================================

//   void resetOtpState() {
//     otpSent.value = false;

//     receivedOtp = '';

//     enteredOtp.value = '';

//     otpController.clear();

//     isOtpObscured.value = true;

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//   }

//   // ==========================================================
//   // LOGOUT
//   // ==========================================================

//   Future<void> logout() async {
//     await AppSession.clearLoginCredentials();

//     debugPrint(
//       'LOGIN SESSION CLEARED',
//     );

//     Get.offAllNamed(
//       AppRoutes.login,
//     );
//   }

//   // ==========================================================
//   // CLOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     _resendTimer?.cancel();

//     mobileController.dispose();

//     otpController.dispose();

//     super.onClose();
//   }
// }


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:namma_kaimagga_app/services/app_session.dart';

// import '../../routes/app_routes.dart';
// import '../../services/api_service.dart';


// class LoginController extends GetxController {
//   final ApiService apiService = ApiService();

//   // ==========================================================
//   // TEXT CONTROLLERS
//   // ==========================================================

//   final TextEditingController mobileController =
//       TextEditingController();

//   final TextEditingController otpController =
//       TextEditingController();

//   // ==========================================================
//   // DISTRICTS
//   // ==========================================================

//   final RxList<Map<String, dynamic>> districts =
//       <Map<String, dynamic>>[].obs;

//   final Rxn<Map<String, dynamic>> selectedDistrict =
//       Rxn<Map<String, dynamic>>();

//   final RxBool isLoadingDistricts = false.obs;

//   // ==========================================================
//   // TALUKS
//   // ==========================================================

//   final RxList<Map<String, dynamic>> taluks =
//       <Map<String, dynamic>>[].obs;

//   final Rxn<Map<String, dynamic>> selectedTaluk =
//       Rxn<Map<String, dynamic>>();

//   final RxBool isLoadingTaluks = false.obs;

//   // ==========================================================
//   // LOADING
//   // ==========================================================

//   final RxBool isLoading = false.obs;

//   final RxBool isVerifyingOtp = false.obs;

//   // ==========================================================
//   // OTP
//   // ==========================================================

//   final RxBool otpSent = false.obs;

//   final RxString enteredOtp = ''.obs;

//   final RxBool isOtpObscured = true.obs;

//   String receivedOtp = '';

//   final RxInt resendSeconds = 0.obs;

//   Timer? _resendTimer;

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void onInit() {
//     super.onInit();

//     loadDistricts();
//   }

//   // ==========================================================
//   // DISTRICT NAME
//   // ==========================================================

//   String get districtName {
//     return selectedDistrict.value?['Name']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // DISTRICT CODE
//   // ==========================================================

//   String get districtCode {
//     return selectedDistrict.value?['Code']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // TALUK NAME
//   // ==========================================================

//   String get talukName {
//     return selectedTaluk.value?['Name']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // TALUK CODE
//   // ==========================================================

//   String get talukCode {
//     return selectedTaluk.value?['Code']
//             ?.toString()
//             .trim() ??
//         '';
//   }

//   // ==========================================================
//   // LOAD DISTRICTS
//   // ==========================================================

//   Future<void> loadDistricts() async {
//     try {
//       isLoadingDistricts.value = true;

//       debugPrint('LOADING DISTRICTS...');

//       final result = await apiService.getDistricts();

//       debugPrint(
//         'DISTRICTS RESPONSE: $result',
//       );

//       districts.assignAll(result);

//       debugPrint(
//         'DISTRICTS COUNT: ${districts.length}',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOAD DISTRICTS ERROR: $e',
//       );

//       Get.snackbar(
//         'Error',
//         'Unable to load districts.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingDistricts.value = false;
//     }
//   }

//   // ==========================================================
//   // DISTRICT SELECTED
//   // ==========================================================

//   Future<void> onDistrictSelected(
//     Map<String, dynamic>? district,
//   ) async {
//     selectedDistrict.value = district;

//     selectedTaluk.value = null;

//     taluks.clear();

//     if (district == null) {
//       return;
//     }

//     debugPrint(
//       'SELECTED DISTRICT: ${district['Name']}',
//     );

//     debugPrint(
//       'DISTRICT CODE: ${district['Code']}',
//     );

//     final districtCode =
//         district['Code']?.toString().trim() ?? '';

//     if (districtCode.isEmpty) {
//       return;
//     }

//     await loadTaluks(districtCode);
//   }

//   // ==========================================================
//   // LOAD TALUKS
//   // ==========================================================

//   Future<void> loadTaluks(
//     String districtCode,
//   ) async {
//     if (districtCode.isEmpty) {
//       return;
//     }

//     try {
//       isLoadingTaluks.value = true;

//       debugPrint(
//         'LOADING TALUKS FOR DISTRICT: $districtCode',
//       );

//       final result =
//           await apiService.getTaluks(districtCode);

//       debugPrint(
//         'TALUKS RESPONSE: $result',
//       );

//       taluks.assignAll(result);

//       debugPrint(
//         'TALUKS COUNT: ${taluks.length}',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOAD TALUKS ERROR: $e',
//       );

//       Get.snackbar(
//         'Error',
//         'Unable to load taluks.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoadingTaluks.value = false;
//     }
//   }

//   // ==========================================================
//   // TALUK SELECTED
//   // ==========================================================

//   void onTalukSelected(
//     Map<String, dynamic>? taluk,
//   ) {
//     selectedTaluk.value = taluk;

//     if (taluk == null) {
//       return;
//     }

//     debugPrint(
//       'SELECTED TALUK: ${taluk['Name']}',
//     );

//     debugPrint(
//       'TALUK CODE: ${taluk['Code']}',
//     );
//   }

//   // ==========================================================
//   // SEND OTP
//   // ==========================================================

//   Future<void> sendOtp() async {
//     final mobileNumber =
//         mobileController.text.trim();

//     // --------------------------------------------------------
//     // MOBILE VALIDATION
//     // --------------------------------------------------------

//     if (mobileNumber.length != 10) {
//       Get.snackbar(
//         'Invalid Mobile Number',
//         'Please enter a valid 10-digit mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // DISTRICT VALIDATION
//     // --------------------------------------------------------

//     if (selectedDistrict.value == null) {
//       Get.snackbar(
//         'Select District',
//         'Please select a district.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // TALUK VALIDATION
//     // --------------------------------------------------------

//     if (selectedTaluk.value == null) {
//       Get.snackbar(
//         'Select Taluk',
//         'Please select a taluk.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       isLoading.value = true;

//       debugPrint(
//         'SENDING OTP TO: $mobileNumber',
//       );

//       final response =
//           await apiService.sendOtp(mobileNumber);

//       debugPrint(
//         'OTP RESPONSE: $response',
//       );

//       // ------------------------------------------------------
//       // EXTRACT OTP
//       // ------------------------------------------------------

//       receivedOtp = _extractOtp(response);

//       debugPrint(
//         'RECEIVED OTP: $receivedOtp',
//       );

//       if (receivedOtp.isEmpty) {
//         Get.snackbar(
//           'OTP Error',
//           'OTP was not received from the server.',
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       otpSent.value = true;

//       enteredOtp.value = '';

//       otpController.clear();

//       isOtpObscured.value = true;

//       startResendTimer();

//       Get.snackbar(
//         'OTP Sent',
//         'OTP has been sent to your mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       debugPrint(
//         'SEND OTP ERROR: $e',
//       );

//       Get.snackbar(
//         'OTP Error',
//         'Unable to send OTP. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ==========================================================
//   // EXTRACT OTP
//   // ==========================================================

//   String _extractOtp(
//     Map<String, dynamic> response,
//   ) {
//     debugPrint(
//       'OTP API MAP: $response',
//     );

//     // Common possible OTP field names.
//     const keys = [
//       'OTP',
//       'Otp',
//       'otp',
//       'OTPCode',
//       'OtpCode',
//       'otpCode',
//       'OTPNumber',
//       'OtpNumber',
//       'otpNumber',
//     ];

//     for (final key in keys) {
//       final value = response[key];

//       if (value != null) {
//         final text = value.toString().trim();

//         if (text.isNotEmpty) {
//           return text;
//         }
//       }
//     }

//     // --------------------------------------------------------
//     // NESTED DATA
//     // --------------------------------------------------------

//     final data = response['data'];

//     if (data is Map) {
//       for (final key in keys) {
//         final value = data[key];

//         if (value != null) {
//           final text = value.toString().trim();

//           if (text.isNotEmpty) {
//             return text;
//           }
//         }
//       }
//     }

//     // --------------------------------------------------------
//     // NESTED RESULT
//     // --------------------------------------------------------

//     final result = response['result'];

//     if (result is Map) {
//       for (final key in keys) {
//         final value = result[key];

//         if (value != null) {
//           final text = value.toString().trim();

//           if (text.isNotEmpty) {
//             return text;
//           }
//         }
//       }
//     }

//     return '';
//   }

//   // ==========================================================
//   // OTP TIMER
//   // ==========================================================

//   void startResendTimer() {
//     _resendTimer?.cancel();

//     resendSeconds.value = 30;

//     _resendTimer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) {
//         if (resendSeconds.value <= 1) {
//           resendSeconds.value = 0;

//           timer.cancel();
//         } else {
//           resendSeconds.value--;
//         }
//       },
//     );
//   }

//   // ==========================================================
//   // RESEND OTP
//   // ==========================================================

//   Future<void> resendOtp() async {
//     if (resendSeconds.value > 0) {
//       return;
//     }

//     await sendOtp();
//   }

//   // ==========================================================
//   // OTP CHANGED
//   // ==========================================================

//   void onOtpChanged(
//     String value,
//   ) {
//     var otp = value;

//     if (otp.length > 4) {
//       otp = otp.substring(0, 4);

//       otpController.text = otp;

//       otpController.selection =
//           TextSelection.fromPosition(
//         TextPosition(
//           offset: otp.length,
//         ),
//       );
//     }

//     enteredOtp.value = otp;
//   }

//   // ==========================================================
//   // OTP VISIBILITY
//   // ==========================================================

//   void toggleOtpVisibility() {
//     isOtpObscured.value =
//         !isOtpObscured.value;
//   }

//   // ==========================================================
//   // OTP VALIDATION
//   // ==========================================================

//   bool get isOtpValid {
//     return enteredOtp.value.length == 4 &&
//         RegExp(
//           r'^[0-9]{4}$',
//         ).hasMatch(
//           enteredOtp.value,
//         );
//   }

//   // ==========================================================
//   // LOGIN
//   // ==========================================================

//   Future<void> login() async {
//     final mobileNumber =
//         mobileController.text.trim();

//     // --------------------------------------------------------
//     // VALIDATE MOBILE
//     // --------------------------------------------------------

//     if (mobileNumber.length != 10) {
//       Get.snackbar(
//         'Invalid Mobile Number',
//         'Please enter a valid 10-digit mobile number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE DISTRICT
//     // --------------------------------------------------------

//     if (selectedDistrict.value == null) {
//       Get.snackbar(
//         'Select District',
//         'Please select a district.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE TALUK
//     // --------------------------------------------------------

//     if (selectedTaluk.value == null) {
//       Get.snackbar(
//         'Select Taluk',
//         'Please select a taluk.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     // --------------------------------------------------------
//     // VALIDATE OTP
//     // --------------------------------------------------------

//     if (!otpSent.value) {
//       Get.snackbar(
//         'OTP Required',
//         'Please send OTP first.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     if (!isOtpValid) {
//       Get.snackbar(
//         'Invalid OTP',
//         'Please enter the 4-digit OTP.',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return;
//     }

//     try {
//       isVerifyingOtp.value = true;

//       debugPrint(
//         'ENTERED OTP: ${enteredOtp.value}',
//       );

//       debugPrint(
//         'SERVER OTP: $receivedOtp',
//       );

//       // ------------------------------------------------------
//       // VERIFY OTP
//       // ------------------------------------------------------

//       if (enteredOtp.value.trim() !=
//           receivedOtp.trim()) {
//         Get.snackbar(
//           'Invalid OTP',
//           'The OTP entered is incorrect.',
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         return;
//       }

//       debugPrint(
//         'OTP VERIFIED SUCCESSFULLY',
//       );

//       // ------------------------------------------------------
//       // GET SELECTED VALUES
//       // ------------------------------------------------------

//       final mobile = mobileNumber;

//       final district =
//           districtName;

//       final districtCodeValue =
//           districtCode;

//       final taluk =
//           talukName;

//       final talukCodeValue =
//           talukCode;

//       debugPrint(
//         'LOGIN MOBILE: $mobile',
//       );

//       debugPrint(
//         'LOGIN DISTRICT: $district',
//       );

//       debugPrint(
//         'LOGIN DISTRICT CODE: $districtCodeValue',
//       );

//       debugPrint(
//         'LOGIN TALUK: $taluk',
//       );

//       debugPrint(
//         'LOGIN TALUK CODE: $talukCodeValue',
//       );

//       // ------------------------------------------------------
//       // SAVE SESSION
//       // ------------------------------------------------------

//       await AppSession.saveLoginCredentials(
//         mobileNumber: mobile,
//         districtName: district,
//         districtCode: districtCodeValue,
//         talukName: taluk,
//         talukCode: talukCodeValue,
//       );

//       debugPrint(
//         'LOGIN SESSION SAVED',
//       );

//       // ------------------------------------------------------
//       // DASHBOARD ARGUMENTS
//       // ------------------------------------------------------

//       final loginData = {
//         'mobileNumber': mobile,
//         'districtName': district,
//         'districtCode': districtCodeValue,
//         'talukName': taluk,
//         'talukCode': talukCodeValue,
//       };

//       // ------------------------------------------------------
//       // DASHBOARD
//       // ------------------------------------------------------

//       Get.offAllNamed(
//         AppRoutes.dashboard,
//         arguments: loginData,
//       );
//     } catch (e) {
//       debugPrint(
//         'LOGIN ERROR: $e',
//       );

//       Get.snackbar(
//         'Login Failed',
//         'Unable to complete login. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isVerifyingOtp.value = false;
//     }
//   }

//   // ==========================================================
//   // CHANGE MOBILE
//   // ==========================================================

//   void changeMobile() {
//     otpSent.value = false;

//     receivedOtp = '';

//     enteredOtp.value = '';

//     otpController.clear();

//     isOtpObscured.value = true;

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//   }

//   // ==========================================================
//   // RESET OTP STATE
//   // ==========================================================

//   void resetOtpState() {
//     otpSent.value = false;

//     receivedOtp = '';

//     enteredOtp.value = '';

//     otpController.clear();

//     isOtpObscured.value = true;

//     resendSeconds.value = 0;

//     _resendTimer?.cancel();
//   }

//   // ==========================================================
//   // LOGOUT
//   // ==========================================================

//   Future<void> logout() async {
//     await AppSession.clearLoginCredentials();

//     debugPrint(
//       'LOGIN SESSION CLEARED',
//     );

//     Get.offAllNamed(
//       AppRoutes.login,
//     );
//   }

//   // ==========================================================
//   // CLOSE
//   // ==========================================================

//   @override
//   void onClose() {
//     _resendTimer?.cancel();

//     mobileController.dispose();

//     otpController.dispose();

//     super.onClose();
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/services/app_session.dart';

import '../../routes/app_routes.dart';
import '../../services/api_service.dart';


class LoginController extends GetxController {
  final ApiService apiService = ApiService();

  // ==========================================================
  // TEXT CONTROLLERS
  // ==========================================================

  final TextEditingController mobileController =
      TextEditingController();

  final TextEditingController otpController =
      TextEditingController();

  final TextEditingController districtTalukPasswordController =
      TextEditingController();

  final RxBool passwordVerified = false.obs;
  final RxBool usedGoogleTestPassword = false.obs;
  final RxBool isPasswordObscured = true.obs;

  /// The production survey password and Google Play review/test password.
  static const String surveyPassword = 'Nmkg@1234';
  static const String googleTestPassword = '1234';
  static const String googleTestMobile = '9999999999';

  void verifyDistrictTalukPassword() {
    final value = districtTalukPasswordController.text;
    if (value == surveyPassword || value == googleTestPassword) {
      passwordVerified.value = true;
      usedGoogleTestPassword.value = value == googleTestPassword;
      if (value == googleTestPassword) {
        // Prefill the reserved Play review account for faster reviewer testing.
        mobileController.text = googleTestMobile;
      }
      Get.snackbar(
        'Password Verified',
        'Password verified. You can continue with your mobile number and OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      passwordVerified.value = false;
      usedGoogleTestPassword.value = false;
      Get.dialog<void>(
        AlertDialog(
          title: const Text('Incorrect Password'),
          content: const Text('Please enter the correct password.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  // ==========================================================
  // DISTRICTS
  // ==========================================================

  final RxList<Map<String, dynamic>> districts =
      <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedDistrict =
      Rxn<Map<String, dynamic>>();

  final RxBool isLoadingDistricts = false.obs;

  // ==========================================================
  // TALUKS
  // ==========================================================

  final RxList<Map<String, dynamic>> taluks =
      <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedTaluk =
      Rxn<Map<String, dynamic>>();

  final RxBool isLoadingTaluks = false.obs;

  // ==========================================================
  // LOADING
  // ==========================================================

  final RxBool isLoading = false.obs;

  final RxBool isVerifyingOtp = false.obs;

  // ==========================================================
  // OTP
  // ==========================================================

  final RxBool otpSent = false.obs;

  final RxString enteredOtp = ''.obs;

  final RxBool isOtpObscured = true.obs;

  String receivedOtp = '';

  final RxInt resendSeconds = 0.obs;

  Timer? _resendTimer;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    loadDistricts();
  }

  // ==========================================================
  // DISTRICT NAME
  // ==========================================================

  String get districtName {
    return selectedDistrict.value?['Name']
            ?.toString()
            .trim() ??
        '';
  }

  // ==========================================================
  // DISTRICT CODE
  // ==========================================================

  String get districtCode {
    return selectedDistrict.value?['Code']
            ?.toString()
            .trim() ??
        '';
  }

  // ==========================================================
  // TALUK NAME
  // ==========================================================

  String get talukName {
    return selectedTaluk.value?['Name']
            ?.toString()
            .trim() ??
        '';
  }

  // ==========================================================
  // TALUK CODE
  // ==========================================================

  String get talukCode {
    return selectedTaluk.value?['Code']
            ?.toString()
            .trim() ??
        '';
  }

  // ==========================================================
  // LOAD DISTRICTS
  // ==========================================================

  Future<void> loadDistricts() async {
    try {
      isLoadingDistricts.value = true;

      debugPrint('LOADING DISTRICTS...');

      final result = await apiService.getDistricts();

      debugPrint(
        'DISTRICTS RESPONSE: $result',
      );

      districts.assignAll(result);

      debugPrint(
        'DISTRICTS COUNT: ${districts.length}',
      );
    } catch (e) {
      debugPrint(
        'LOAD DISTRICTS ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to load districts.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  // ==========================================================
  // DISTRICT SELECTED
  // ==========================================================

  Future<void> onDistrictSelected(
    Map<String, dynamic>? district,
  ) async {
    selectedDistrict.value = district;

    selectedTaluk.value = null;
    passwordVerified.value = false;
    usedGoogleTestPassword.value = false;
    districtTalukPasswordController.clear();
    resetOtpState();

    taluks.clear();

    if (district == null) {
      return;
    }

    debugPrint(
      'SELECTED DISTRICT: ${district['Name']}',
    );

    debugPrint(
      'DISTRICT CODE: ${district['Code']}',
    );

    final districtCode =
        district['Code']?.toString().trim() ?? '';

    if (districtCode.isEmpty) {
      return;
    }

    await loadTaluks(districtCode);
  }

  // ==========================================================
  // LOAD TALUKS
  // ==========================================================

  Future<void> loadTaluks(
    String districtCode,
  ) async {
    if (districtCode.isEmpty) {
      return;
    }

    try {
      isLoadingTaluks.value = true;

      debugPrint(
        'LOADING TALUKS FOR DISTRICT: $districtCode',
      );

      final result =
          await apiService.getTaluks(districtCode);

      debugPrint(
        'TALUKS RESPONSE: $result',
      );

      taluks.assignAll(result);

      debugPrint(
        'TALUKS COUNT: ${taluks.length}',
      );
    } catch (e) {
      debugPrint(
        'LOAD TALUKS ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to load taluks.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingTaluks.value = false;
    }
  }

  // ==========================================================
  // TALUK SELECTED
  // ==========================================================

  void onTalukSelected(
    Map<String, dynamic>? taluk,
  ) {
    selectedTaluk.value = taluk;
    passwordVerified.value = false;
    usedGoogleTestPassword.value = false;
    districtTalukPasswordController.clear();
    resetOtpState();

    if (taluk == null) {
      return;
    }

    debugPrint(
      'SELECTED TALUK: ${taluk['Name']}',
    );

    debugPrint(
      'TALUK CODE: ${taluk['Code']}',
    );
  }

  // ==========================================================
  // SEND OTP
  // ==========================================================

  Future<void> sendOtp() async {
    final mobileNumber =
        mobileController.text.trim();

    // --------------------------------------------------------
    // MOBILE VALIDATION
    // --------------------------------------------------------

    if (mobileNumber.length != 10) {
      Get.snackbar(
        'Invalid Mobile Number',
        'Please enter a valid 10-digit mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (usedGoogleTestPassword.value && mobileNumber != googleTestMobile) {
      Get.snackbar(
        'Test Account Only',
        'Password 1234 is reserved for the Google test account 9999999999.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // --------------------------------------------------------
    // DISTRICT VALIDATION
    // --------------------------------------------------------

    if (selectedDistrict.value == null) {
      Get.snackbar(
        'Select District',
        'Please select a district.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // --------------------------------------------------------
    // TALUK VALIDATION
    // --------------------------------------------------------

    if (selectedTaluk.value == null) {
      Get.snackbar(
        'Select Taluk',
        'Please select a taluk.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // Google Play review/test account: no SMS can be delivered to the
    // reserved test number, so use the documented fixed test OTP.
    if (mobileNumber == googleTestMobile) {
      receivedOtp = '1234';
      otpSent.value = true;
      enteredOtp.value = '';
      otpController.clear();
      isOtpObscured.value = true;
      startResendTimer();
      Get.snackbar(
        'Test OTP Ready',
        'For the Google test account, enter OTP 1234.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      debugPrint(
        'SENDING OTP TO: $mobileNumber',
      );

      final response =
          await apiService.sendOtp(mobileNumber);

      debugPrint(
        'OTP RESPONSE: $response',
      );

      // ------------------------------------------------------
      // EXTRACT OTP
      // ------------------------------------------------------

      receivedOtp = _extractOtp(response);

      debugPrint(
        'RECEIVED OTP: $receivedOtp',
      );

      if (receivedOtp.isEmpty) {
        Get.snackbar(
          'OTP Error',
          'OTP was not received from the server.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      otpSent.value = true;

      enteredOtp.value = '';

      otpController.clear();

      isOtpObscured.value = true;

      startResendTimer();

      Get.snackbar(
        'OTP Sent',
        'OTP has been sent to your mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(
        'SEND OTP ERROR: $e',
      );

      Get.snackbar(
        'OTP Error',
        'Unable to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // EXTRACT OTP
  // ==========================================================

  String _extractOtp(
    Map<String, dynamic> response,
  ) {
    debugPrint(
      'OTP API MAP: $response',
    );

    // Common possible OTP field names.
    const keys = [
      'OTP',
      'Otp',
      'otp',
      'OTPCode',
      'OtpCode',
      'otpCode',
      'OTPNumber',
      'OtpNumber',
      'otpNumber',
    ];

    for (final key in keys) {
      final value = response[key];

      if (value != null) {
        final text = value.toString().trim();

        if (text.isNotEmpty) {
          return text;
        }
      }
    }

    // --------------------------------------------------------
    // NESTED DATA
    // --------------------------------------------------------

    final data = response['data'];

    if (data is Map) {
      for (final key in keys) {
        final value = data[key];

        if (value != null) {
          final text = value.toString().trim();

          if (text.isNotEmpty) {
            return text;
          }
        }
      }
    }

    // --------------------------------------------------------
    // NESTED RESULT
    // --------------------------------------------------------

    final result = response['result'];

    if (result is Map) {
      for (final key in keys) {
        final value = result[key];

        if (value != null) {
          final text = value.toString().trim();

          if (text.isNotEmpty) {
            return text;
          }
        }
      }
    }

    return '';
  }

  // ==========================================================
  // OTP TIMER
  // ==========================================================

  void startResendTimer() {
    _resendTimer?.cancel();

    resendSeconds.value = 30;

    _resendTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (resendSeconds.value <= 1) {
          resendSeconds.value = 0;

          timer.cancel();
        } else {
          resendSeconds.value--;
        }
      },
    );
  }

  // ==========================================================
  // RESEND OTP
  // ==========================================================

  Future<void> resendOtp() async {
    if (resendSeconds.value > 0) {
      return;
    }

    await sendOtp();
  }

  // ==========================================================
  // OTP CHANGED
  // ==========================================================

  void onOtpChanged(
    String value,
  ) {
    var otp = value;

    if (otp.length > 4) {
      otp = otp.substring(0, 4);

      otpController.text = otp;

      otpController.selection =
          TextSelection.fromPosition(
        TextPosition(
          offset: otp.length,
        ),
      );
    }

    enteredOtp.value = otp;
  }

  // ==========================================================
  // OTP VISIBILITY
  // ==========================================================

  void toggleOtpVisibility() {
    isOtpObscured.value =
        !isOtpObscured.value;
  }

  // ==========================================================
  // OTP VALIDATION
  // ==========================================================

  bool get isOtpValid {
    return enteredOtp.value.length == 4 &&
        RegExp(
          r'^[0-9]{4}$',
        ).hasMatch(
          enteredOtp.value,
        );
  }

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login() async {
    final mobileNumber =
        mobileController.text.trim();

    // --------------------------------------------------------
    // VALIDATE MOBILE
    // --------------------------------------------------------

    if (mobileNumber.length != 10) {
      Get.snackbar(
        'Invalid Mobile Number',
        'Please enter a valid 10-digit mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // --------------------------------------------------------
    // VALIDATE DISTRICT
    // --------------------------------------------------------

    if (selectedDistrict.value == null) {
      Get.snackbar(
        'Select District',
        'Please select a district.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // --------------------------------------------------------
    // VALIDATE TALUK
    // --------------------------------------------------------

    if (selectedTaluk.value == null) {
      Get.snackbar(
        'Select Taluk',
        'Please select a taluk.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // --------------------------------------------------------
    // VALIDATE OTP
    // --------------------------------------------------------

    if (!otpSent.value) {
      Get.snackbar(
        'OTP Required',
        'Please send OTP first.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (!isOtpValid) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the 4-digit OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    try {
      isVerifyingOtp.value = true;

      debugPrint(
        'ENTERED OTP: ${enteredOtp.value}',
      );

      debugPrint(
        'SERVER OTP: $receivedOtp',
      );

      // ------------------------------------------------------
      // VERIFY OTP
      // ------------------------------------------------------

      if (enteredOtp.value.trim() !=
          receivedOtp.trim()) {
        Get.snackbar(
          'Invalid OTP',
          'The OTP entered is incorrect.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      debugPrint(
        'OTP VERIFIED SUCCESSFULLY',
      );

      // ------------------------------------------------------
      // GET SELECTED VALUES
      // ------------------------------------------------------

      final mobile = mobileNumber;

      final district =
          districtName;

      final districtCodeValue =
          districtCode;

      final taluk =
          talukName;

      final talukCodeValue =
          talukCode;

      debugPrint(
        'LOGIN MOBILE: $mobile',
      );

      debugPrint(
        'LOGIN DISTRICT: $district',
      );

      debugPrint(
        'LOGIN DISTRICT CODE: $districtCodeValue',
      );

      debugPrint(
        'LOGIN TALUK: $taluk',
      );

      debugPrint(
        'LOGIN TALUK CODE: $talukCodeValue',
      );

      // ------------------------------------------------------
      // SAVE SESSION
      // ------------------------------------------------------

      await AppSession.saveLoginCredentials(
        mobileNumber: mobile,
        districtName: district,
        districtCode: districtCodeValue,
        talukName: taluk,
        talukCode: talukCodeValue,
      );

      debugPrint(
        'LOGIN SESSION SAVED',
      );

      // ------------------------------------------------------
      // DASHBOARD ARGUMENTS
      // ------------------------------------------------------

      final loginData = {
        'mobileNumber': mobile,
        'districtName': district,
        'districtCode': districtCodeValue,
        'talukName': taluk,
        'talukCode': talukCodeValue,
      };

      // ------------------------------------------------------
      // DASHBOARD
      // ------------------------------------------------------

      Get.offAllNamed(
        AppRoutes.dashboard,
        arguments: loginData,
      );
    } catch (e) {
      debugPrint(
        'LOGIN ERROR: $e',
      );

      Get.snackbar(
        'Login Failed',
        'Unable to complete login. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  // ==========================================================
  // CHANGE MOBILE
  // ==========================================================

  void changeMobile() {
    otpSent.value = false;

    receivedOtp = '';

    enteredOtp.value = '';

    otpController.clear();

    isOtpObscured.value = true;

    resendSeconds.value = 0;

    _resendTimer?.cancel();
  }

  // ==========================================================
  // RESET OTP STATE
  // ==========================================================

  void resetOtpState() {
    otpSent.value = false;

    receivedOtp = '';

    enteredOtp.value = '';

    otpController.clear();

    isOtpObscured.value = true;

    resendSeconds.value = 0;

    _resendTimer?.cancel();
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout() async {
    await AppSession.clearLoginCredentials();

    debugPrint(
      'LOGIN SESSION CLEARED',
    );

    Get.offAllNamed(
      AppRoutes.login,
    );
  }

  // ==========================================================
  // CLOSE
  // ==========================================================

  @override
  void onClose() {
    _resendTimer?.cancel();

    mobileController.dispose();

    otpController.dispose();
    districtTalukPasswordController.dispose();

    super.onClose();
  }
}





