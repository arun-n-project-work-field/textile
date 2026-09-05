import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../services/api_service.dart';

class SplashController extends GetxController {
  final ApiService apiService = ApiService();

  // ==========================================================
  // VERSION CHECK LOADING STATUS
  // ==========================================================

  final isCheckingVersion = true.obs;

  // ==========================================================
  // PREVENT MULTIPLE VERSION CHECKS
  // ==========================================================

  bool _versionCheckCompleted = false;

  // ==========================================================
  // CONTROLLER READY
  // ==========================================================

  @override
  void onReady() {
    super.onReady();

    checkVersion();
  }

  // ==========================================================
  // CHECK APPLICATION VERSION
  // ==========================================================

  Future<void> checkVersion() async {
    // Prevent this method from running more than once.
    if (_versionCheckCompleted) {
      return;
    }

    try {
      isCheckingVersion.value = true;

      // ======================================================
      // GET INSTALLED APP VERSION
      // ======================================================

      final packageInfo =
          await PackageInfo.fromPlatform();

      final installedVersion =
          packageInfo.version;

      debugPrint(
        'INSTALLED APP VERSION: $installedVersion',
      );

      // ======================================================
      // CALL VERSION API
      // ======================================================

      final response =
          await apiService.checkAppVersion();

      debugPrint(
        'VERSION API DATA: $response',
      );

      // ======================================================
      // GET CURRENT VERSION FROM API
      // ======================================================

      final String? apiVersion =
          response['CurrentVersion']?.toString();

      if (apiVersion == null ||
          apiVersion.isEmpty) {
        throw Exception(
          'CurrentVersion not found in API response',
        );
      }

      debugPrint(
        'API CURRENT VERSION: $apiVersion',
      );

      // ======================================================
      // COMPARE VERSIONS
      // ======================================================

      final bool updateRequired =
          isVersionLower(
        installedVersion,
        apiVersion,
      );

      debugPrint(
        'UPDATE REQUIRED: $updateRequired',
      );

      // ======================================================
      // STOP LOADING
      // ======================================================

      isCheckingVersion.value = false;

      // ======================================================
      // UPDATE REQUIRED
      // ======================================================

      if (updateRequired) {
        _versionCheckCompleted = true;

        debugPrint(
          'APP UPDATE REQUIRED',
        );

        // Small delay so the splash screen is completely
        // rendered before the dialog appears.
        await Future.delayed(
          const Duration(milliseconds: 300),
        );

        // ====================================================
        // SHOW DIALOG ON TOP OF SPLASH SCREEN
        // ====================================================

        if (Get.context != null) {
          await Get.dialog(
            WillPopScope(
              onWillPop: () async {
                // Prevent Android back button from closing
                // the update dialog.
                return false;
              },

              child: AlertDialog(
                title: const Text(
                  'Update Required',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                content: const Text(
                  'Please update the app to proceed further.\n\n'
                  'Close and reopen the app after you update it from the Google Play Store',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                contentPadding:
                    const EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  24,
                ),

                titlePadding:
                    const EdgeInsets.fromLTRB(
                  24,
                  24,
                  24,
                  0,
                ),
              ),
            ),

            // ==================================================
            // IMPORTANT
            // ==================================================
            // The splash screen remains behind the dialog.
            //
            // Colors.black54 creates the dark transparent
            // overlay while keeping the splash image visible.
            // ==================================================

            barrierDismissible: false,

            barrierColor: Colors.black54,
          );
        }

        // ====================================================
        // DO NOT NAVIGATE
        // ====================================================

        return;
      }

      // ======================================================
      // VERSION IS VALID
      // ======================================================

      _versionCheckCompleted = true;

      await goToNextScreen();

    } catch (e) {
      // ======================================================
      // VERSION API ERROR
      // ======================================================

      debugPrint(
        'Version API error: $e',
      );

      isCheckingVersion.value = false;

      _versionCheckCompleted = true;

      // ======================================================
      // OFFLINE MODE
      // ======================================================

      debugPrint(
        'Continuing application in offline mode.',
      );

      await goToNextScreen();
    }
  }

  // ==========================================================
  // VERSION COMPARISON
  // ==========================================================

  bool isVersionLower(
    String installed,
    String current,
  ) {
    final installedParts = installed
        .split('.')
        .map(
          (e) => int.tryParse(e) ?? 0,
        )
        .toList();

    final currentParts = current
        .split('.')
        .map(
          (e) => int.tryParse(e) ?? 0,
        )
        .toList();

    // ========================================================
    // MAKE BOTH VERSION LISTS THE SAME LENGTH
    // ========================================================

    final int length =
        installedParts.length >
                currentParts.length
            ? installedParts.length
            : currentParts.length;

    // ========================================================
    // COMPARE EACH VERSION PART
    // ========================================================

    for (int i = 0; i < length; i++) {
      final int installedValue =
          i < installedParts.length
              ? installedParts[i]
              : 0;

      final int currentValue =
          i < currentParts.length
              ? currentParts[i]
              : 0;

      // Installed version is older.
      if (installedValue < currentValue) {
        return true;
      }

      // Installed version is newer.
      if (installedValue > currentValue) {
        return false;
      }
    }

    // Versions are equal.
    return false;
  }

  // ==========================================================
  // GO TO NEXT SCREEN
  // ==========================================================

  Future<void> goToNextScreen() async {
    // ========================================================
    // KEEP YOUR ACTUAL LOGIN STATUS LOGIC HERE
    // ========================================================

    final loginStatus = false;

    debugPrint(
      'LOGIN STATUS: $loginStatus',
    );

    if (loginStatus) {
      Get.offNamed('/dashboard');
    } else {
      Get.offNamed('/login');
    }
  }
}