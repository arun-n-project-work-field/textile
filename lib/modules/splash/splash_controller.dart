import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/app_routes.dart';
import '../../services/api_service.dart';
import '../../services/app_session.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  final ApiService apiService = ApiService();

  final isCheckingVersion = true.obs;

  bool _startupStarted = false;
  bool _waitingForSettings = false;
  bool _permissionDialogOpen = false;

  @override
  void onReady() {
    super.onReady();

    if (!_startupStarted) {
      _startupStarted = true;
      checkVersion();
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  // Recheck permissions when the user returns from Android Settings.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForSettings) {
      _waitingForSettings = false;
      requestStartupPermissions();
    }
  }

  // ========================================================================
  // VERSION CHECK
  // ========================================================================

  Future<void> checkVersion() async {
    try {
      isCheckingVersion.value = true;

      final packageInfo = await PackageInfo.fromPlatform();
      final installedVersion = packageInfo.version;

      debugPrint('INSTALLED VERSION: $installedVersion');

      final response = await apiService.checkAppVersion();

      debugPrint('VERSION DATA: $response');

      final apiVersion = response['CurrentVersion']?.toString().trim();

      if (apiVersion == null || apiVersion.isEmpty) {
        throw Exception('appVersion not found');
      }

      debugPrint('SERVER VERSION: $apiVersion');

      final updateRequired = isVersionLower(installedVersion, apiVersion);

      isCheckingVersion.value = false;

      if (updateRequired) {
        await Future.delayed(const Duration(milliseconds: 300));

        if (Get.context != null) {
          await Get.dialog<void>(
            PopScope(
              canPop: false,
              child: AlertDialog(
                title: const Text(
                  'Update Required',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  'Please update the app to proceed further.\n\n'
                  'Close and reopen the app after updating it '
                  'from the Google Play Store.',
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            barrierDismissible: false,
            barrierColor: Colors.black54,
          );
        }

        // Do not request permissions or navigate if an update is required.
        return;
      }

      // Keep the Flutter splash visible while requesting permissions.
      await requestStartupPermissions();
    } catch (e, stackTrace) {
      debugPrint('VERSION CHECK ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      isCheckingVersion.value = false;

      // Preserve the existing offline-startup behavior.
      await requestStartupPermissions();
    }
  }

  // ========================================================================
  // VERSION COMPARISON
  // ========================================================================

  bool isVersionLower(String installed, String current) {
    final installedParts = installed
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    final currentParts = current
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    final length = installedParts.length > currentParts.length
        ? installedParts.length
        : currentParts.length;

    for (int i = 0; i < length; i++) {
      final installedValue = i < installedParts.length ? installedParts[i] : 0;

      final currentValue = i < currentParts.length ? currentParts[i] : 0;

      if (installedValue < currentValue) return true;
      if (installedValue > currentValue) return false;
    }

    return false;
  }

  // ========================================================================
  // STARTUP PERMISSIONS
  // ========================================================================

  Future<void> requestStartupPermissions() async {
    if (_permissionDialogOpen || _waitingForSettings) {
      return;
    }

    debugPrint('CHECKING STARTUP PERMISSIONS');

    // Request only permissions needed by your application.
    final permissions = <Permission>[
      Permission.locationWhenInUse,
      Permission.camera,
    ];

    try {
      while (true) {
        final permissionsToRequest = <Permission>[];

        for (final permission in permissions) {
          final status = await permission.status;

          debugPrint('$permission STATUS: $status');

          if (!status.isGranted) {
            permissionsToRequest.add(permission);
          }
        }

        // All required permissions have already been granted.
        if (permissionsToRequest.isEmpty) {
          debugPrint('STARTUP PERMISSIONS GRANTED');
          await goToNextScreen();
          return;
        }

        debugPrint('REQUESTING PERMISSIONS: $permissionsToRequest');

        final results = await permissionsToRequest.request();

        debugPrint('PERMISSION RESULTS: $results');

        final deniedPermissions = permissions.where((permission) {
          final status = results[permission];
          return status != null ? !status.isGranted : false;
        }).toList();

        // Recheck every permission because some may already have
        // been granted before this request.
        final remainingDenied = <Permission>[];

        for (final permission in permissions) {
          final status = await permission.status;

          if (!status.isGranted) {
            remainingDenied.add(permission);
          }
        }

        if (remainingDenied.isEmpty) {
          debugPrint('STARTUP PERMISSIONS GRANTED');
          await goToNextScreen();
          return;
        }

        final permanentlyDenied = remainingDenied.any(
          (permission) =>
              results[permission]?.isPermanentlyDenied == true ||
              results[permission]?.isRestricted == true,
        );

        debugPrint('DENIED PERMISSIONS: $deniedPermissions');
        debugPrint('REMAINING DENIED: $remainingDenied');
        debugPrint('PERMANENTLY DENIED: $permanentlyDenied');

        _permissionDialogOpen = true;

        final result = await Get.dialog<String>(
          PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Permissions Required'),
              content: Text(
                permanentlyDenied
                    ? 'Please enable the required location and camera '
                          'permissions in your device Settings to continue.'
                    : 'Location and camera permissions are needed '
                          'for this application. Please grant the '
                          'required permissions to continue.',
              ),
              actions: [
                if (permanentlyDenied)
                  TextButton(
                    onPressed: () => Get.back(result: 'settings'),
                    child: const Text('Open Settings'),
                  ),
                TextButton(
                  onPressed: () => Get.back(result: 'retry'),
                  child: const Text('Try Again'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: 'exit'),
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        );

        _permissionDialogOpen = false;

        if (result == 'settings') {
          _waitingForSettings = true;

          final opened = await openAppSettings();

          if (!opened) {
            _waitingForSettings = false;
            debugPrint('COULD NOT OPEN APP SETTINGS');
          }

          // Permission checking resumes when the app returns.
          return;
        }

        if (result == 'retry') {
          continue;
        }

        // Keep the user on the splash screen if permissions
        // remain denied. The app can be reopened to try again.
        return;
      }
    } catch (e, stackTrace) {
      _permissionDialogOpen = false;

      debugPrint('PERMISSION REQUEST ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      // Do not navigate without the required permissions.
    }
  }

  // ========================================================================
  // NEXT SCREEN
  // ========================================================================

  Future<void> goToNextScreen() async {
    final loggedIn = await AppSession.isLoggedIn();

    debugPrint('LOGIN STATUS: $loggedIn');

    if (loggedIn) {
      final data = await AppSession.getLoginData();

      Get.offAllNamed(AppRoutes.dashboard, arguments: data);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
