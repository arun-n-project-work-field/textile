import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 30),

            Autocomplete<String>(
              optionsBuilder: (value) {
                if (value.text.isEmpty) {
                  return controller.usernameList;
                }

                return controller.usernameList.where(
                  (e) => e.toLowerCase().contains(value.text.toLowerCase()),
                );
              },

              onSelected: (value) {
                controller.usernameController.text = value;
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller.passwordController,

              obscureText: true,

              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                onPressed: controller.login,

                child: const Text("LOGIN"),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Get.toNamed('/reset-password');
              },

              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
