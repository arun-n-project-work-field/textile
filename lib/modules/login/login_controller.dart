import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final usernameList = <String>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadUsers();
  }

  Future<void> loadUsers() async {

    /// SQLite

    /// if empty

    /// call api

    /// save

    /// reload

  }

  Future<void> login() async {

  }

}