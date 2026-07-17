import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  final districtController = TextEditingController();
  final talukController = TextEditingController();
  final villageController = TextEditingController();
  final addressController = TextEditingController();
  final buildingController = TextEditingController();
  final doorController = TextEditingController();
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final areaController = TextEditingController();
  final localityController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Address Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            _card(

              child: Column(
                children: [

                  _field(
                    "District",
                    districtController,
                    Icons.location_city,
                    true,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Taluk",
                    talukController,
                    Icons.map,
                    true,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Village",
                    villageController,
                    Icons.home_work,
                    true,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),

            _card(

              child: Column(
                children: [

                  _field(
                    "Address",
                    addressController,
                    Icons.location_on,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Building Name",
                    buildingController,
                    Icons.apartment,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Door Number",
                    doorController,
                    Icons.meeting_room,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Street Name 1",
                    street1Controller,
                    Icons.signpost,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Street Name 2",
                    street2Controller,
                    Icons.signpost_outlined,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Area Name",
                    areaController,
                    Icons.place,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Locality Name",
                    localityController,
                    Icons.location_city,
                  ),

                  const SizedBox(height: 15),

                  _field(
                    "Pincode",
                    pincodeController,
                    Icons.pin_drop,
                    false,
                    TextInputType.number,
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Get.toNamed(AppRoutes.bank);
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  "NEXT",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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

  Widget _card({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller,
    IconData icon, [
    bool readOnly = false,
    TextInputType keyboard = TextInputType.text,
  ]) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboard,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}