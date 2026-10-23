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

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController districtTalukPasswordController =
      TextEditingController();

  final RxBool passwordVerified = false.obs;
  final RxBool isPasswordObscured = true.obs;

  /// The only valid district/taluk password.
  static const String surveyPassword = 'Nmkg@1234';

  /// Reserved Google Play review/test account.
  static const String googleTestMobile = '9999999999';

  /// Fixed OTP for the reserved test account.
  static const String googleTestOtp = '1234';

  // ==========================================================
  // PASSWORD VERIFICATION
  // ==========================================================

  void verifyDistrictTalukPassword() {
    if (selectedDistrict.value == null || districtCode.isEmpty) {
      Get.snackbar(
        'Select District',
        'Please select a district from the dropdown first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedTaluk.value == null || talukCode.isEmpty) {
      Get.snackbar(
        'Select Taluk',
        'Please select a taluk from the dropdown first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final value = districtTalukPasswordController.text;

    if (value == surveyPassword) {
      passwordVerified.value = true;

      Get.snackbar(
        'Password Verified',
        'Password verified. You can continue with your mobile number and OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      passwordVerified.value = false;

      Get.dialog<void>(
        AlertDialog(
          title: const Text('Incorrect Password'),
          content: const Text('Please enter the correct password.'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('OK')),
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

  final RxList<Map<String, dynamic>> districts = <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedDistrict =
      Rxn<Map<String, dynamic>>();

  final RxBool isLoadingDistricts = false.obs;

  final RxString districtError = ''.obs;

  bool _districtRequestInProgress = false;

  // ==========================================================
  // TALUKS
  // ==========================================================

  final RxList<Map<String, dynamic>> taluks = <Map<String, dynamic>>[].obs;

  final Rxn<Map<String, dynamic>> selectedTaluk = Rxn<Map<String, dynamic>>();

  final RxBool isLoadingTaluks = false.obs;

  final RxString talukError = ''.obs;

  int _talukRequestId = 0;

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
    return selectedDistrict.value?['Name']?.toString().trim() ?? '';
  }

  // ==========================================================
  // DISTRICT CODE
  // ==========================================================

  String get districtCode {
    return selectedDistrict.value?['Code']?.toString().trim() ?? '';
  }

  // ==========================================================
  // TALUK NAME
  // ==========================================================

  String get talukName {
    return selectedTaluk.value?['Name']?.toString().trim() ?? '';
  }

  // ==========================================================
  // TALUK CODE
  // ==========================================================

  String get talukCode {
    return selectedTaluk.value?['Code']?.toString().trim() ?? '';
  }

  // ==========================================================
  // LOAD DISTRICTS
  // ==========================================================

  Future<void> loadDistricts({bool manualRefresh = false}) async {
    if (_districtRequestInProgress) return;

    // On manual refresh, clear the previous selections first.
    if (manualRefresh) {
      selectedDistrict.value = null;
      selectedTaluk.value = null;

      taluks.clear();
      talukError.value = '';

      passwordVerified.value = false;
      districtTalukPasswordController.clear();

      resetOtpState();

      // Invalidate any pending taluk request.
      _talukRequestId++;
      isLoadingTaluks.value = false;
    }

    _districtRequestInProgress = true;
    isLoadingDistricts.value = true;
    districtError.value = '';

    try {
      List<Map<String, dynamic>>? result;
      Object? lastError;

      for (int attempt = 1; attempt <= 2; attempt++) {
        try {
          debugPrint('LOADING DISTRICTS (attempt $attempt/2)...');

          final response = await apiService.getDistricts();

          debugPrint('DISTRICTS RESPONSE: $response');

          if (response.isEmpty) {
            throw Exception('The district API returned an empty list.');
          }

          result = response;
          break;
        } catch (e) {
          lastError = e;
          debugPrint('DISTRICT REQUEST ATTEMPT $attempt FAILED: $e');

          if (attempt < 2) {
            await Future<void>.delayed(const Duration(seconds: 1));
          }
        }
      }

      if (result == null) {
        throw Exception(lastError ?? 'District request failed.');
      }

      districts.assignAll(result);
      districtError.value = '';

      debugPrint('DISTRICTS COUNT: ${districts.length}');

      if (manualRefresh) {
        Get.snackbar(
          'Districts Refreshed',
          'District list loaded successfully. Please select a district and taluk again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('LOAD DISTRICTS ERROR: $e');

      districtError.value =
          'Unable to load districts. Check your connection and try again.';

      if (manualRefresh) {
        Get.snackbar(
          'Districts Unavailable',
          'Unable to load districts. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      _districtRequestInProgress = false;
      isLoadingDistricts.value = false;
    }
  }

  // ==========================================================
  // DISTRICT SELECTED
  // ==========================================================

  Future<void> onDistrictSelected(Map<String, dynamic>? district) async {
    selectedDistrict.value = district;

    selectedTaluk.value = null;

    // Changing district requires password verification again.
    passwordVerified.value = false;
    districtTalukPasswordController.clear();

    resetOtpState();

    taluks.clear();
    talukError.value = '';

    // Invalidate any pending request for the previous district.
    _talukRequestId++;
    isLoadingTaluks.value = false;

    if (district == null) return;

    debugPrint('SELECTED DISTRICT: ${district['Name']}');
    debugPrint('DISTRICT CODE: ${district['Code']}');

    final code = district['Code']?.toString().trim() ?? '';

    if (code.isEmpty) return;

    await loadTaluks(code);
  }

  // ==========================================================
  // LOAD TALUKS
  // ==========================================================

  Future<void> loadTaluks(
    String districtCode, {
    bool manualRefresh = false,
  }) async {
    final code = districtCode.trim();

    if (code.isEmpty) {
      talukError.value = 'A valid district is required to load taluks.';
      return;
    }

    // Only the newest request can update the UI.
    final int requestId = ++_talukRequestId;

    isLoadingTaluks.value = true;
    talukError.value = '';

    try {
      List<Map<String, dynamic>>? result;
      Object? lastError;

      // Retry once for intermittent network/server failures.
      for (int attempt = 1; attempt <= 2; attempt++) {
        try {
          debugPrint(
            'LOADING TALUKS FOR DISTRICT: $code '
            '(attempt $attempt/2)',
          );

          final response = await apiService.getTaluks(code);

          debugPrint('TALUKS RESPONSE: $response');

          if (response.isEmpty) {
            throw Exception('The taluk API returned an empty list.');
          }

          result = response;
          break;
        } catch (e) {
          lastError = e;

          debugPrint('TALUK REQUEST ATTEMPT $attempt FAILED: $e');

          if (attempt < 2) {
            await Future<void>.delayed(const Duration(seconds: 1));
          }
        }
      }

      // Ignore stale results after a district change.
      if (requestId != _talukRequestId || code != this.districtCode) {
        return;
      }

      if (result == null) {
        throw Exception(lastError ?? 'Taluk request failed.');
      }

      taluks.assignAll(result);
      talukError.value = '';

      debugPrint('TALUKS COUNT: ${taluks.length}');

      if (manualRefresh) {
        Get.snackbar(
          'Taluks Refreshed',
          'Taluk list loaded successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (requestId != _talukRequestId || code != this.districtCode) {
        return;
      }

      debugPrint('LOAD TALUKS ERROR: $e');

      talukError.value =
          'Unable to load taluks. Check your connection and try again.';

      if (manualRefresh) {
        Get.snackbar(
          'Taluks Unavailable',
          'Unable to load taluks. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (requestId == _talukRequestId) {
        isLoadingTaluks.value = false;
      }
    }
  }

  Future<void> refreshTaluks() async {
    final code = districtCode;

    if (selectedDistrict.value == null || code.isEmpty) {
      Get.snackbar(
        'Select District',
        'Please select a district first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    selectedTaluk.value = null;

    passwordVerified.value = false;
    districtTalukPasswordController.clear();

    resetOtpState();

    await loadTaluks(code, manualRefresh: true);
  }

  // ==========================================================
  // TALUK SELECTED
  // ==========================================================

  void onTalukSelected(Map<String, dynamic>? taluk) {
    selectedTaluk.value = taluk;

    // Changing taluk requires password verification again.
    passwordVerified.value = false;
    districtTalukPasswordController.clear();

    resetOtpState();

    if (taluk == null) return;

    debugPrint('SELECTED TALUK: ${taluk['Name']}');
    debugPrint('TALUK CODE: ${taluk['Code']}');
  }

  // ==========================================================
  // SEND OTP
  // ==========================================================

  Future<void> sendOtp() async {
    // Require password verification before proceeding.
    if (!passwordVerified.value) {
      Get.snackbar(
        'Password Required',
        'Please verify the district/taluk password first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final mobileNumber = mobileController.text.trim();

    // --------------------------------------------------------
    // MOBILE VALIDATION
    // --------------------------------------------------------

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      Get.snackbar(
        'Invalid Mobile Number',
        'Please enter a valid 10-digit mobile number.',
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

    // --------------------------------------------------------
    // TEST ACCOUNT OTP
    // --------------------------------------------------------

    // Only the reserved mobile number gets the fixed OTP.
    // No SMS API request is made for this account.
    if (mobileNumber == googleTestMobile) {
      receivedOtp = googleTestOtp;

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

    // --------------------------------------------------------
    // NORMAL OTP API
    // --------------------------------------------------------

    try {
      isLoading.value = true;

      debugPrint('SENDING OTP TO: $mobileNumber');

      final response = await apiService.sendOtp(mobileNumber);

      debugPrint('OTP RESPONSE: $response');

      receivedOtp = _extractOtp(response);

      // Do not log the actual OTP in production.
      debugPrint('OTP RECEIVED: ${receivedOtp.isNotEmpty ? "YES" : "NO"}');

      if (receivedOtp.isEmpty) {
        otpSent.value = false;

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
      debugPrint('SEND OTP ERROR: $e');

      otpSent.value = false;
      receivedOtp = '';

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

  String _extractOtp(Map<String, dynamic> response) {
    debugPrint('OTP API MAP: $response');

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

        if (text.isNotEmpty) return text;
      }
    }

    // Nested data response.
    final data = response['data'];

    if (data is Map) {
      for (final key in keys) {
        final value = data[key];

        if (value != null) {
          final text = value.toString().trim();

          if (text.isNotEmpty) return text;
        }
      }
    }

    // Nested result response.
    final result = response['result'];

    if (result is Map) {
      for (final key in keys) {
        final value = result[key];

        if (value != null) {
          final text = value.toString().trim();

          if (text.isNotEmpty) return text;
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

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value <= 1) {
        resendSeconds.value = 0;
        timer.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }

  // ==========================================================
  // RESEND OTP
  // ==========================================================

  Future<void> resendOtp() async {
    if (resendSeconds.value > 0) return;

    await sendOtp();
  }

  // ==========================================================
  // OTP CHANGED
  // ==========================================================

  void onOtpChanged(String value) {
    var otp = value;

    if (otp.length > 4) {
      otp = otp.substring(0, 4);

      otpController.value = TextEditingValue(
        text: otp,
        selection: TextSelection.collapsed(offset: otp.length),
      );
    }

    enteredOtp.value = otp;
  }

  // ==========================================================
  // OTP VISIBILITY
  // ==========================================================

  void toggleOtpVisibility() {
    isOtpObscured.value = !isOtpObscured.value;
  }

  // ==========================================================
  // OTP VALIDATION
  // ==========================================================

  bool get isOtpValid {
    return enteredOtp.value.length == 4 &&
        RegExp(r'^[0-9]{4}$').hasMatch(enteredOtp.value);
  }

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login() async {
    // --------------------------------------------------------
    // VALIDATE PASSWORD
    // --------------------------------------------------------

    if (!passwordVerified.value) {
      Get.snackbar(
        'Password Required',
        'Please verify the district/taluk password first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final mobileNumber = mobileController.text.trim();

    // --------------------------------------------------------
    // VALIDATE MOBILE
    // --------------------------------------------------------

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
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
    // VALIDATE OTP SENT
    // --------------------------------------------------------

    if (!otpSent.value) {
      Get.snackbar(
        'OTP Required',
        'Please send OTP first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // --------------------------------------------------------
    // VALIDATE OTP FORMAT
    // --------------------------------------------------------

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

      // ------------------------------------------------------
      // VERIFY OTP
      // ------------------------------------------------------

      if (enteredOtp.value.trim() != receivedOtp.trim()) {
        Get.snackbar(
          'Invalid OTP',
          'The OTP entered is incorrect.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      debugPrint('OTP VERIFIED SUCCESSFULLY');

      // ------------------------------------------------------
      // GET SELECTED VALUES
      // ------------------------------------------------------

      final mobile = mobileNumber;
      final district = districtName;
      final districtCodeValue = districtCode;
      final taluk = talukName;
      final talukCodeValue = talukCode;

      debugPrint('LOGIN MOBILE: $mobile');
      debugPrint('LOGIN DISTRICT: $district');
      debugPrint('LOGIN DISTRICT CODE: $districtCodeValue');
      debugPrint('LOGIN TALUK: $taluk');
      debugPrint('LOGIN TALUK CODE: $talukCodeValue');

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

      debugPrint('LOGIN SESSION SAVED');

      // ------------------------------------------------------
      // DASHBOARD ARGUMENTS
      // ------------------------------------------------------

      final loginData = <String, dynamic>{
        'mobileNumber': mobile,
        'districtName': district,
        'districtCode': districtCodeValue,
        'talukName': taluk,
        'talukCode': talukCodeValue,
      };

      // ------------------------------------------------------
      // DASHBOARD NAVIGATION
      // ------------------------------------------------------

      Get.offAllNamed(AppRoutes.dashboard, arguments: loginData);
    } catch (e) {
      debugPrint('LOGIN ERROR: $e');

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
    mobileController.clear();
    resetOtpState();
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
    _resendTimer = null;
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout() async {
    await AppSession.clearLoginCredentials();

    debugPrint('LOGIN SESSION CLEARED');

    Get.offAllNamed(AppRoutes.login);
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
