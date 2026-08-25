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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../core/services/pref_service.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final mobileController =
      TextEditingController();

  final otpController =
      TextEditingController();

  // ==========================================================
  // SERVICE
  // ==========================================================

  final ApiService apiService =
      ApiService();

  // ==========================================================
  // STATE
  // ==========================================================

  final RxBool isLoading =
      false.obs;

  final RxBool otpSent =
      false.obs;

  final RxBool obscureOtp =
      true.obs;

  // ==========================================================
  // SEND OTP
  // ==========================================================

  Future<void> sendOtp() async {

    final mobile =
        mobileController.text.trim();

    if (mobile.isEmpty) {

      Get.snackbar(
        'Validation',
        'Enter mobile number',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    if (mobile.length != 10) {

      Get.snackbar(
        'Validation',
        'Enter a valid 10 digit mobile number',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    try {

      isLoading.value = true;

      final response =
          await apiService.sendOtp(
        mobile,
      );

      debugPrint(
        'OTP RESPONSE: $response',
      );

      if (response['status'] == true) {

        otpSent.value = true;

        Get.snackbar(
          'Success',
          response['message'] ??
              'OTP sent successfully',
          snackPosition:
              SnackPosition.BOTTOM,
        );

      } else {

        Get.snackbar(
          'OTP Failed',
          response['message'] ??
              'Unable to send OTP',
          snackPosition:
              SnackPosition.BOTTOM,
        );
      }

    } catch (e) {

      debugPrint(
        'OTP ERROR: $e',
      );

      Get.snackbar(
        'Error',
        'Unable to send OTP. Please try again.',
        snackPosition:
            SnackPosition.BOTTOM,
      );

    } finally {

      isLoading.value = false;
    }
  }

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login() async {

    final otp =
        otpController.text.trim();

    if (!otpSent.value) {

      Get.snackbar(
        'Validation',
        'Please request OTP first',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    if (otp.isEmpty) {

      Get.snackbar(
        'Validation',
        'Enter OTP',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    if (otp.length != 4) {

      Get.snackbar(
        'Validation',
        'Enter a valid 4 digit OTP',
        snackPosition:
            SnackPosition.BOTTOM,
      );

      return;
    }

    try {

      isLoading.value = true;

      // ======================================================
      // IMPORTANT
      // ======================================================
      //
      // You have currently provided ONLY the OTP sending API.
      //
      // There is no OTP verification API yet.
      //
      // Therefore this is temporarily accepting the entered OTP.
      //
      // Once backend provides the OTP verification API,
      // replace this section with the actual API call.
      // ======================================================

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      // ------------------------------------------------------
      // SAVE LOGIN STATE
      // ------------------------------------------------------

      await PrefService.setLoggedIn(
        true,
      );

      // ------------------------------------------------------
      // GO TO DASHBOARD
      // ------------------------------------------------------

      Get.offAllNamed(
        AppRoutes.dashboard,
      );

    } catch (e) {

      Get.snackbar(
        'Login Failed',
        'Unable to login',
        snackPosition:
            SnackPosition.BOTTOM,
      );

    } finally {

      isLoading.value = false;
    }
  }

  // ==========================================================
  // OTP VISIBILITY
  // ==========================================================

  void toggleOtpVisibility() {

    obscureOtp.value =
        !obscureOtp.value;
  }

  // ==========================================================
  // CHANGE MOBILE
  // ==========================================================

  void changeMobile() {

    otpSent.value = false;

    otpController.clear();
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout() async {

    await PrefService.logout();

    Get.offAllNamed(
      AppRoutes.login,
    );
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void onClose() {

    mobileController.dispose();

    otpController.dispose();

    super.onClose();
  }
}