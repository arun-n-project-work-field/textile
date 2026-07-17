// import 'package:flutter/material.dart';

// class DisclaimerScreen extends StatefulWidget {
//   const DisclaimerScreen({super.key});

//   @override
//   State<DisclaimerScreen> createState() => _DisclaimerScreenState();
// }

// class _DisclaimerScreenState extends State<DisclaimerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Disclaimer", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.brown,
//       ),
//       body: Column(
//         children: [
//           Text(
//             "Map boundaries are only for reference and not fit for legal use.",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Disclaimer",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff1565C0),
                    Color(0xff42A5F5),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.gavel,
                      color: Colors.blue,
                      size: 42,
                    ),
                  ),

                  SizedBox(height: 18),

                  Text(
                    "Application Disclaimer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Please read the following information carefully.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange.shade700,
                      size: 60,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Disclaimer",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Map boundaries and geographic information displayed in this application are intended only for reference purposes. They are not survey-grade data and should not be used for any legal, administrative, cadastral, or property-related decisions.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.amber.shade300,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Map boundaries are only for reference and are not fit for legal use.",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "© Karnataka State Remote Sensing Applications Centre",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}