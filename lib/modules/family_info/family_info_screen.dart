import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';
import 'family_info_controller.dart';

class FamilyInfoScreen extends GetView<FamilyInfoController> {
  const FamilyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Family Information",
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
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Color(0xffE3F2FD),
                      child: Icon(
                        Icons.family_restroom,
                        color: Colors.blue,
                        size: 45,
                      ),
                    ),

                    const SizedBox(height: 25),

                    _field("Head of Family", controller.familyHeadController),

                    const SizedBox(height: 15),

                    Obx(() {
                      return DropdownButtonFormField<String>(
                        initialValue: controller.familyType.value,

                        decoration: InputDecoration(
                          labelText: "Family Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        items: const [
                          DropdownMenuItem(
                            value: "Joint",
                            child: Text("Joint"),
                          ),

                          DropdownMenuItem(
                            value: "Nuclear",
                            child: Text("Nuclear"),
                          ),
                        ],

                        onChanged: (value) {
                          controller.familyType.value = value!;
                        },
                      );
                    }),

                    const SizedBox(height: 15),

                    _field(
                      "Total Members",
                      controller.totalMembers,
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 15),

                    _field(
                      "Male Members",
                      controller.maleMembers,
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 15),

                    _field(
                      "Female Members",
                      controller.femaleMembers,
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 15),

                    _field(
                      "Children",
                      controller.children,
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 15),

                    _field("Occupation", controller.occupationController),

                    const SizedBox(height: 15),

                    _field(
                      "Annual Income",
                      controller.annualIncomeController,
                      keyboard: TextInputType.number,
                    ),

                    const SizedBox(height: 15),

                    _field(
                      "Ration Card Number",
                      controller.rationCardController,
                    ),

                    const SizedBox(height: 15),

                    _field(
                      "Aadhaar Number",
                      controller.aadhaarController,
                      keyboard: TextInputType.number,
                    ),
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
                  Get.toNamed(AppRoutes.bankDetails);
                },

                icon: const Icon(Icons.arrow_forward),

                label: const Text("NEXT", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String title,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboard,

      decoration: InputDecoration(
        labelText: title,

        filled: true,

        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
