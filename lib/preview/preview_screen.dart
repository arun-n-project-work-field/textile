// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'preview_controller.dart';

// class PreviewScreen extends StatelessWidget {
//   PreviewScreen({super.key});

//   final PreviewController controller =
//       Get.find<PreviewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F7FA),

//       appBar: AppBar(
//         backgroundColor: Colors.green.shade800,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Preview",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: Obx(
//         () => SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [

//               //---------------------------------------
//               // LOCATION CARD
//               //---------------------------------------

//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.all(18),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [

//                       const Text(
//                         "Geo Tag Information",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight:
//                               FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Row(
//                         children: [

//                           Expanded(
//                             child: _tile(
//                               Icons.location_on,
//                               "Latitude",
//                               controller.latitude.value,
//                             ),
//                           ),

//                           Expanded(
//                             child: _tile(
//                               Icons.location_searching,
//                               "Longitude",
//                               controller.longitude.value,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 15),

//                       Row(
//                         children: [

//                           Expanded(
//                             child: _tile(
//                               Icons.gps_fixed,
//                               "Accuracy",
//                               controller.accuracy.value,
//                             ),
//                           ),

//                           Expanded(
//                             child: _tile(
//                               Icons.access_time,
//                               "Date",
//                               controller.date.value,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//                             //---------------------------------------
//               // PHOTOS
//               //---------------------------------------

//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       const Text(
//                         "Captured Photos",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       Row(
//                         children: [

//                           Expanded(
//                             child: Container(
//                               height: 180,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade300,
//                                 borderRadius:
//                                     BorderRadius.circular(12),
//                               ),
//                               child: controller.photo1.value.isEmpty
//                                   ? const Center(
//                                       child: Icon(
//                                         Icons.image,
//                                         size: 60,
//                                       ),
//                                     )
//                                   : ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(12),
//                                       child: Image.asset(
//                                         controller.photo1.value,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                             ),
//                           ),

//                           const SizedBox(width: 15),

//                           Expanded(
//                             child: Container(
//                               height: 180,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade300,
//                                 borderRadius:
//                                     BorderRadius.circular(12),
//                               ),
//                               child: controller.photo2.value.isEmpty
//                                   ? const Center(
//                                       child: Icon(
//                                         Icons.image,
//                                         size: 60,
//                                       ),
//                                     )
//                                   : ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(12),
//                                       child: Image.asset(
//                                         controller.photo2.value,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //---------------------------------------
//               // PRODUCTS
//               //---------------------------------------

//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [

//                       const Text(
//                         "Products",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       ListView.builder(
//                         itemCount: controller.products.length,
//                         shrinkWrap: true,
//                         physics:
//                             const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {

//                           final product =
//                               controller.products[index];

