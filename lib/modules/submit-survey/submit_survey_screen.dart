import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitSurveyScreen extends StatelessWidget {
  const SubmitSurveyScreen({super.key});

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statusTile(
      IconData icon,
      String title,
      Color color,
      ) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Icon(
          Icons.check_circle,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review & Submit"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.assignment_turned_in,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Survey Summary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    buildRow("Pechan Number", "100245"),
                    buildRow("District", "Bengaluru"),
                    buildRow("Taluk", "Yelahanka"),
                    buildRow("Village", "Yelahanka"),
                    buildRow("Weaver", "Ramesh"),
                    buildRow("Mobile", "9876543210"),
                    buildRow("Fibre Type", "Cotton"),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            statusTile(
              Icons.photo_camera,
              "Photograph 1 Captured",
              Colors.green,
            ),

            statusTile(
              Icons.photo_camera_back,
              "Photograph 2 Captured",
              Colors.green,
            ),

            statusTile(
              Icons.location_on,
              "GPS Location Verified",
              Colors.blue,
            ),

            statusTile(
              Icons.storage,
              "Ready to Save",
              Colors.orange,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Survey",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Get.snackbar(
                    "Success",
                    "Survey Saved Successfully",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );

                  Future.delayed(
                    const Duration(seconds: 1),
                        () {
                      Get.back();
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text("Cancel"),
                onPressed: () => Get.back(),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}