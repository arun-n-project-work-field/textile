// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'splash_controller.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Get.put(SplashController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset("assets/images/splash.jpg", fit: BoxFit.cover),
//           ),

//           const Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: CircularProgressIndicator(color: Colors.brown),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen
    extends GetView<SplashController> {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        fit: StackFit.expand,
        children: [

          // ====================================================
          // FULL SCREEN SPLASH IMAGE
          // ====================================================

          Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
          ),

          // ====================================================
          // VERSION CHECK LOADING
          // ====================================================

          Obx(
            () {
              if (!controller
                  .isCheckingVersion
                  .value) {
                return const SizedBox.shrink();
              }

              return const Positioned(
                bottom: 45,
                left: 0,
                right: 0,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    CircularProgressIndicator(
                      color: Colors.brown,
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Checking application version...',
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w500,

                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}