//                           return Card(
//                             margin:
//                                 const EdgeInsets.only(bottom: 15),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.all(15),
//                               child: Column(
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [

//                                   Text(
//                                     product.name,
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight:
//                                           FontWeight.bold,
//                                     ),
//                                   ),

//                                   const SizedBox(height: 10),

//                                   Text(
//                                       "Category : ${product.category}"),

//                                   Text(
//                                       "Barcode : ${product.barcode}"),

//                                   Text(
//                                       "Weight : ${product.weight} Kg"),

//                                   Text(
//                                       "Price : ₹ ${product.price}"),

//                                   Text(
//                                       "Quantity : ${product.quantity}"),

//                                   const SizedBox(height: 15),

//                                   const Center(
//                                     child: Icon(
//                                       Icons.qr_code_2,
//                                       size: 80,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//                             //---------------------------------------
//               // SUMMARY
//               //---------------------------------------

//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     children: [

//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                         children: [

//                           const Text(
//                             "Total Products",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             ),
//                           ),

//                           Text(
//                             "${controller.products.length}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 15),

//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                         children: [

//                           const Text(
//                             "Estimated Value",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             ),
//                           ),

//                           Text(
//                             "₹ ${controller.totalAmount.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               //---------------------------------------
//               // BUTTONS
//               //---------------------------------------

//               Row(
//                 children: [

//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(Icons.save),
//                       label: const Text("Save Offline"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize:
//                             const Size.fromHeight(55),
//                       ),
//                       onPressed: controller.saveOffline,
//                     ),
//                   ),

//                   const SizedBox(width: 15),

//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(Icons.cloud_upload),
//                       label: const Text("Sync"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         minimumSize:
//                             const Size.fromHeight(55),
//                       ),
//                       onPressed: controller.syncData,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //---------------------------------------
//   // COMMON TILE
//   //---------------------------------------

//   Widget _tile(
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         Icon(
//           icon,
//           color: Colors.green,
//           size: 24,
//         ),

//         const SizedBox(width: 10),

//         Expanded(
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [

//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 13,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'preview_controller.dart';
import '../models/product_model.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({super.key});

  final PreviewController controller =
      Get.find<PreviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Preview & Verification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              //----------------------------------------------------
              // GEO TAG INFORMATION
              //----------------------------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Icon(
                            Icons.location_on,
                            color: Colors.green.shade700,
                          ),

                          const SizedBox(width: 10),

                          const Text(
                            "Geo Tag Information",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          Expanded(
                            child: _tile(
                              Icons.location_on,
                              "Latitude",
                              controller.latitude.value,
                            ),
                          ),

                          Expanded(
                            child: _tile(
                              Icons.location_searching,
                              "Longitude",
                              controller.longitude.value,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: _tile(
                              Icons.gps_fixed,
                              "Accuracy",
                              controller.accuracy.value,
                            ),
                          ),

                          Expanded(
                            child: _tile(
                              Icons.access_time,
                              "Captured Time",
                              controller.date.value,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------------------------
              // CAPTURED PHOTOS
              //----------------------------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Icon(
                            Icons.photo_camera,
                            color: Colors.green.shade700,
                          ),

                          const SizedBox(width: 10),

                          const Text(
                            "Captured Photos",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(15),
                                color:
                                    Colors.grey.shade300,
                              ),
                              child: controller
                                      .photo1.value
                                      .isEmpty
                                  ? const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 60,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                              15),
                                      child: Image.file(
                                        controller.photo1File,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(15),
                                color:
                                    Colors.grey.shade300,
                              ),
                              child: controller
                                      .photo2.value
                                      .isEmpty
                                  ? const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 60,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                              15),
                                      child: Image.file(
                                        controller.photo2File,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
                            //----------------------------------------------------
              // PRODUCTS
              //----------------------------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Icon(
                            Icons.shopping_bag,
                            color: Colors.green.shade700,
                          ),

                          const SizedBox(width: 10),

                          const Text(
                            "Products",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.products.length,
                        itemBuilder:
                            (context, index) {

                          final product =
                              controller.products[index];

                          return Card(
                            margin:
                                const EdgeInsets.only(
                                    bottom: 18),
                            elevation: 2,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                      16),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [

                                  Row(
                                    children: [

                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor:
                                            Colors.green
                                                .shade100,
                                        child: const Icon(
                                          Icons.shopping_bag,
                                          color:
                                              Colors.green,
                                        ),
                                      ),

                                      const SizedBox(
                                          width: 15),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [

                                            Text(
                                              product
                                                  .productName,
                                              style:
                                                  const TextStyle(
                                                fontSize:
                                                    18,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                            ),

                                            const SizedBox(
                                                height: 5),

                                            Text(
                                              product
                                                  .category,
                                              style:
                                                  TextStyle(
                                                color: Colors
                                                    .grey
                                                    .shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 20),

                                  Center(
                                    child: BarcodeWidget(
                                      barcode: Barcode
                                          .qrCode(),
                                      data: product
                                          .barcode,
                                      width: 180,
                                      height: 180,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 20),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: _tile(
                                          Icons.qr_code,
                                          "Barcode",
                                          product.barcode,
                                        ),
                                      ),

                                      Expanded(
                                        child: _tile(
                                          Icons.scale,
                                          "Weight",
                                          "${product.weight} Kg",
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 15),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: _tile(
                                          Icons
                                              .inventory_2,
                                          "Quantity",
                                          "${product.quantity}",
                                        ),
                                      ),

                                      Expanded(
                                        child: _tile(
                                          Icons
                                              .currency_rupee,
                                          "Price",
                                          "₹ ${product.price}",
                                        ),
                                      ),
                                    ],
                                  ),
                                   const SizedBox(height: 20),

                                  if (product.imagePath.isNotEmpty)
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      child: Image.file(
                                        File(product.imagePath),
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                  if (product.imagePath.isNotEmpty)
                                    const SizedBox(height: 20),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: _tile(
                                          Icons.layers,
                                          "Material",
                                          product.material,
                                        ),
                                      ),

                                      Expanded(
                                        child: _tile(
                                          Icons.palette,
                                          "Colour",
                                          product.colour,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: _tile(
                                          Icons.texture,
                                          "Design",
                                          product.design,
                                        ),
                                      ),

                                      Expanded(
                                        child: _tile(
                                          Icons.calendar_month,
                                          "Mfg Date",
                                          product.manufactureDate,
                                        ),
                                      ),
                                    ],
                                  ),

                                  if (product.remarks.isNotEmpty) ...[

                                    const SizedBox(height: 15),

                                    Container(
                                      width: double.infinity,
                                      padding:
                                          const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [

                                          const Text(
                                            "Remarks",
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          Text(
                                            product.remarks,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //----------------------------------------------------
              // SUMMARY
              //----------------------------------------------------

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          const Text(
                            "Total Products",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          Text(
                            "${controller.products.length}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          const Text(
                            "Total Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          Text(
                            "${controller.totalQuantity}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          const Text(
                            "Estimated Value",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),

                          Text(
                            "₹ ${controller.totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),
                            //----------------------------------------------------
              // ACTION BUTTONS
              //----------------------------------------------------

              Row(
                children: [

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.saveOffline,
                      icon: const Icon(Icons.save),
                      label: const Text(
                        "Save Offline",
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          controller.generateReport,
                      icon: const Icon(Icons.qr_code),
                      label: const Text(
                        "Generate QR",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.orange,
                        foregroundColor:
                            Colors.white,
                        minimumSize:
                            const Size.fromHeight(55),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.submitData,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text(
                    "Submit to Server",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize:
                        const Size.fromHeight(58),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------
  // COMMON INFO TILE
  //----------------------------------------------------

  Widget _tile(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Icon(
          icon,
          color: Colors.green,
          size: 22,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
