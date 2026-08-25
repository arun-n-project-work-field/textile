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
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),

              padding: const EdgeInsets.all(28),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.08,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                children: [

                  // ==================================================
                  // LOGO
                  // ==================================================

                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xff1565C0),

                    child: Icon(
                      Icons.handshake,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // APP NAME
                  // ==================================================

                  const Text(
                    'Namma Kaimagga',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Handloom Survey Application',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ==================================================
                  // MOBILE NUMBER
                  // ==================================================

                  TextField(
                    controller:
                        controller.mobileController,

                    keyboardType:
                        TextInputType.phone,

                    maxLength: 10,

                    decoration: InputDecoration(
                      counterText: '',

                      prefixIcon: const Icon(
                        Icons.phone_android,
                      ),

                      labelText:
                          'Mobile Number',

                      hintText:
                          'Enter 10 digit mobile number',

                      filled: true,

                      fillColor:
                          Colors.grey.shade100,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // SEND OTP
                  // ==================================================

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.sendOtp,

                        icon:
                            controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color:
                                          Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.sms,
                                  ),

                        label: Text(
                          controller.isLoading.value
                              ? 'Sending OTP...'
                              : 'Send OTP',
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xff1565C0,
                          ),

                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ==================================================
                  // OTP SECTION
                  // ==================================================

                  Obx(
                    () {
                      if (!controller
                          .otpSent
                          .value) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        children: [

                          const SizedBox(
                            height: 25,
                          ),

                          TextField(
                            controller:
                                controller
                                    .otpController,

                            keyboardType:
                                TextInputType.number,

                            maxLength: 4,

                            obscureText:
                                controller
                                    .obscureOtp
                                    .value,

                            decoration:
                                InputDecoration(
                              counterText: '',

                              prefixIcon:
                                  const Icon(
                                Icons.lock_outline,
                              ),

                              suffixIcon:
                                  IconButton(
                                onPressed:
                                    controller
                                        .toggleOtpVisibility,

                                icon: Icon(
                                  controller
                                          .obscureOtp
                                          .value
                                      ? Icons
                                          .visibility
                                      : Icons
                                          .visibility_off,
                                ),
                              ),

                              labelText:
                                  'OTP',

                              hintText:
                                  'Enter 4 digit OTP',

                              filled: true,

                              fillColor:
                                  Colors.grey.shade100,

                              border:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // ========================================
                          // LOGIN
                          // ========================================

                          SizedBox(
                            width:
                                double.infinity,

                            height: 55,

                            child:
                                ElevatedButton(
                              onPressed:
                                  controller
                                      .isLoading
                                      .value
                                      ? null
                                      : controller
                                          .login,

                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    Colors.green,

                                foregroundColor:
                                    Colors.white,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    15,
                                  ),
                                ),
                              ),

                              child: const Text(
                                'LOGIN',
                                style:
                                    TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // ========================================
                          // CHANGE MOBILE
                          // ========================================

                          TextButton(
                            onPressed:
                                controller
                                    .changeMobile,

                            child: const Text(
                              'Change Mobile Number',
                            ),
                          ),
                        ],
                      );
                    },
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