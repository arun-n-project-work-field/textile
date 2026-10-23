import 'dart:async';

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
  Timer? _clockTimer;
  Timer? _locationTimer;

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();

    // Keep the dashboard date/time display updating every second.
    _getCurrentTime();

    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _getCurrentTime(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeHeader();

      // Refresh GPS coordinates every 20 seconds.
      _locationTimer = Timer.periodic(
        const Duration(seconds: 20),
        (_) => _getCurrentLocation(),
      );
    });
  }

  Future<void> _initializeHeader() async {
    await _loadDeviceId();
    await _getCurrentLocation();
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _locationTimer?.cancel();
    super.dispose();
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
    final formatted = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

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
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        debugPrint('LOCATION SERVICE DISABLED');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          debugPrint('LOCATION PERMISSION DENIED');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('LOCATION PERMISSION PERMANENTLY DENIED');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });

      debugPrint(
        'CURRENT GPS: '
        '${position.latitude}, ${position.longitude}',
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 17),
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
    final gpsText = latitude != null && longitude != null
        ? '${latitude!.toStringAsFixed(6)}, '
              '${longitude!.toStringAsFixed(6)}'
        : 'Loading...';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
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
          border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MOBILE NUMBER
            _detailRow(
              icon: Icons.phone,
              label: 'Mobile No.:',
              value: widget.mobileNumber.isEmpty
                  ? 'Not Available'
                  : widget.mobileNumber,
            ),

            // DISTRICT
            _detailRow(
              icon: Icons.location_city,
              label: 'District:',
              value: widget.districtName.isEmpty
                  ? 'Not Available'
                  : widget.districtName,
            ),

            // TALUK
            _detailRow(
              icon: Icons.location_on,
              label: 'Taluk:',
              value: widget.talukName.isEmpty
                  ? 'Not Available'
                  : widget.talukName,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: Colors.white30, height: 1),
            ),

            // DEVICE MAC ID
            _detailRow(
              icon: Icons.smartphone,
              label: 'Device Mac ID:',
              value: deviceId ?? 'Loading...',
            ),

            // CURRENT GPS
            _detailRow(
              icon: Icons.gps_fixed,
              label: 'Current GPS:',
              value: gpsText,
            ),

            // DATE AND TIME
            _detailRow(
              icon: Icons.access_time,
              label: 'Date and Time:',
              value: currentTime.isEmpty ? 'Loading...' : currentTime,
            ),
          ],
        ),
      ),
    );
  }
}
