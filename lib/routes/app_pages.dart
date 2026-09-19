import 'package:get/get.dart';
import 'package:namma_kaimagga_app/about_app_screen.dart';
import 'package:namma_kaimagga_app/disclaimer_screen.dart';
import 'package:namma_kaimagga_app/modules/geotagging/geotagging_binding.dart';
import 'package:namma_kaimagga_app/modules/geotagging/geotagging_screen.dart';
import 'package:namma_kaimagga_app/modules/login/login_binding.dart';
import 'package:namma_kaimagga_app/modules/login/login_screen.dart';
import 'package:namma_kaimagga_app/modules/saved-surveys/saved_surveys_screen.dart';
import 'package:namma_kaimagga_app/modules/splash/splash_binding.dart';
import 'package:namma_kaimagga_app/modules/splash/splash_screen.dart';
import 'package:namma_kaimagga_app/modules/sync-data/sync_data_screen.dart';
import 'package:namma_kaimagga_app/reset_password_screen.dart';
import 'package:namma_kaimagga_app/sync-status/sync_status_binding.dart';
import 'package:namma_kaimagga_app/sync-status/sync_status_screen.dart';
import '../modules/dashboard/dashboard_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // -------------------------------------------------------------------------
    // SPLASH
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // -------------------------------------------------------------------------
    // LOGIN
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    // -------------------------------------------------------------------------
    // DASHBOARD
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.dashboard,
      page: () {
        final arguments =
            Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};

        return DashboardScreen(
          mobileNumber: arguments['mobileNumber']?.toString() ?? '',
          districtName: arguments['districtName']?.toString() ?? '',
          talukName: arguments['talukName']?.toString() ?? '',
        );
      },
    ),

    // -------------------------------------------------------------------------
    // SAVED SURVEYS
    // -------------------------------------------------------------------------
    GetPage(name: AppRoutes.savedSurvey, page: () => const SavedSurveyScreen()),

    // -------------------------------------------------------------------------
    // SYNC
    // -------------------------------------------------------------------------
    GetPage(name: AppRoutes.sync, page: () => const SyncDataScreen()),

    // -------------------------------------------------------------------------
    // GEO TAGGING
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.geoTagging,
      page: () => GeoTaggingScreen(),
      binding: GeoTaggingBinding(),
    ),

    // -------------------------------------------------------------------------
    // RESET PASSWORD
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),

    // -------------------------------------------------------------------------
    // ABOUT APP
    // -------------------------------------------------------------------------
    GetPage(name: AppRoutes.about, page: () => const AboutAppScreen()),

    // -------------------------------------------------------------------------
    // DISCLAIMER
    // -------------------------------------------------------------------------
    GetPage(name: AppRoutes.disclaimer, page: () => const DisclaimerScreen()),

    // -------------------------------------------------------------------------
    // SYNC STATUS
    // -------------------------------------------------------------------------
    GetPage(
      name: AppRoutes.syncStatus,
      page: () => SyncStatusScreen(),
      binding: SyncStatusBinding(),
    ),

    // -------------------------------------------------------------------------
    // SYNC DATA
    // -------------------------------------------------------------------------
    GetPage(name: AppRoutes.syncData, page: () => const SyncDataScreen()),
  ];
}
