import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraCaptureScreen extends StatelessWidget {
  const CameraCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Photo Capture"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            _photoCard(
              title: "Photograph 1",
              icon: Icons.camera_alt,
            ),

            const SizedBox(height: 25),

            _photoCard(
              title: "Photograph 2",
              icon: Icons.camera_alt_outlined,
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  // Get.toNamed(AppRoutes.reviewSurvey);
                },

                icon: const Icon(Icons.arrow_forward),

                label: const Text(
                  "NEXT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _photoCard({
    required String title,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 18),

            Container(
              height: 210,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    icon,
                    size: 70,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.camera_alt),

                    label: const Text("Capture Photo"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _infoTile(
              Icons.location_on,
              "Latitude",
              "0.000000",
            ),

            const SizedBox(height: 10),

            _infoTile(
              Icons.location_on_outlined,
              "Longitude",
              "0.000000",
            ),

            const SizedBox(height: 10),

            _infoTile(
              Icons.access_time,
              "Date & Time",
              "--/--/---- --:--",
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}