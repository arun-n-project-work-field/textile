import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

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
          "Survey Preview",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            _section(
              title: "Weaver Information",
              icon: Icons.person,
              children: const [

                _Item("Pehchan ID", "KA123456"),
                _Item("Weaver Name", "Ramesh Kumar"),
                _Item("Father Name", "Shivappa"),
                _Item("Mobile", "9876543210"),
                _Item("District", "Bengaluru"),
                _Item("Taluk", "Yelahanka"),
                _Item("Village", "Kogilu"),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: "Family Information",
              icon: Icons.family_restroom,
              children: const [

                _Item("Family Members", "5"),
                _Item("Male", "2"),
                _Item("Female", "3"),
                _Item("Children", "2"),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: "House Details",
              icon: Icons.home,
              children: const [

                _Item("House Type", "Own"),
                _Item("Roof Type", "RCC"),
                _Item("Electricity", "Yes"),
                _Item("Water Supply", "Available"),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: "Loom Details",
              icon: Icons.precision_manufacturing,
              children: const [

                _Item("Loom Type", "Handloom"),
                _Item("Number of Looms", "2"),
                _Item("Working", "Yes"),
                _Item("Production", "Cotton Sarees"),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: "Bank Details",
              icon: Icons.account_balance,
              children: const [

                _Item("Bank", "State Bank of India"),
                _Item("Branch", "Yelahanka"),
                _Item("Account No.", "XXXXXXXX1234"),
                _Item("IFSC", "SBIN0001234"),
              ],
            ),

            const SizedBox(height: 16),

            _section(
              title: "Geo Tagging",
              icon: Icons.location_on,
              children: const [

                _Item("Latitude", "13.1032"),
                _Item("Longitude", "77.5961"),
                _Item("Photo 1", "Captured"),
                _Item("Photo 2", "Captured"),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save Offline"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(55),
                    ),
                    onPressed: () {
                      Get.snackbar(
                        "Success",
                        "Survey saved locally",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: const Text(
                  "Submit Survey",
                  style: TextStyle(fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.snackbar(
                    "Success",
                    "Survey submitted successfully",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Row(
              children: [

                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    icon,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

            const Divider(height: 25),

            ...children,
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String value;

  const _Item(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Text(" : "),

          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}