// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// class CommonHeaderController extends GetxController {
//   // ============================================================
//   // USER INFORMATION
//   // ============================================================

//   final mobileNumber = ''.obs;
//   final districtName = ''.obs;
//   final talukName = ''.obs;

//   // ============================================================
//   // DEVICE / GPS INFORMATION
//   // ============================================================

//   final deviceMacId = 'Not Available'.obs;

//   final latitude = '--'.obs;
//   final longitude = '--'.obs;
//   final gpsAccuracy = '--'.obs;

//   final dateTime = '--'.obs;

//   Stream<Position>? _positionStream;

//   @override
//   void onInit() {
//     super.onInit();

//     loadUserInformation();
//     initializeLocation();
//   }

//   // ============================================================
//   // LOAD USER INFORMATION
//   // ============================================================

//   void loadUserInformation() {
//     /*
//      * Replace these values with your actual stored login values.
//      *
//      * For now these are placeholders.
//      */

//     mobileNumber.value = '';
//     districtName.value = '';
//     talukName.value = '';

//     /*
//      * If you already store these values using SharedPreferences,
//      * load them here.
//      */
//   }

//   // ============================================================
//   // INITIALIZE LOCATION
//   // ============================================================

//   Future<void> initializeLocation() async {
//     try {
//       bool serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         debugPrint('LOCATION SERVICE DISABLED');
//         return;
//       }

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         debugPrint('LOCATION PERMISSION DENIED');
//         return;
//       }

//       if (permission ==
//           LocationPermission.deniedForever) {
//         debugPrint(
//           'LOCATION PERMISSION PERMANENTLY DENIED',
//         );
//         return;
//       }

//       // Get initial location
//       final position =
//           await Geolocator.getCurrentPosition(
//         locationSettings:
//             const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );

//       updatePosition(position);

//       // Continue listening for location changes
//       _positionStream =
//           Geolocator.getPositionStream(
//         locationSettings:
//             const LocationSettings(
//           accuracy: LocationAccuracy.high,
//           distanceFilter: 1,
//         ),
//       );

//       _positionStream!.listen(
//         updatePosition,
//       );
//     } catch (e) {
//       debugPrint(
//         'LOCATION ERROR: $e',
//       );
//     }
//   }

//   // ============================================================
//   // UPDATE GPS INFORMATION
//   // ============================================================

//   void updatePosition(Position position) {
//     latitude.value =
//         position.latitude.toStringAsFixed(6);

//     longitude.value =
//         position.longitude.toStringAsFixed(6);

//     gpsAccuracy.value =
//         position.accuracy.toStringAsFixed(2);

//     dateTime.value =
//         DateFormat(
//           'dd-MM-yyyy HH:mm:ss',
//         ).format(
//           DateTime.now(),
//         );

//     debugPrint(
//       'CURRENT GPS: ${latitude.value}, ${longitude.value}',
//     );

//     debugPrint(
//       'GPS ACCURACY: ${gpsAccuracy.value} metre',
//     );

//     debugPrint(
//       'DATE TIME: ${dateTime.value}',
//     );
//   }

//   // ============================================================
//   // UPDATE USER DETAILS
//   // ============================================================

//   void updateUserDetails({
//     String? mobile,
//     String? district,
//     String? taluk,
//   }) {
//     if (mobile != null) {
//       mobileNumber.value = mobile;
//     }

//     if (district != null) {
//       districtName.value = district;
//     }

//     if (taluk != null) {
//       talukName.value = taluk;
//     }
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }

// // ================================================================
// // COMMON HEADER WIDGET
// // ================================================================

// class CommonHeader extends StatelessWidget {
//   const CommonHeader({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller =
//         Get.find<CommonHeaderController>();

//     return Obx(
//       () {
//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(
//             16,
//             12,
//             16,
//             12,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [

//               // ==================================================
//               // USER / DISTRICT / TALUK ROW
//               // ==================================================

//               Row(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.center,
//                 children: [

