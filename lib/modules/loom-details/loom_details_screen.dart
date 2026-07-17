import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

class LoomDetailsScreen extends StatelessWidget {
  const LoomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Loom Details"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [

                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xffE3F2FD),
                  child: Icon(
                    Icons.precision_manufacturing,
                    size: 45,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 25),

                _dropdown("Loom Type", Icons.category),

                const SizedBox(height: 18),

                _numberField(
                  "Number of Looms",
                  Icons.confirmation_number,
                ),

                const SizedBox(height: 18),

                _dropdown(
                  "Operational Status",
                  Icons.settings,
                ),

                const SizedBox(height: 18),

                _dropdown(
                  "Weaving Type",
                  Icons.handyman,
                ),

                const SizedBox(height: 18),

                _dropdown(
                  "Fibre Type",
                  Icons.grass,
                ),

                const SizedBox(height: 18),

                _dropdown(
                  "Yarn Type",
                  Icons.blur_on,
                ),

                const SizedBox(height: 18),

                _numberField(
                  "Monthly Production",
                  Icons.inventory,
                ),

                const SizedBox(height: 18),

                _numberField(
                  "Monthly Income",
                  Icons.currency_rupee,
                ),

                const SizedBox(height: 18),

                _textField(
                  "Remarks",
                  Icons.note,
                  maxLines: 3,
                ),

                const SizedBox(height: 30),

                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.houseDetails);
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _numberField(
    String label,
    IconData icon,
  ) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    IconData icon,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: "Option 1",
          child: Text("Option 1"),
        ),
        DropdownMenuItem(
          value: "Option 2",
          child: Text("Option 2"),
        ),
      ],
      onChanged: (value) {},
    );
  }
}