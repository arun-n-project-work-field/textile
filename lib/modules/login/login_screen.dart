import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Container(
              constraints: const BoxConstraints(maxWidth: 430),

              padding: const EdgeInsets.all(28),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .08),

                    blurRadius: 20,

                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,

                    backgroundColor: Color(0xff1565C0),

                    child: Icon(Icons.handshake, color: Colors.white, size: 42),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Namma Kaimagga",

                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Handloom Survey Application",

                    style: TextStyle(color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 35),

                  Autocomplete<String>(
                    optionsBuilder: (value) {
                      if (value.text.isEmpty) {
                        return controller.usernameList;
                      }

                      return controller.usernameList.where(
                        (e) =>
                            e.toLowerCase().contains(value.text.toLowerCase()),
                      );
                    },

                    fieldViewBuilder:
                        (context, textController, focusNode, onSubmitted) {
                          controller.usernameController.text =
                              textController.text;

                          textController.addListener(() {
                            controller.usernameController.text =
                                textController.text;
                          });

                          return TextField(
                            controller: textController,

                            focusNode: focusNode,

                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),

                              labelText: "Username",

                              filled: true,

                              fillColor: Colors.grey.shade100,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          );
                        },
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => TextField(
                      controller: controller.passwordController,

                      obscureText: controller.obscurePassword.value,

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(
                          onPressed: controller.togglePassword,

                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        labelText: "Password",

                        filled: true,

                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      onPressed: controller.login,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1565C0),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      child: const Text(
                        "LOGIN",

                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 17,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Get.toNamed('/reset-password');
                    },

                    child: const Text("Change Password"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
