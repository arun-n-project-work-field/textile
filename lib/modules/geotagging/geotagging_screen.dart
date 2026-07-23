// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'geotagging_controller.dart';

// class GeoTaggingScreen extends StatelessWidget {
//   GeoTaggingScreen({super.key});

//   final GeoTaggingController controller = Get.find<GeoTaggingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F7FA),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.green.shade800,
//         foregroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Geo Tagging",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(18),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         color: Colors.grey.shade300,
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "ArcGIS Map Here",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 15,
//                       top: 15,
//                       child: Column(
//                         children: [
//                           FloatingActionButton.small(
//                             heroTag: "gps",
//                             backgroundColor: Colors.green,
//                             onPressed: controller.getCurrentLocation,
//                             child: const Icon(Icons.my_location),
//                           ),
//                           const SizedBox(height: 12),
//                           FloatingActionButton.small(
//                             heroTag: "layer",
//                             backgroundColor: Colors.green,
//                             onPressed: controller.changeMapType,
//                             child: const Icon(Icons.layers),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Obx(
//                     () => Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _infoTile(
//                                 Icons.location_on,
//                                 "Latitude",
//                                 controller.latitude.value,
//                               ),
//                             ),
//                             Expanded(
//                               child: _infoTile(
//                                 Icons.location_searching,
//                                 "Longitude",
//                                 controller.longitude.value,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Divider(),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _infoTile(
//                                 Icons.gps_fixed,
//                                 "Accuracy",
//                                 controller.accuracy.value,
//                               ),
//                             ),
//                             Expanded(
//                               child: _infoTile(
//                                 Icons.access_time,
//                                 "Time",
//                                 controller.time.value,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _photoCard("Photo 1", controller.capturePhoto1),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: _photoCard("Photo 2", controller.capturePhoto2),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
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
//                         "Barcode",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextField(
//                         controller: controller.barcodeController,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.qr_code_scanner),
//                             onPressed: controller.scanBarcode,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: controller.weightController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Product Weight (Kg)",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextField(
//                         controller: controller.remarksController,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           labelText: "Remarks",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: controller.saveDraft,
//                       icon: const Icon(Icons.save),
//                       label: const Text("Save Draft"),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(55),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: controller.submitData,
//                       icon: const Icon(Icons.cloud_upload),
//                       label: const Text("Submit"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         minimumSize: const Size.fromHeight(55),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _infoTile(IconData icon, String title, String value) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.green),
//         const SizedBox(height: 8),
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 6),
//         Text(value, textAlign: TextAlign.center),
//       ],
//     );
//   }

//   Widget _photoCard(String title, VoidCallback onTap) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(18),
//         onTap: onTap,
//         child: SizedBox(
//           height: 230,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.camera_alt, size: 70, color: Colors.green),
//               const SizedBox(height: 20),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text("Tap to Capture"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

import 'geotagging_controller.dart';

class GeoTaggingScreen extends StatelessWidget {
  GeoTaggingScreen({super.key});

  final GeoTaggingController controller = Get.find<GeoTaggingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        title: const Text(
          "Geo Tagging",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //------------------------------------------------
              // MAP
              //------------------------------------------------
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Text(
                          "ArcGIS Map",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 15,
                      top: 15,
                      child: Column(
                        children: [
                          FloatingActionButton.small(
                            heroTag: "gps",
                            backgroundColor: Colors.green,
                            onPressed: controller.getCurrentLocation,
                            child: const Icon(Icons.my_location),
                          ),

                          const SizedBox(height: 12),

                          FloatingActionButton.small(
                            heroTag: "layer",
                            backgroundColor: Colors.green,
                            onPressed: controller.changeMapType,
                            child: const Icon(Icons.layers),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // LOCATION DETAILS
              //------------------------------------------------
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _infoTile(
                                Icons.location_on,
                                "Latitude",
                                controller.latitude.value,
                              ),
                            ),

                            Expanded(
                              child: _infoTile(
                                Icons.location_searching,
                                "Longitude",
                                controller.longitude.value,
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 30),

                        Row(
                          children: [
                            Expanded(
                              child: _infoTile(
                                Icons.gps_fixed,
                                "Accuracy",
                                controller.accuracy.value,
                              ),
                            ),

                            Expanded(
                              child: _infoTile(
                                Icons.access_time,
                                "Captured Time",
                                controller.time.value,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // PHOTOS
              //------------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: _photoCard(
                      "Handloom Photo",
                      controller.capturePhoto1,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _photoCard(
                      "Weaver + Handloom",
                      controller.capturePhoto2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //------------------------------------------------
              // REMARKS
              //------------------------------------------------
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Remarks",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: controller.remarksController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter remarks (Optional)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //------------------------------------------
              // BUTTONS
              //------------------------------------------
              Row(
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
                      onPressed: () {
                        Get.toNamed(AppRoutes.productList);
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Next"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(55),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green.shade50,
          child: Icon(icon, color: Colors.green),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _photoCard(String title, VoidCallback onTap) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          height: 230,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Tap to Capture",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 12),

                const Icon(Icons.add_a_photo, color: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
