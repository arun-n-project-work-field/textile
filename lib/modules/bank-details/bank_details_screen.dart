import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text("Bank Details"),
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
                    Icons.account_balance,
                    color: Colors.blue,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 25),

                _field(
                  "Bank Name",
                  Icons.account_balance,
                ),

                const SizedBox(height: 18),

                _field(
                  "Branch Name",
                  Icons.location_city,
                ),

                const SizedBox(height: 18),

                _field(
                  "Account Holder Name",
                  Icons.person,
                ),

                const SizedBox(height: 18),

                _field(
                  "Account Number",
                  Icons.credit_card,
                  keyboard: TextInputType.number,
                ),

                const SizedBox(height: 18),

                _field(
                  "Confirm Account Number",
                  Icons.credit_card,
                  keyboard: TextInputType.number,
                ),

                const SizedBox(height: 18),

                _field(
                  "IFSC Code",
                  Icons.qr_code,
                  textCapitalization:
                      TextCapitalization.characters,
                ),

                const SizedBox(height: 18),

                _field(
                  "MICR Code",
                  Icons.numbers,
                ),

                const SizedBox(height: 18),

                _field(
                  "Remarks",
                  Icons.note_alt,
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
                          Get.toNamed(AppRoutes.loomDetails);
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                      ),
                    )

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
    TextCapitalization textCapitalization =
        TextCapitalization.none,
  }) {
    return TextField(
      keyboardType: keyboard,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}