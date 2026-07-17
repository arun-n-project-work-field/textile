import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameList = <String>[
    "Officer001",
    "Officer002",
    "Admin",
    "Surveyor01",
    "Surveyor02",
    "District Officer",
  ].obs;

  final obscurePassword = true.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    if (usernameController.text.trim().isEmpty) {
      Get.snackbar(
        "Username",
        "Please enter username",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        "Password",
        "Please enter password",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    Get.offAllNamed(AppRoutes.dashboard);
  }
}
