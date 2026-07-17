import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'weaver_list_controller.dart';

class WeaverListScreen extends GetView<WeaverListController> {
  const WeaverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Select Weaver",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,

            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Weaver",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(15),

                itemCount: controller.weavers.length,

                itemBuilder: (_, index) {
                  final item = controller.weavers[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),

                    elevation: 4,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),

                      onTap: () {
                        Get.toNamed("/weaver-details");
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(18),

                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(
                                Icons.person,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text("Beneficiary ID : ${item.id}"),

                                  Text("Father : ${item.father}"),

                                  Text("Village : ${item.village}"),
                                ],
                              ),
                            ),

                            const Icon(Icons.arrow_forward_ios, size: 18),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
