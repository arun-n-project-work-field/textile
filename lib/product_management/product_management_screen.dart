import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_management_controller.dart';

class ProductManagementScreen extends StatelessWidget {
  ProductManagementScreen({super.key});

  final ProductManagementController controller =
      Get.find<ProductManagementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FA),

      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Product Management",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
        onPressed: controller.addProduct,
      ),

      body: SafeArea(
        child: Column(
          children: [
            //------------------------------------
            // HANDLOOM INFORMATION
            //------------------------------------
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.check, color: Colors.white),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Geo Tagged Successfully",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Obx(
                          () => Text(
                            "Handloom ID : ${controller.handloomId.value}",
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          "Location Captured",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //------------------------------------
            // TITLE
            //------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  const Icon(Icons.inventory, color: Colors.green),

                  const SizedBox(width: 8),

                  const Text(
                    "Registered Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const Spacer(),

                  Obx(
                    () => Chip(
                      backgroundColor: Colors.green,
                      label: Text(
                        controller.products.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            //------------------------------------
            // PRODUCT LIST
            //------------------------------------
            Expanded(
              child: Obx(() {
                if (controller.products.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Products Added",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 15),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(product.category),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: _infoTile("Barcode", product.barcode),
                                ),

                                Expanded(
                                  child: _infoTile(
                                    "Weight",
                                    "${product.weight} Kg",
                                  ),
                                ),
                              ],
                            ),

                            const Divider(height: 25),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        controller.editProduct(index),
                                    icon: const Icon(Icons.edit),
                                    label: const Text("Edit"),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () =>
                                        controller.deleteProduct(index),
                                    icon: const Icon(Icons.delete),
                                    label: const Text("Delete"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.saveDraft,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Draft"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: controller.continueNext,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Continue"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }
}