//                   // USER AVATAR
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.blue.shade50,
//                     ),
//                     child: Icon(
//                       Icons.person,
//                       size: 28,
//                       color: Colors.blue.shade700,
//                     ),
//                   ),

//                   const SizedBox(width: 12),

//                   // MOBILE NUMBER
//                   Expanded(
//                     child: Text(
//                       'Mobile No.: ${controller.mobileNumber.value.isEmpty ? '--' : controller.mobileNumber.value}',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 8),

//                   // DISTRICT / TALUK
//                   Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.end,
//                     children: [

//                       Text(
//                         'District: ${controller.districtName.value.isEmpty ? '--' : controller.districtName.value}',
//                         textAlign: TextAlign.right,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),

//                       const SizedBox(height: 5),

//                       Text(
//                         'Taluk: ${controller.talukName.value.isEmpty ? '--' : controller.talukName.value}',
//                         textAlign: TextAlign.right,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               const Divider(
//                 height: 1,
//               ),

//               const SizedBox(height: 10),

//               // ==================================================
//               // DEVICE MAC ID
//               // ==================================================

//               _InfoRow(
//                 label: 'Device Mac ID',
//                 value:
//                     controller.deviceMacId.value,
//               ),

//               const SizedBox(height: 6),

//               // ==================================================
//               // CURRENT GPS
//               // ==================================================

//               _InfoRow(
//                 label: 'Current GPS',
//                 value:
//                     '${controller.latitude.value}, ${controller.longitude.value}',
//               ),

//               const SizedBox(height: 6),

//               // ==================================================
//               // DATE AND TIME
//               // ==================================================

//               _InfoRow(
//                 label: 'Date and Time',
//                 value:
//                     controller.dateTime.value,
//               ),

//               const SizedBox(height: 6),

//               // ==================================================
//               // GPS ACCURACY
//               // ==================================================

//               _InfoRow(
//                 label: 'Your GPS Accuracy is',
//                 value:
//                     '${controller.gpsAccuracy.value} metre',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // ================================================================
// // INFORMATION ROW
// // ================================================================

// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoRow({
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment:
//           CrossAxisAlignment.start,
//       children: [

//         SizedBox(
//           width: 155,
//           child: Text(
//             '$label:',
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),

//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// import '../device_id_service.dart';

// class CommonHeader extends StatefulWidget {
//   final String mobileNumber;
//   final String districtName;
//   final String talukName;

//   const CommonHeader({
//     super.key,
//     required this.mobileNumber,
//     required this.districtName,
//     required this.talukName,
//   });

//   @override
//   State<CommonHeader> createState() => _CommonHeaderState();
// }

// class _CommonHeaderState extends State<CommonHeader> {
//   String? deviceId;
//   String currentTime = '';

//   double? latitude;
//   double? longitude;
//   double? gpsAccuracy;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeHeader();
//     });
//   }

//   Future<void> _initializeHeader() async {
//     _getCurrentTime();

//     await _loadDeviceId();

//     await _getCurrentLocation();
//   }

//   // ---------------------------------------------------------------------------
//   // DEVICE ID
//   // ---------------------------------------------------------------------------

//   Future<void> _loadDeviceId() async {
//     try {
//       final id = await DeviceIdService.getOrCreateDeviceId();

//       if (!mounted) return;

//       setState(() {
//         deviceId = id;
//       });
//     } catch (e) {
//       debugPrint('DEVICE ID ERROR: $e');

//       if (!mounted) return;

//       setState(() {
//         deviceId = 'Not Available';
//       });
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // DATE & TIME
//   // ---------------------------------------------------------------------------

//   void _getCurrentTime() {
//     final now = DateTime.now();

//     final formatted =
//         DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

//     if (!mounted) return;

//     setState(() {
//       currentTime = formatted;
//     });
//   }

//   // ---------------------------------------------------------------------------
//   // LOCATION
//   // ---------------------------------------------------------------------------

//   Future<void> _getCurrentLocation() async {
//     try {
//       final serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         debugPrint('LOCATION SERVICE DISABLED');
//         return;
//       }

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();

