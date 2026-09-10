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


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/api_service.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();

  // ============================================================
  // TEXT CONTROLLERS
  // ============================================================

  final mobileController = TextEditingController();
  final otpController = TextEditingController();

  // ============================================================
  // DISTRICT / TALUK
  // ============================================================

  final districts = <Map<String, dynamic>>[].obs;
  final taluks = <Map<String, dynamic>>[].obs;

  final selectedDistrict = Rxn<Map<String, dynamic>>();
  final selectedTaluk = Rxn<Map<String, dynamic>>();

  final isLoadingDistricts = false.obs;
  final isLoadingTaluks = false.obs;

  // ============================================================
  // OTP
  // ============================================================

  final otpSent = false.obs;

  final apiOtp = ''.obs;
  final enteredOtp = ''.obs;

  final isLoading = false.obs;
  final isVerifyingOtp = false.obs;

  final isOtpObscured = true.obs;

  // ============================================================
  // RESEND TIMER
  // ============================================================

  final resendSeconds = 0.obs;

  Timer? _resendTimer;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();

    loadDistricts();
  }

  // ============================================================
  // GET DISTRICTS
  // ============================================================

  Future<void> loadDistricts() async {
    try {
      isLoadingDistricts.value = true;

      final response = await apiService.getDistricts();

      districts.assignAll(response);

      debugPrint('DISTRICTS COUNT: ${districts.length}');
      debugPrint('DISTRICTS: $districts');
    } catch (e) {
      debugPrint('LOAD DISTRICTS ERROR: $e');

      Get.snackbar(
        'Error',
        'Unable to load districts.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  // ============================================================
  // DISTRICT SELECTED
  // ============================================================

  Future<void> onDistrictSelected(
    Map<String, dynamic>? district,
  ) async {
    if (district == null) {
      return;
    }

    selectedDistrict.value = district;

    // Clear previous taluk
    selectedTaluk.value = null;
    taluks.clear();

    // Reset OTP state
    resetOtpState();

    final districtCode =
        district['Code']?.toString().trim() ?? '';

    debugPrint(
      'SELECTED DISTRICT: ${district['Name']}',
    );

    debugPrint(
      'DISTRICT CODE: $districtCode',
    );

    if (districtCode.isEmpty) {
      debugPrint('ERROR: District Code is empty');
      return;
    }

    await loadTaluks(districtCode);
  }

  // ============================================================
  // GET TALUKS
  // ============================================================

  Future<void> loadTaluks(String districtCode) async {
    try {
      isLoadingTaluks.value = true;

      final response =
          await apiService.getTaluks(districtCode);

      taluks.assignAll(response);

      debugPrint('TALUKS COUNT: ${taluks.length}');
      debugPrint('TALUKS: $taluks');
    } catch (e) {
      debugPrint('LOAD TALUKS ERROR: $e');

      Get.snackbar(
        'Error',
        'Unable to load taluks.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingTaluks.value = false;
    }
  }

  // ============================================================
  // TALUK SELECTED
  // ============================================================

  void onTalukSelected(
    Map<String, dynamic>? taluk,
  ) {
    if (taluk == null) {
      return;
    }

    selectedTaluk.value = taluk;

    debugPrint(
      'SELECTED TALUK: ${taluk['Name']}',
    );

    debugPrint(
      'TALUK CODE: ${taluk['Code']}',
    );

    // Reset OTP whenever taluk changes
    resetOtpState();
  }

  // ============================================================
  // SEND OTP
  // ============================================================

  Future<void> sendOtp() async {
    final mobile = mobileController.text.trim();

    /*
     * IMPORTANT:
     *
     * Send OTP button does NOT have to become active only
     * after entering exactly 10 digits.
     *
     * Validation remains here when the user presses the button.
     */

    if (mobile.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response =
          await apiService.sendOtp(mobile);

      debugPrint(
        'SEND OTP RESPONSE: $response',
      );

      // --------------------------------------------------------
      // API SERVICE returns Map<String, dynamic>
      // --------------------------------------------------------

      String otp = '';

      otp =
          response['OTP']?.toString() ??
          response['Otp']?.toString() ??
          response['otp']?.toString() ??
          '';

      debugPrint('API OTP: $otp');

      if (otp.isEmpty) {
        Get.snackbar(
          'Error',
          'OTP was not received from the server.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Store API OTP
      apiOtp.value = otp;

      // Show OTP section
      otpSent.value = true;

      // Clear previously entered OTP
      enteredOtp.value = '';
      otpController.clear();

      // Start 30 second resend timer
      startResendTimer();

      Get.snackbar(
        'Success',
        'OTP sent successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(
        'SEND OTP ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // START RESEND TIMER
  // ============================================================

  void startResendTimer() {
    _resendTimer?.cancel();

    resendSeconds.value = 30;

    _resendTimer =
        Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (resendSeconds.value > 0) {
          resendSeconds.value--;
        } else {
          timer.cancel();
        }
      },
    );
  }

  // ============================================================
  // OTP TEXT CHANGE
  // ============================================================

  void onOtpChanged(String value) {
    // Keep only numbers
    String cleanedValue =
        value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    // Maximum 4 digits
    if (cleanedValue.length > 4) {
      cleanedValue =
          cleanedValue.substring(0, 4);
    }

    enteredOtp.value = cleanedValue;

    // Keep TextEditingController synchronized
    if (otpController.text != cleanedValue) {
      otpController.value =
          TextEditingValue(
        text: cleanedValue,
        selection:
            TextSelection.collapsed(
          offset: cleanedValue.length,
        ),
      );
    }

    debugPrint(
      'ENTERED OTP: ${enteredOtp.value}',
    );
  }

  // ============================================================
  // OTP VALIDATION
  // ============================================================

  bool get isOtpValid {
    return enteredOtp.value.length == 4 &&
        RegExp(r'^[0-9]{4}$')
            .hasMatch(enteredOtp.value);
  }

  // ============================================================
  // LOGIN / VERIFY OTP
  // ============================================================

  Future<void> login() async {
    if (!isOtpValid) {
      Get.snackbar(
        'Error',
        'Please enter a valid 4 digit OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isVerifyingOtp.value = true;

      final entered = enteredOtp.value;
      final apiOtpValue = apiOtp.value;

      debugPrint(
        'ENTERED OTP: $entered',
      );

      debugPrint(
        'API OTP: $apiOtpValue',
      );

      // --------------------------------------------------------
      // Compare entered OTP with API OTP
      // --------------------------------------------------------

      if (entered == apiOtpValue) {
        debugPrint(
          'OTP VERIFIED SUCCESSFULLY',
        );

        // ------------------------------------------------------
        // GET LOGIN DETAILS
        // ------------------------------------------------------

        final mobileNumber =
            mobileController.text.trim();

        final districtName =
            selectedDistrict.value?['Name']
                    ?.toString() ??
                '';

        final talukName =
            selectedTaluk.value?['Name']
                    ?.toString() ??
                '';

        debugPrint(
          'LOGIN MOBILE: $mobileNumber',
        );

        debugPrint(
          'LOGIN DISTRICT: $districtName',
        );

        debugPrint(
          'LOGIN TALUK: $talukName',
        );

        // ------------------------------------------------------
        // NAVIGATE TO DASHBOARD
        //
        // Pass the login details through Get.arguments.
        // ------------------------------------------------------

        await Get.offAllNamed(
          AppRoutes.dashboard,
          arguments: {
            'mobileNumber': mobileNumber,
            'districtName': districtName,
            'talukName': talukName,
          },
        );
      } else {
        debugPrint(
          'OTP VERIFICATION FAILED',
        );

        Get.snackbar(
          'Invalid OTP',
          'Please enter the correct OTP.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint(
        'OTP verification error: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to verify OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isVerifyingOtp.value = false;
    }
  }

  // ============================================================
  // CHANGE MOBILE NUMBER
  // ============================================================

  void changeMobile() {
    resetOtpState();

    mobileController.clear();

    debugPrint(
      'Mobile number changed',
    );
  }

  // ============================================================
  // TOGGLE OTP VISIBILITY
  // ============================================================

  void toggleOtpVisibility() {
    isOtpObscured.value =
        !isOtpObscured.value;
  }

  // ============================================================
  // RESET OTP STATE
  // ============================================================

  void resetOtpState() {
    otpSent.value = false;

    apiOtp.value = '';
    enteredOtp.value = '';

    otpController.clear();

    resendSeconds.value = 0;

    _resendTimer?.cancel();
    _resendTimer = null;
  }

  // ============================================================
  // CLEANUP
  // ============================================================

  @override
  void onClose() {
    _resendTimer?.cancel();

    mobileController.dispose();
    otpController.dispose();

    super.onClose();
  }
}

