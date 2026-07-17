import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'weaver_details_controller.dart';

class WeaverDetailsScreen extends GetView<WeaverDetailsController> {
  const WeaverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Weaver Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _field("Beneficiary ID", controller.beneficiaryId),

                    _field("Weaver Name", controller.weaverName),

                    _field("Father Name", controller.fatherName),

                    _field("Mobile Number", controller.mobile),

                    _field("District", controller.district),

                    _field("Taluk", controller.taluk),

                    _field("Village", controller.village),

                    _field("Address", controller.address, maxLines: 3),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),

                onPressed: () {
                  Get.toNamed("/family-info");
                },

                icon: const Icon(Icons.arrow_forward),

                label: const Text("NEXT", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: TextField(
        controller: controller,

        maxLines: maxLines,

        decoration: InputDecoration(
          labelText: label,

          filled: true,

          fillColor: Colors.grey.shade100,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