//         if (permission == LocationPermission.denied) {
//           debugPrint('LOCATION PERMISSION DENIED');
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         debugPrint('LOCATION PERMISSION PERMANENTLY DENIED');
//         return;
//       }

//       final position =
//           await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       if (!mounted) return;

//       setState(() {
//         latitude = position.latitude;
//         longitude = position.longitude;
//         gpsAccuracy = position.accuracy;
//       });

//       debugPrint(
//         'CURRENT GPS: ${position.latitude}, ${position.longitude}',
//       );

//       debugPrint(
//         'GPS ACCURACY: ${position.accuracy} metre',
//       );
//     } catch (e) {
//       debugPrint('LOCATION ERROR: $e');
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // TEXT VALUE
//   // ---------------------------------------------------------------------------

//   Widget _buildValue({
//     required String label,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 3),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------
//   // HEADER UI
//   // ---------------------------------------------------------------------------

//   @override
//   Widget build(BuildContext context) {
//     final gpsText =
//         latitude != null && longitude != null
//             ? '${latitude!.toStringAsFixed(6)}, '
//               '${longitude!.toStringAsFixed(6)}'
//             : 'Loading...';

//     final accuracyText =
//         gpsAccuracy != null
//             ? '${gpsAccuracy!.toStringAsFixed(2)} metre'
//             : 'Loading...';

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       child: Column(
//         children: [
//           // -------------------------------------------------------------------
//           // USER INFORMATION ROW
//           // -------------------------------------------------------------------

//           Container(
//             width: double.infinity,
//             color: Colors.blueAccent,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 7,
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // USER AVATAR
//                 const CircleAvatar(
//                   radius: 22,
//                   backgroundColor: Colors.white,
//                   child: Icon(
//                     Icons.person,
//                     color: Colors.blueAccent,
//                     size: 27,
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 // MOBILE NUMBER
//                 Expanded(
//                   child: Text(
//                     'Mobile No.: ${widget.mobileNumber}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 // DISTRICT + TALUK
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'District: ${widget.districtName}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'Taluk: ${widget.talukName}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 1),

//           // -------------------------------------------------------------------
//           // DEVICE / GPS / DATE-TIME INFORMATION
//           // -------------------------------------------------------------------

//           Container(
//             width: double.infinity,
//             color: Colors.blueAccent,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 6,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildValue(
//                   label: 'Device Mac ID: ',
//                   value: deviceId ?? 'Loading...',
//                 ),

//                 _buildValue(
//                   label: 'Current GPS: ',
//                   value: gpsText,
//                 ),

//                 _buildValue(
//                   label: 'Date and Time: ',
//                   value: currentTime.isEmpty
//                       ? 'Loading...'
//                       : currentTime,
//                 ),

//                 _buildValue(
//                   label: 'Your GPS Accuracy is: ',
//                   value: accuracyText,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';

// import '../device_id_service.dart';

// class CommonHeaderDetails extends StatefulWidget {
//   const CommonHeaderDetails({super.key});

//   @override
//   State<CommonHeaderDetails> createState() =>
//       _CommonHeaderDetailsState();
// }

// class _CommonHeaderDetailsState
//     extends State<CommonHeaderDetails> {
//   String? deviceId;

//   String currentTime = '';

//   double? latitude;
//   double? longitude;
//   double? gpsAccuracy;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeHeader();
//     });
//   }

//   Future<void> _initializeHeader() async {
//     _getCurrentTime();

//     await _loadDeviceId();

//     await _getCurrentLocation();
//   }

//   // =============================================================
//   // DEVICE ID
//   // =============================================================

//   Future<void> _loadDeviceId() async {
//     try {
//       final id =
//           await DeviceIdService.getOrCreateDeviceId();

//       if (!mounted) return;

//       setState(() {
//         deviceId = id;
//       });
//     } catch (e) {
//       debugPrint(
//         'DEVICE ID ERROR: $e',
//       );

//       if (!mounted) return;

//       setState(() {
//         deviceId = 'Not Available';
//       });
//     }
//   }

