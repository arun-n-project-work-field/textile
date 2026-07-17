// import 'package:flutter/material.dart';

// class AboutAppScreen extends StatefulWidget {
//   const AboutAppScreen({super.key});

//   @override
//   State<AboutAppScreen> createState() => _AboutAppScreenState();
// }

// class _AboutAppScreenState extends State<AboutAppScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("About App", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.brown,
//       ),
//       body: Column(
//         children: [
//           Text(
//             "Name : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(width: 20),
//           Text("Namma Kaimagga"),
//           Text(
//             "Version : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(width: 20),
//           Text(
//             "Description : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "This mobile application is developed for the identification and geo-tagging of Handloom weaver location and photo of the handlooms along with the weaver in Karnataka.",
//           ),
//           SizedBox(width: 20),
//           Text(
//             "Developed By : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           Text("Karnataka-GIS, KSRSAC"),
//           SizedBox(width: 20),
//           Text(
//             "KGIS : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           Text("https://kgis.ksrsac.in/kgis/"),
//           SizedBox(width: 20),
//           Text(
//             "KSRSAC : ",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           Text("https://ksrsac.karnataka.gov.in"),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "About Application",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.handshake,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Namma Kaimagga",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Handloom Survey Application",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _infoCard(
              icon: Icons.info_outline,
              title: "Application Name",
              value: "Namma Kaimagga",
            ),

            _infoCard(
              icon: Icons.verified,
              title: "Version",
              value: "1.0.0",
            ),

            _infoCard(
              icon: Icons.business,
              title: "Developed By",
              value: "Karnataka GIS\nKSRSAC",
            ),

            _infoCard(
              icon: Icons.description,
              title: "Description",
              value:
                  "This mobile application is developed for identification and geo-tagging of Handloom Weaver locations and photographs of handlooms along with the weavers across Karnataka.",
            ),

            _infoCard(
              icon: Icons.public,
              title: "KGIS",
              value: "https://kgis.ksrsac.in/kgis/",
            ),

            _infoCard(
              icon: Icons.language,
              title: "KSRSAC",
              value: "https://ksrsac.karnataka.gov.in",
            ),

            const SizedBox(height: 25),

            Text(
              "© 2026 Karnataka State Remote Sensing Applications Centre",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                icon,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}