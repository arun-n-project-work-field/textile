import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class HouseDetailsScreen extends StatefulWidget {
  const HouseDetailsScreen({super.key});

  @override
  State<HouseDetailsScreen> createState() => _HouseDetailsScreenState();
}

class _HouseDetailsScreenState extends State<HouseDetailsScreen> {
  final addressController = TextEditingController();
  final buildingController = TextEditingController();
  final doorController = TextEditingController();
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final areaController = TextEditingController();
  final localityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    buildingController.dispose();
    doorController.dispose();
    street1Controller.dispose();
    street2Controller.dispose();
    areaController.dispose();
    localityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          prefixIcon: const Icon(Icons.home_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("House Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff1565C0),
                    Color(0xff42A5F5),
                  ],
                ),
              ),
              child: const Column(
                children: [

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home_work,
                      color: Colors.blue,
                      size: 38,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "House Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Enter House Information",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    buildField(
                      "Address",
                      addressController,
                      maxLines: 3,
                    ),

                    buildField(
                      "Building Name",
                      buildingController,
                    ),

                    buildField(
                      "Door Number",
                      doorController,
                    ),

                    buildField(
                      "Street Name 1",
                      street1Controller,
                    ),

                    buildField(
                      "Street Name 2",
                      street2Controller,
                    ),

                    buildField(
                      "Area Name",
                      areaController,
                    ),

                    buildField(
                      "Locality Name",
                      localityController,
                    ),

                    buildField(
                      "Pincode",
                      pincodeController,
                      keyboard: TextInputType.number,
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 55),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("BACK"),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 55),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.bankDetails);
                    },
                    child: const Text("NEXT"),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}