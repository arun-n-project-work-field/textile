// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';

// import 'geotagging_controller.dart';
// import '../../widgets/common_footer.dart';

// class GeoTaggingScreen extends StatelessWidget {
//   GeoTaggingScreen({super.key});

//   final GeoTaggingController controller = Get.find<GeoTaggingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//             'assets/images/background.jpg',
//           ), // Or NetworkImage('url')
//           fit: BoxFit.cover, // Ensures the image fills the entire screen
//         ),
//       ),
//       child: Scaffold(
//         // backgroundColor: const Color(0xffF4F7FA),
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: const CommonFooter(),

//         // ========================================================
//         // APP BAR
//         // ========================================================
//         appBar: AppBar(
//           elevation: 0,
//           centerTitle: true,
//           backgroundColor: const Color(0xff1565C0),
//           foregroundColor: Colors.white,
//           title: const Text(
//             'Geo Tagging',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),

//         // ========================================================
//         // BODY
//         // ========================================================
//         body: Obx(
//           () => SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // ==================================================
//                   // MAP
//                   // ==================================================
//                   Container(
//                     height: 330,
//                     width: double.infinity,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(18),
//                       boxShadow: [
//                         BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
//                       ],
//                     ),
//                     child: Stack(
//                       children: [
//                         FlutterMap(
//                           mapController: controller.mapController,
//                           options: MapOptions(
//                             initialCenter:
//                                 controller.currentLocation.value ??
//                                 const LatLng(15.3173, 75.7139),
//                             initialZoom: controller.initialZoom,
//                             // Disable map rotation while retaining pan and zoom.
//                             interactionOptions: const InteractionOptions(
//                               flags:
//                                   InteractiveFlag.all & ~InteractiveFlag.rotate,
//                             ),
//                             onMapReady: controller.onMapReady,
//                             onTap: (TapPosition tapPosition, LatLng point) {
//                               controller.onMapTap(tapPosition, point);
//                             },
//                           ),
//                           children: [
//                             // ==================================================
//                             // MAP TILE
//                             // ==================================================
//                             TileLayer(
//                               urlTemplate: controller.satelliteMap.value
//                                   ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
//                                   : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                               userAgentPackageName:
//                                   'com.ksrsac.namma_kaimagga_app',
//                             ),

//                             // ==================================================
//                             // CURRENT LOCATION
//                             // ==================================================
//                             if (controller.currentLocation.value != null)
//                               MarkerLayer(
//                                 markers: [
//                                   Marker(
//                                     point: controller.currentLocation.value!,
//                                     width: 50,
//                                     height: 50,
//                                     child: const Icon(
//                                       Icons.my_location,
//                                       color: Colors.blue,
//                                       size: 40,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                             // ==================================================
//                             // SELECTED LOCATION
//                             // ==================================================
//                             if (controller.selectedLocation.value != null)
//                               MarkerLayer(
//                                 markers: [
//                                   Marker(
//                                     point: controller.selectedLocation.value!,
//                                     width: 55,
//                                     height: 55,
//                                     child: const Icon(
//                                       Icons.location_pin,
//                                       color: Colors.orange,
//                                       size: 50,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),

//                         // ==================================================
//                         // MAP INSTRUCTION
//                         // ==================================================
//                         Positioned(
//                           top: 12,
//                           left: 12,
//                           right: 12,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 14,
//                               vertical: 10,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withValues(alpha: 0.94),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Text(
//                               'Tap on the map to select the Geo-Tagging location',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                         ),

//                         // ==================================================
//                         // MAP BUTTONS
//                         // ==================================================
//                         Positioned(
//                           left: 12,
//                           bottom: 12,
//                           child: Column(
//                             children: [
//                               FloatingActionButton.small(
//                                 heroTag: 'geo_gps',
//                                 backgroundColor: const Color(0xff1565C0),
//                                 foregroundColor: Colors.white,
//                                 onPressed: controller.moveToCurrentLocation,
//                                 child: const Icon(Icons.my_location),
//                               ),
//                               const SizedBox(height: 10),
//                               FloatingActionButton.small(
//                                 heroTag: 'geo_layer',
//                                 backgroundColor: const Color(0xff1565C0),
//                                 foregroundColor: Colors.white,
//                                 onPressed: controller.changeMapType,
//                                 child: const Icon(Icons.layers),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // ==================================================
//                         // LOADING
//                         // ==================================================
//                         if (controller.isLoading.value)
//                           Container(
//                             color: Colors.black.withValues(alpha: 0.15),
//                             child: const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // ==================================================
//                   // LOCATION STATUS
//                   // ==================================================
//                   Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(18),
//                       child: Column(
//                         children: [
//                           const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Location Details',
//                               style: TextStyle(
//                                 fontSize: 19,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 18),