//   // =============================================================
//   // DATE AND TIME
//   // =============================================================

//   void _getCurrentTime() {
//     final now = DateTime.now();

//     final formatted =
//         DateFormat('dd-MM-yyyy HH:mm:ss')
//             .format(now);

//     if (!mounted) return;

//     setState(() {
//       currentTime = formatted;
//     });
//   }

//   // =============================================================
//   // GPS
//   // =============================================================

//   Future<void> _getCurrentLocation() async {
//     try {
//       final serviceEnabled =
//           await Geolocator.isLocationServiceEnabled();

//       if (!serviceEnabled) {
//         debugPrint(
//           'LOCATION SERVICE DISABLED',
//         );
//         return;
//       }

//       LocationPermission permission =
//           await Geolocator.checkPermission();

//       if (permission ==
//           LocationPermission.denied) {
//         permission =
//             await Geolocator.requestPermission();

//         if (permission ==
//             LocationPermission.denied) {
//           debugPrint(
//             'LOCATION PERMISSION DENIED',
//           );
//           return;
//         }
//       }

//       if (permission ==
//           LocationPermission.deniedForever) {
//         debugPrint(
//           'LOCATION PERMISSION PERMANENTLY DENIED',
//         );
//         return;
//       }

//       final position =
//           await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       if (!mounted) return;

//       setState(() {
//         latitude = position.latitude;
//         longitude = position.longitude;
//         gpsAccuracy = position.accuracy;
//       });

//       debugPrint(
//         'CURRENT GPS: '
//         '${position.latitude}, '
//         '${position.longitude}',
//       );

//       debugPrint(
//         'GPS ACCURACY: '
//         '${position.accuracy} metre',
//       );
//     } catch (e) {
//       debugPrint(
//         'LOCATION ERROR: $e',
//       );
//     }
//   }

//   // =============================================================
//   // DETAIL ROW
//   // =============================================================

//   Widget _buildDetailRow({
//     required String label,
//     required String value,
//     required IconData icon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         bottom: 6,
//       ),
//       child: Row(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             color: Colors.white70,
//             size: 15,
//           ),

//           const SizedBox(width: 7),

//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 11.5,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(width: 3),

//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 11.5,
//                 fontWeight: FontWeight.bold,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final gpsText =
//         latitude != null && longitude != null
//             ? '${latitude!.toStringAsFixed(6)}, '
//               '${longitude!.toStringAsFixed(6)}'
//             : 'Loading...';

