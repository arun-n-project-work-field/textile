import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(SplashController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/splash.jpg", fit: BoxFit.cover),
          ),

          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          ),
        ],
      ),
    );
  }
}
