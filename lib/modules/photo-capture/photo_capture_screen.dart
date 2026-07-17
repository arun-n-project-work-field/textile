import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoCaptureScreen extends StatelessWidget {
  const PhotoCaptureScreen({super.key});

  Widget photoCard(
    String title,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.camera_alt,
                    size: 70,
                    color: color,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "No Photo Captured",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture Photo"),
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                const Icon(Icons.location_on,color: Colors.red),

                const SizedBox(width:10),

                Expanded(
                  child: Text(
                    "Latitude : 0.000000",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                )

              ],
            ),

            const SizedBox(height:8),

            Row(
              children: [

                const Icon(Icons.place,color: Colors.blue),

                const SizedBox(width:10),

                Expanded(
                  child: Text(
                    "Longitude : 0.000000",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                )

              ],
            ),

            const SizedBox(height:8),

            Row(
              children: [

                const Icon(Icons.access_time,color: Colors.green),

                const SizedBox(width:10),

                Expanded(
                  child: Text(
                    "Date & Time : --/--/----",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Photographs"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            photoCard(
              "Photograph 1",
              Colors.blue,
            ),

            const SizedBox(height:20),

            photoCard(
              "Photograph 2",
              Colors.green,
            ),

            const SizedBox(height:30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(height:20),

          ],
        ),
      ),
    );
  }
}