//     final accuracyText =
//         gpsAccuracy != null
//             ? '${gpsAccuracy!.toStringAsFixed(2)} metre'
//             : 'Loading...';

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(
//         15,
//         13,
//         15,
//         7,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(
//           alpha: 0.12,
//         ),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: Colors.white.withValues(
//             alpha: 0.18,
//           ),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: [
//           // ======================================================
//           // DEVICE MAC ID
//           // ======================================================

//           _buildDetailRow(
//             icon: Icons.smartphone,
//             label: 'Device Mac ID:',
//             value: deviceId ?? 'Loading...',
//           ),

//           // ======================================================
//           // GPS
//           // ======================================================

//           _buildDetailRow(
//             icon: Icons.gps_fixed,
//             label: 'Current GPS:',
//             value: gpsText,
//           ),

//           // ======================================================
//           // DATE AND TIME
//           // ======================================================

//           _buildDetailRow(
//             icon: Icons.access_time,
//             label: 'Date and Time:',
//             value: currentTime.isEmpty
//                 ? 'Loading...'
//                 : currentTime,
//           ),

//           // ======================================================
//           // GPS ACCURACY
//           // ======================================================

//           _buildDetailRow(
//             icon: Icons.gps_not_fixed,
//             label: 'Your GPS Accuracy is:',
//             value: accuracyText,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../device_id_service.dart';

class CommonHeader extends StatefulWidget {
  final String mobileNumber;
  final String districtName;
  final String talukName;

  const CommonHeader({
    super.key,
    required this.mobileNumber,
    required this.districtName,
    required this.talukName,
  });

  @override
  State<CommonHeader> createState() => _CommonHeaderState();
}

class _CommonHeaderState extends State<CommonHeader> {
  String? deviceId;
  String currentTime = '';

  double? latitude;
  double? longitude;
  double? gpsAccuracy;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeHeader();
    });
  }

  Future<void> _initializeHeader() async {
    _getCurrentTime();

    await _loadDeviceId();

    await _getCurrentLocation();
  }

  // =============================================================
  // DEVICE ID
  // =============================================================

  Future<void> _loadDeviceId() async {
    try {
      final id = await DeviceIdService.getOrCreateDeviceId();

      debugPrint('DEVICE MAC ID: $id');

      if (!mounted) return;

      setState(() {
        deviceId = id;
      });
    } catch (e) {
      debugPrint('DEVICE ID ERROR: $e');

      if (!mounted) return;

      setState(() {
        deviceId = 'Not Available';
      });
    }
  }

  // =============================================================
  // DATE AND TIME
  // =============================================================

  void _getCurrentTime() {
    final formatted =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    if (!mounted) return;

    setState(() {
      currentTime = formatted;
    });
  }

  // =============================================================
  // GPS LOCATION
  // =============================================================

  Future<void> _getCurrentLocation() async {
    try {
      final serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        debugPrint('LOCATION SERVICE DISABLED');
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          debugPrint('LOCATION PERMISSION DENIED');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint(
          'LOCATION PERMISSION PERMANENTLY DENIED',
        );
        return;
      }

      final position =
          await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        gpsAccuracy = position.accuracy;
      });

      debugPrint(
        'CURRENT GPS: '
        '${position.latitude}, ${position.longitude}',
      );

      debugPrint(
        'GPS ACCURACY: '
        '${position.accuracy} metre',
      );
    } catch (e) {
      debugPrint('LOCATION ERROR: $e');
    }
  }

  // =============================================================
  // COMMON DETAIL ROW
  // =============================================================

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 17,
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    final gpsText =
        latitude != null && longitude != null
            ? '${latitude!.toStringAsFixed(6)}, '
                '${longitude!.toStringAsFixed(6)}'
            : 'Loading...';

    final accuracyText =
        gpsAccuracy != null
            ? '${gpsAccuracy!.toStringAsFixed(2)} metre'
            : 'Loading...';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xff1565C0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // MOBILE NUMBER
            // =====================================================

            _detailRow(
              icon: Icons.phone,
              label: 'Mobile No.:',
              value: widget.mobileNumber.isEmpty
                  ? 'Not Available'
                  : widget.mobileNumber,
            ),

            // =====================================================
            // DISTRICT
            // =====================================================

            _detailRow(
              icon: Icons.location_city,
              label: 'District:',
              value: widget.districtName.isEmpty
                  ? 'Not Available'
                  : widget.districtName,
            ),

            // =====================================================
            // TALUK
            // =====================================================

            _detailRow(
              icon: Icons.location_on,
              label: 'Taluk:',
              value: widget.talukName.isEmpty
                  ? 'Not Available'
                  : widget.talukName,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: Colors.white30,
                height: 1,
              ),
            ),

            // =====================================================
            // DEVICE MAC ID
            // =====================================================

            _detailRow(
              icon: Icons.smartphone,
              label: 'Device Mac ID:',
              value: deviceId ?? 'Loading...',
            ),

            // =====================================================
            // CURRENT GPS
            // =====================================================

            _detailRow(
              icon: Icons.gps_fixed,
              label: 'Current GPS:',
              value: gpsText,
            ),

            // =====================================================
            // DATE AND TIME
            // =====================================================

            _detailRow(
              icon: Icons.access_time,
              label: 'Date and Time:',
              value: currentTime.isEmpty
                  ? 'Loading...'
                  : currentTime,
            ),

            // =====================================================
            // GPS ACCURACY
            // =====================================================

            _detailRow(
              icon: Icons.my_location,
              label: 'Your GPS Accuracy is:',
              value: accuracyText,
            ),
          ],
        ),
      ),
    );
  }
}