//                           // ==================================================
//                           // CURRENT LATITUDE / LONGITUDE
//                           // ==================================================
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _infoTile(
//                                   Icons.my_location,
//                                   'Current Latitude',
//                                   controller.latitude.value,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: _infoTile(
//                                   Icons.my_location,
//                                   'Current Longitude',
//                                   controller.longitude.value,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const Divider(height: 30),

//                           // ==================================================
//                           // ACCURACY + DISTANCE
//                           // ==================================================
//                           Row(
//                             children: [
//                               // ==================================================
//                               // GPS ACCURACY
//                               // ==================================================
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 24,
//                                       backgroundColor: controller.accuracyColor
//                                           .withValues(alpha: 0.12),
//                                       child: Icon(
//                                         Icons.gps_fixed,
//                                         color: controller.accuracyColor,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 8),

//                                     const Text(
//                                       'GPS Accuracy',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 5),

//                                     Text(
//                                       controller.accuracy.value.isEmpty
//                                           ? '--'
//                                           : controller.accuracy.value,
//                                       style: TextStyle(
//                                         color: controller.accuracyColor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // ==================================================
//                               // DISTANCE
//                               // ==================================================
//                               Expanded(
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 24,
//                                       backgroundColor:
//                                           controller.isWithinPhotoRadius
//                                           ? Colors.green.withValues(alpha: 0.12)
//                                           : Colors.red.withValues(alpha: 0.12),
//                                       child: Icon(
//                                         Icons.straighten,
//                                         color: controller.isWithinPhotoRadius
//                                             ? Colors.green.shade800
//                                             : Colors.red,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 8),

//                                     const Text(
//                                       'Distance',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),

//                                     const SizedBox(height: 5),

//                                     Text(
//                                       controller.selectedLocation.value == null
//                                           ? '--'
//                                           : '${controller.distanceFromSelectedLocation.value.toStringAsFixed(2)} m',
//                                       style: TextStyle(
//                                         color: controller.isWithinPhotoRadius
//                                             ? Colors.green.shade800
//                                             : Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const Divider(height: 30),

//                           // ==================================================
//                           // SELECTED LOCATION
//                           // ==================================================
//                           if (controller.selectedLocation.value != null)
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.withValues(alpha: 0.08),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Selected Location',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),

//                                   const SizedBox(height: 6),

//                                   Text(
//                                     'Latitude: ${controller.selectedLatitude.value}',
//                                   ),

//                                   Text(
//                                     'Longitude: ${controller.selectedLongitude.value}',
//                                   ),
//                                 ],
//                               ),
//                             ),

//                           const SizedBox(height: 12),

//                           // ==================================================
//                           // PHOTO ELIGIBILITY
//                           // ==================================================
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: controller.isWithinPhotoRadius
//                                   ? Colors.green.withValues(alpha: 0.08)
//                                   : Colors.red.withValues(alpha: 0.08),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               controller.selectedLocation.value == null
//                                   ? 'Select a location on the map.'
//                                   : !controller.isWithinPhotoRadius
//                                   ? 'Move within 30 m of the selected location to capture photos.'
//                                   : !controller.isAccuracyAcceptable
//                                   ? 'GPS accuracy must be acceptable before capturing photos.'
//                                   : controller.photo1Path.value.isNotEmpty &&
//                                         controller.photo2Path.value.isNotEmpty
//                                   ? 'Both photos captured successfully within the allowed 30 m radius. GPS accuracy: ${controller.accuracy.value}.'
//                                   : controller.photo1Path.value.isNotEmpty
//                                   ? 'Photo 1 captured successfully. Capture Photo 2 to complete both photos.'
//                                   : controller.photo2Path.value.isNotEmpty
//                                   ? 'Photo 2 captured successfully. Capture Photo 1 to complete both photos.'
//                                   : 'You are within the allowed 30 m radius. GPS accuracy: ${controller.accuracy.value}. Photos can be captured.',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: controller.selectedLocation.value == null
//                                     ? Colors.grey.shade700
//                                     : controller.isWithinPhotoRadius &&
//                                           controller.isAccuracyAcceptable
//                                     ? Colors.green.shade800
//                                     : Colors.red,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // ==================================================
//                   // PHOTO 1 + PHOTO 2
//                   // ==================================================
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: _photoCard(
//                           title: 'Photo 1',
//                           imagePath: controller.photo1Path.value,
//                           latitude: controller.photo1Latitude.value,
//                           longitude: controller.photo1Longitude.value,
//                           dateTime: controller.photo1DateTime.value,
//                           enabled:
//                               controller.isWithinPhotoRadius &&
//                               controller.isAccuracyAcceptable,
//                           onTap: controller.capturePhoto1,
//                           onRemove: controller.removePhoto1,
//                         ),
//                       ),

//                       const SizedBox(width: 15),

//                       Expanded(
//                         child: _photoCard(
//                           title: 'Photo 2',
//                           imagePath: controller.photo2Path.value,
//                           latitude: controller.photo2Latitude.value,
//                           longitude: controller.photo2Longitude.value,
//                           dateTime: controller.photo2DateTime.value,
//                           enabled:
//                               controller.isWithinPhotoRadius &&
//                               controller.isAccuracyAcceptable,
//                           onTap: controller.capturePhoto2,
//                           onRemove: controller.removePhoto2,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // ==================================================
//                   // REMARKS
//                   // ==================================================
//                   Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(18),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Remarks',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),

//                           const SizedBox(height: 15),

//                           TextField(
//                             controller: controller.remarksController,
//                             maxLines: 4,
//                             decoration: InputDecoration(
//                               hintText: 'Enter remarks (Optional)',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // ==================================================
//                   // BUTTONS
//                   // ==================================================
//                   Row(
//                     children: [
//                       // ==================================================
//                       // CANCEL
//                       // ==================================================
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: controller.cancel,
//                           style: OutlinedButton.styleFrom(
//                             minimumSize: const Size.fromHeight(55),
//                             foregroundColor: Colors.red,
//                             side: const BorderSide(color: Colors.red),
//                           ),
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: 15),

//                       // ==================================================
//                       // SAVE DATA
//                       // ==================================================
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: controller.isSaving.value
//                               ? null
//                               : controller.saveData,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade800,
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size.fromHeight(55),
//                           ),
//                           child: controller.isSaving.value
//                               ? const SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               : const Text(
//                                   'Save Data',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ==========================================================
//   // INFO TILE
//   // ==========================================================

//   Widget _infoTile(IconData icon, String title, String value) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 24,
//           backgroundColor: const Color(0xff1565C0).withValues(alpha: 0.08),
//           child: Icon(icon, color: const Color(0xff1565C0)),
//         ),

//         const SizedBox(height: 8),

//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//         ),

//         const SizedBox(height: 5),

//         Text(value.isEmpty ? '--' : value, textAlign: TextAlign.center),
//       ],
//     );
//   }

//   // ==========================================================
//   // PHOTO CARD
//   // ==========================================================

//   Widget _photoCard({
//     required String title,
//     required String imagePath,
//     required String latitude,
//     required String longitude,
//     required String dateTime,
//     required bool enabled,
//     required VoidCallback onTap,
//     required VoidCallback onRemove,
//   }) {
//     final bool hasImage = imagePath.isNotEmpty;

//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(18),
//         onTap: enabled ? onTap : null,
//         child: Opacity(
//           opacity: enabled || hasImage ? 1.0 : 0.45,
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 // ==================================================
//                 // IMAGE
//                 // ==================================================
//                 SizedBox(
//                   height: 170,
//                   width: double.infinity,
//                   child: hasImage
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.file(File(imagePath), fit: BoxFit.cover),
//                         )
//                       : Container(
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Center(
//                             child: Icon(
//                               Icons.camera_alt,
//                               size: 50,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ),
//                 ),

//                 const SizedBox(height: 12),

//                 // ==================================================
//                 // PHOTO TITLE
//                 // ==================================================
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),

//                 const SizedBox(height: 7),

//                 // ==================================================
//                 // CAPTURE / RETAKE TEXT
//                 // ==================================================
//                 Text(
//                   hasImage
//                       ? 'Tap on the Photo to Retake'
//                       : enabled
//                       ? 'Tap to Capture'
//                       : 'Within 30 m required',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),

//                 // ==================================================
//                 // PHOTO DETAILS
//                 // ==================================================
//                 if (hasImage &&
//                     latitude.isNotEmpty &&
//                     longitude.isNotEmpty) ...[
//                   const SizedBox(height: 10),

//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(9),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Lat: $latitude',
//                           style: const TextStyle(fontSize: 11),
//                         ),
//                         Text(
//                           'Long: $longitude',
//                           style: const TextStyle(fontSize: 11),
//                         ),
//                         Text(dateTime, style: const TextStyle(fontSize: 11)),
//                       ],
//                     ),
//                   ),

//                   // ==================================================
//                   // REMOVE PHOTO
//                   // ==================================================
//                   TextButton.icon(
//                     onPressed: onRemove,
//                     icon: const Icon(Icons.delete_outline, color: Colors.red),
//                     label: const Text(
//                       'Remove',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'geotagging_controller.dart';
import '../../widgets/common_footer.dart';

class GeoTaggingScreen extends StatelessWidget {
  GeoTaggingScreen({super.key});

  final GeoTaggingController controller = Get.find<GeoTaggingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background.jpg',
          ), // Or NetworkImage('url')
          fit: BoxFit.cover, // Ensures the image fills the entire screen
        ),
      ),
      child: Scaffold(
        // backgroundColor: const Color(0xffF4F7FA),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CommonFooter(),

        // ========================================================
        // APP BAR
        // ========================================================
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xff1565C0),
          foregroundColor: Colors.white,
          title: const Text(
            'Geo Tagging',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // ========================================================
        // BODY
        // ========================================================
        body: Obx(
          () => SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ==================================================
                  // MAP
                  // ==================================================
                  Container(
                    height: 330,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
                      ],
                    ),
                    child: Stack(
                      children: [
                        FlutterMap(
                          mapController: controller.mapController,
                          options: MapOptions(
                            initialCenter:
                                controller.currentLocation.value ??
                                const LatLng(15.3173, 75.7139),
                            initialZoom: controller.initialZoom,
                            // Disable map rotation while retaining pan and zoom.
                            interactionOptions: const InteractionOptions(
                              flags:
                                  InteractiveFlag.all & ~InteractiveFlag.rotate,
                            ),
                            onMapReady: controller.onMapReady,
                            onTap: (TapPosition tapPosition, LatLng point) {
                              controller.onMapTap(tapPosition, point);
                            },
                          ),
                          children: [
                            // ==================================================
                            // MAP TILE
                            // ==================================================
                            TileLayer(
                              urlTemplate: controller.satelliteMap.value
                                  ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                                  : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'com.ksrsac.namma_kaimagga_app',
                            ),

                            // ==================================================
                            // 30 METRE RADIUS CIRCLES
                            // Blue circle: current GPS location.
                            // Orange circle: selected geo-tagging location.
                            // ==================================================
                            CircleLayer(
                              circles: [
                                if (controller.currentLocation.value != null)
                                  CircleMarker(
                                    point: controller.currentLocation.value!,
                                    radius: 30,
                                    useRadiusInMeter: true,
                                    color: Colors.blue.withValues(alpha: 0.16),
                                    borderColor: Colors.blue,
                                    borderStrokeWidth: 2,
                                  ),
                                // if (controller.selectedLocation.value != null)
                                //   CircleMarker(
                                //     point: controller.selectedLocation.value!,
                                //     radius: 30,
                                //     useRadiusInMeter: true,
                                //     color: Colors.orange.withValues(
                                //       alpha: 0.20,
                                //     ),
                                //     borderColor: Colors.deepOrange,
                                //     borderStrokeWidth: 2,
                                //   ),
                              ],
                            ),

                            // ==================================================
                            // CURRENT LOCATION
                            // ==================================================
                            if (controller.currentLocation.value != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: controller.currentLocation.value!,
                                    width: 50,
                                    height: 50,
                                    child: const Icon(
                                      Icons.my_location,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),

                            // ==================================================
                            // SELECTED LOCATION
                            // ==================================================
                            if (controller.selectedLocation.value != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: controller.selectedLocation.value!,
                                    width: 55,
                                    height: 55,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.orange,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),

                        // ==================================================
                        // MAP INSTRUCTION
                        // ==================================================
                        Positioned(
                          top: 12,
                          left: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.94),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Tap on the map to select the Geo-Tagging location',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),

                        // ==================================================
                        // MAP BUTTONS
                        // ==================================================
                        // Existing GPS and map-layer controls on the left.
                        Positioned(
                          left: 12,
                          bottom: 12,
                          child: Column(
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'geo_gps',
                                backgroundColor: const Color(0xff1565C0),
                                foregroundColor: Colors.white,
                                onPressed: controller.moveToCurrentLocation,
                                child: const Icon(Icons.my_location),
                              ),
                              const SizedBox(height: 10),
                              FloatingActionButton.small(
                                heroTag: 'geo_layer',
                                backgroundColor: const Color(0xff1565C0),
                                foregroundColor: Colors.white,
                                onPressed: controller.changeMapType,
                                child: const Icon(Icons.layers),
                              ),
                            ],
                          ),
                        ),

                        // ==================================================
                        // MAP ZOOM CONTROLS ON THE RIGHT
                        // ==================================================
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: Column(
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'geo_zoom_in',
                                tooltip: 'Zoom in',
                                backgroundColor: const Color(0xff1565C0),
                                foregroundColor: Colors.white,
                                onPressed: controller.zoomIn,
                                child: const Icon(Icons.add),
                              ),
                              const SizedBox(height: 10),
                              FloatingActionButton.small(
                                heroTag: 'geo_zoom_out',
                                tooltip: 'Zoom out',
                                backgroundColor: const Color(0xff1565C0),
                                foregroundColor: Colors.white,
                                onPressed: controller.zoomOut,
                                child: const Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ),

                        // ==================================================
                        // LOADING
                        // ==================================================
                        if (controller.isLoading.value)
                          Container(
                            color: Colors.black.withValues(alpha: 0.15),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // LOCATION STATUS
                  // ==================================================
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location Details',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // ==================================================
                          // CURRENT LATITUDE / LONGITUDE
                          // ==================================================
                          Row(
                            children: [
                              Expanded(
                                child: _infoTile(
                                  Icons.my_location,
                                  'Current Latitude',
                                  controller.latitude.value,
                                ),
                              ),
                              Expanded(
                                child: _infoTile(
                                  Icons.my_location,
                                  'Current Longitude',
                                  controller.longitude.value,
                                ),
                              ),
                            ],
                          ),

                          const Divider(height: 30),

                          // ==================================================
                          // ACCURACY + DISTANCE
                          // ==================================================
                          Row(
                            children: [
                              // ==================================================
                              // GPS ACCURACY
                              // ==================================================
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: controller.accuracyColor
                                          .withValues(alpha: 0.12),
                                      child: Icon(
                                        Icons.gps_fixed,
                                        color: controller.accuracyColor,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    const Text(
                                      'GPS Accuracy',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      controller.accuracy.value.isEmpty
                                          ? '--'
                                          : controller.accuracy.value,
                                      style: TextStyle(
                                        color: controller.accuracyColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ==================================================
                              // DISTANCE
                              // ==================================================
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor:
                                          controller.isWithinPhotoRadius
                                          ? Colors.green.withValues(alpha: 0.12)
                                          : Colors.red.withValues(alpha: 0.12),
                                      child: Icon(
                                        Icons.straighten,
                                        color: controller.isWithinPhotoRadius
                                            ? Colors.green.shade800
                                            : Colors.red,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    const Text(
                                      'Distance',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      controller.selectedLocation.value == null
                                          ? '--'
                                          : '${controller.distanceFromSelectedLocation.value.toStringAsFixed(2)} m',
                                      style: TextStyle(
                                        color: controller.isWithinPhotoRadius
                                            ? Colors.green.shade800
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const Divider(height: 30),

                          // ==================================================
                          // SELECTED LOCATION
                          // ==================================================
                          if (controller.selectedLocation.value != null)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Selected Location',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    'Latitude: ${controller.selectedLatitude.value}',
                                  ),

                                  Text(
                                    'Longitude: ${controller.selectedLongitude.value}',
                                  ),
                                ],
                              ),
                            ),

                          const SizedBox(height: 12),

                          // ==================================================
                          // PHOTO ELIGIBILITY
                          // ==================================================
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: controller.isWithinPhotoRadius
                                  ? Colors.green.withValues(alpha: 0.08)
                                  : Colors.red.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              controller.selectedLocation.value == null
                                  ? 'Select a location on the map.'
                                  : !controller.isWithinPhotoRadius
                                  ? 'Move within 30 m of the selected location to capture photos.'
                                  : !controller.isAccuracyAcceptable
                                  ? 'GPS accuracy must be acceptable before capturing photos.'
                                  : controller.photo1Path.value.isNotEmpty &&
                                        controller.photo2Path.value.isNotEmpty
                                  ? 'Both photos captured successfully within the allowed 30 m radius. GPS accuracy: ${controller.accuracy.value}.'
                                  : controller.photo1Path.value.isNotEmpty
                                  ? 'Photo 1 captured successfully. Capture Photo 2 to complete both photos.'
                                  : controller.photo2Path.value.isNotEmpty
                                  ? 'Photo 2 captured successfully. Capture Photo 1 to complete both photos.'
                                  : 'You are within the allowed 30 m radius. GPS accuracy: ${controller.accuracy.value}. Photos can be captured.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: controller.selectedLocation.value == null
                                    ? Colors.grey.shade700
                                    : controller.isWithinPhotoRadius &&
                                          controller.isAccuracyAcceptable
                                    ? Colors.green.shade800
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // PHOTO 1 + PHOTO 2
                  // ==================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _photoCard(
                          title: 'Photo 1',
                          imagePath: controller.photo1Path.value,
                          latitude: controller.photo1Latitude.value,
                          longitude: controller.photo1Longitude.value,
                          dateTime: controller.photo1DateTime.value,
                          enabled:
                              controller.isWithinPhotoRadius &&
                              controller.isAccuracyAcceptable,
                          onTap: controller.capturePhoto1,
                          onRemove: controller.removePhoto1,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: _photoCard(
                          title: 'Photo 2',
                          imagePath: controller.photo2Path.value,
                          latitude: controller.photo2Latitude.value,
                          longitude: controller.photo2Longitude.value,
                          dateTime: controller.photo2DateTime.value,
                          enabled:
                              controller.isWithinPhotoRadius &&
                              controller.isAccuracyAcceptable,
                          onTap: controller.capturePhoto2,
                          onRemove: controller.removePhoto2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // REMARKS
                  // ==================================================
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
                            'Remarks',
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
                              hintText: 'Enter remarks (Optional)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // BUTTONS
                  // ==================================================
                  Row(
                    children: [
                      // ==================================================
                      // CANCEL
                      // ==================================================
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.cancel,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(55),
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // ==================================================
                      // SAVE DATA
                      // ==================================================
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isSaving.value
                              ? null
                              : controller.saveData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade800,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(55),
                          ),
                          child: controller.isSaving.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Save Data',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }

  // ==========================================================
  // INFO TILE
  // ==========================================================

  Widget _infoTile(IconData icon, String title, String value) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xff1565C0).withValues(alpha: 0.08),
          child: Icon(icon, color: const Color(0xff1565C0)),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),

        const SizedBox(height: 5),

        Text(value.isEmpty ? '--' : value, textAlign: TextAlign.center),
      ],
    );
  }

  // ==========================================================
  // PHOTO CARD
  // ==========================================================

  Widget _photoCard({
    required String title,
    required String imagePath,
    required String latitude,
    required String longitude,
    required String dateTime,
    required bool enabled,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    final bool hasImage = imagePath.isNotEmpty;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: enabled ? onTap : null,
        child: Opacity(
          opacity: enabled || hasImage ? 1.0 : 0.45,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // ==================================================
                // IMAGE
                // ==================================================
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(File(imagePath), fit: BoxFit.cover),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.green,
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 12),

                // ==================================================
                // PHOTO TITLE
                // ==================================================
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 7),

                // ==================================================
                // CAPTURE / RETAKE TEXT
                // ==================================================
                Text(
                  hasImage
                      ? 'Tap on the Photo to Retake'
                      : enabled
                      ? 'Tap to Capture'
                      : 'Within 30 m required',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),

                // ==================================================
                // PHOTO DETAILS
                // ==================================================
                if (hasImage &&
                    latitude.isNotEmpty &&
                    longitude.isNotEmpty) ...[
                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lat: $latitude',
                          style: const TextStyle(fontSize: 11),
                        ),
                        Text(
                          'Long: $longitude',
                          style: const TextStyle(fontSize: 11),
                        ),
                        Text(dateTime, style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),

                  // ==================================================
                  // REMOVE PHOTO
                  // ==================================================
                  TextButton.icon(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
