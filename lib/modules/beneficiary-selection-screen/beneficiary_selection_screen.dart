import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiarySelectionScreen extends StatefulWidget {
  const BeneficiarySelectionScreen({super.key});

  @override
  State<BeneficiarySelectionScreen> createState() =>
      _BeneficiarySelectionScreenState();
}

class _BeneficiarySelectionScreenState
    extends State<BeneficiarySelectionScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> beneficiaryList = [
    "PE000001",
    "PE000002",
    "PE000003",
    "PE000004",
    "PE000005",
    "PE000006",
    "PE000007",
    "PE000008",
  ];

  String selectedBeneficiary = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Beneficiary Selection",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const Icon(
                      Icons.person_search,
                      size: 70,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Search Beneficiary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Search using Pechan Number / Beneficiary ID",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Autocomplete<String>(
                      optionsBuilder: (value) {
                        if (value.text.isEmpty) {
                          return beneficiaryList;
                        }

                        return beneficiaryList.where(
                          (item) => item
                              .toLowerCase()
                              .contains(value.text.toLowerCase()),
                        );
                      },

                      onSelected: (value) {
                        setState(() {
                          selectedBeneficiary = value;
                        });
                      },

                      fieldViewBuilder: (
                        context,
                        controller,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: "Enter Beneficiary ID",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (selectedBeneficiary.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [

                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        selectedBeneficiary,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Beneficiary Selected Successfully",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Get.toNamed(AppRoutes.weaverInfo);
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}