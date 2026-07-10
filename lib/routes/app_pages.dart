import 'package:get/get.dart';
import 'package:namma_kaimagga_app/modules/login/login_binding.dart';

import '../modules/login/login_screen.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
