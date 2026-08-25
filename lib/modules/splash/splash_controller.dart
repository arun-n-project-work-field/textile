// import 'package:get/get.dart';

// import '../../routes/app_routes.dart';

// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();

//     Future.delayed(const Duration(seconds: 3), () {
//       Get.offAllNamed(AppRoutes.login);
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/pref_service.dart';
import '../../routes/app_routes.dart';
import '../../services/api_service.dart';

class SplashController extends GetxController {

  // ==========================================================
  // API
  // ==========================================================

  final ApiService apiService = ApiService();

  // ==========================================================
  // STATE
  // ==========================================================

  final RxBool isCheckingVersion = true.obs;

  final RxString statusMessage =
      'Checking application version...'.obs;

  // ==========================================================
  // CURRENT APP VERSION
  // ==========================================================

  static const String currentAppVersion = 'v1.0';

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    _initializeApp();
  }

  // ==========================================================
  // INITIALIZE APP
  // ==========================================================

  Future<void> _initializeApp() async {
    try {

      // --------------------------------------------------------
      // Keep splash visible for at least 3 seconds
      // --------------------------------------------------------

      final minimumSplashTime = Future.delayed(
        const Duration(seconds: 3),
      );

      // --------------------------------------------------------
      // Version check
      // --------------------------------------------------------

      await _checkVersion();

      // --------------------------------------------------------
      // Wait for minimum splash duration
      // --------------------------------------------------------

      await minimumSplashTime;

    } catch (e) {

      debugPrint(
        'Splash initialization error: $e',
      );

      // Still wait so the splash does not disappear immediately
      await Future.delayed(
        const Duration(seconds: 3),
      );
    }

    // ----------------------------------------------------------
    // Stop loading
    // ----------------------------------------------------------

    isCheckingVersion.value = false;

    // ----------------------------------------------------------
    // Navigate
    // ----------------------------------------------------------

    _navigateToNextScreen();
  }

  // ==========================================================
  // VERSION CHECK
  // ==========================================================

  Future<void> _checkVersion() async {

    try {

      statusMessage.value =
          'Checking application version...';

      final response =
          await apiService.checkAppVersion();

      debugPrint(
        'VERSION API RESPONSE: $response',
      );

      // --------------------------------------------------------
      // Handle API response
      // --------------------------------------------------------

      final bool success =
          _isVersionValid(response);

      if (!success) {

        debugPrint(
          'Version check failed or update may be required.',
        );

        // ------------------------------------------------------
        // IMPORTANT:
        //
        // Until the exact backend response structure is
        // confirmed, we do not block the application.
        //
        // Later we can enforce mandatory update here.
        // ------------------------------------------------------

      } else {

        debugPrint(
          'Version check successful.',
        );
      }

    } catch (e) {

      debugPrint(
        'Version API error: $e',
      );

      // --------------------------------------------------------
      // Offline-first behavior:
      //
      // If version API cannot be reached, allow the user
      // to continue using the application.
      // --------------------------------------------------------

      debugPrint(
        'Continuing application in offline mode.',
      );
    }
  }

  // ==========================================================
  // VERSION RESPONSE HANDLER
  // ==========================================================

  bool _isVersionValid(
    Map<String, dynamic> response,
  ) {

    // ----------------------------------------------------------
    // Different APIs may return different response formats.
    // This currently supports common formats.
    // ----------------------------------------------------------

    if (response.isEmpty) {
      return false;
    }

    // Example:
    // {
    //   "status": true
    // }

    if (response['status'] == false) {
      return false;
    }

    // If status is true or not supplied,
    // allow application to continue.

    return true;
  }

  // ==========================================================
  // NAVIGATION
  // ==========================================================

  void _navigateToNextScreen() {

    final bool loggedIn =
        PrefService.isLoggedIn;

    debugPrint(
      'LOGIN STATUS: $loggedIn',
    );

    if (loggedIn) {

      // --------------------------------------------------------
      // USER ALREADY LOGGED IN
      // --------------------------------------------------------

      Get.offAllNamed(
        AppRoutes.dashboard,
      );

    } else {

      // --------------------------------------------------------
      // FIRST TIME / LOGGED OUT
      // --------------------------------------------------------

      Get.offAllNamed(
        AppRoutes.login,
      );
    }
  }
}