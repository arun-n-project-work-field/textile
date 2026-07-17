import 'package:get/get.dart';
import 'package:namma_kaimagga_app/about_app_screen.dart';
import 'package:namma_kaimagga_app/disclaimer_screen.dart';
import 'package:namma_kaimagga_app/modules/bank-details/bank_details_screen.dart';
import 'package:namma_kaimagga_app/modules/family_info/family_info_binding.dart';
import 'package:namma_kaimagga_app/modules/family_info/family_info_screen.dart';
import 'package:namma_kaimagga_app/modules/geo-tagging/geo_tagging_screen.dart';
import 'package:namma_kaimagga_app/modules/house-details/house-details-screen.dart';
import 'package:namma_kaimagga_app/modules/login/login_binding.dart';
import 'package:namma_kaimagga_app/modules/loom-details/loom_details_screen.dart';
import 'package:namma_kaimagga_app/modules/saved-surveys/saved_surveys_screen.dart';
import 'package:namma_kaimagga_app/modules/sync-data/sync_data_screen.dart';
import 'package:namma_kaimagga_app/modules/weaver-information/weaver_information_screen.dart';
import 'package:namma_kaimagga_app/reset_password_screen.dart';
import '../modules/login/login_screen.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';
import '../modules/dashboard/dashboard_screen.dart';
import '../modules/weaver_list/weaver_list_binding.dart';
import '../modules/weaver_list/weaver_list_screen.dart';
import '../modules/weaver_details/weaver_details_binding.dart';
import '../modules/weaver_details/weaver_details_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(
      name: "/weaver-list",
      page: () => const WeaverListScreen(),
      binding: WeaverListBinding(),
    ),
    GetPage(
      name: "/weaver-details",
      page: () => const WeaverDetailsScreen(),
      binding: WeaverDetailsBinding(),
    ),
    GetPage(
      name: "/family-info",
      page: () => const FamilyInfoScreen(),
      binding: FamilyInfoBinding(),
    ),
    GetPage(name: "/saved-survey", page: () => const SavedSurveyScreen()),
    GetPage(name: AppRoutes.geoTagging, page: () => const GeoTaggingScreen()),
    GetPage(
      name: AppRoutes.weaverInformation,
      page: () => const WeaverInformationScreen(),
    ),
    
    GetPage(name: AppRoutes.bankDetails, page: () => const BankDetailsScreen()),
    GetPage(name: AppRoutes.loomDetails, page: () => const LoomDetailsScreen()),
    GetPage(name: AppRoutes.houseDetails, page: () => const HouseDetailsScreen()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.savedSurvey, page: () => const SavedSurveyScreen()),
    GetPage(name: AppRoutes.sync, page: () => const SyncDataScreen()),
    GetPage(name: AppRoutes.geoTagging, page: () => const GeoTaggingScreen()),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(name: AppRoutes.about, page: () => const AboutAppScreen()),
    GetPage(name: AppRoutes.disclaimer, page: () => const DisclaimerScreen()),
  ];
}
