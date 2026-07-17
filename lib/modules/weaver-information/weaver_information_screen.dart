import 'package:flutter/material.dart';

class WeaverInformationScreen extends StatelessWidget {
  const WeaverInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FB),

      appBar: AppBar(
        title: const Text("Weaver Information"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xffE3F2FD),
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 25),

                    _field(
                      "Beneficiary ID",
                      Icons.badge,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Weaver Name",
                      Icons.person_outline,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Father / Husband Name",
                      Icons.people_outline,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Mobile Number",
                      Icons.phone_android,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "District",
                      Icons.location_city,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Taluk",
                      Icons.map,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Village",
                      Icons.home_work,
                    ),

                    const SizedBox(height: 18),

                    _field(
                      "Address",
                      Icons.location_on,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text(
                          "Next",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
        ),
      ),
    );
  }
}