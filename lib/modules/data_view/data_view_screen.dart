import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_view_controller.dart';

class DataViewScreen extends GetView<DataViewController> {
  const DataViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        title: const Text(
          'Data View',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF087443),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Obx(
        () {
          if (controller.isLoading.value &&
              controller.dataList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.dataList.isEmpty) {
            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 170),

                  Icon(
                    Icons.folder_open_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  Center(
                    child: Text(
                      'Geo-Tagged data will appear here.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: [
                _buildSummaryCard(),

                const SizedBox(height: 12),

                ...controller.dataList.map(
                  (data) => _buildDataCard(
                    context,
                    data,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // SUMMARY CARD
  // ==========================================================

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              icon: Icons.folder_copy_outlined,
              title: 'Total',
              value: controller.totalCount.toString(),
            ),
          ),

          Container(
            width: 1,
            height: 45,
            color: Colors.grey.shade300,
          ),

          Expanded(
            child: _buildSummaryItem(
              icon: Icons.cloud_upload_outlined,
              title: 'Pending',
              value: controller.pendingCount.toString(),
            ),
          ),

          Container(
            width: 1,
            height: 45,
            color: Colors.grey.shade300,
          ),

          Expanded(
            child: _buildSummaryItem(
              icon: Icons.cloud_done_outlined,
              title: 'Synced',
              value: controller.syncedCount.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF087443),
          size: 25,
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // DATA CARD
  // ==========================================================

  Widget _buildDataCard(
    BuildContext context,
    Map<String, dynamic> data,
  ) {
    final uniqueId = _getValue(data, 'p1');
    final district = _getValue(data, 'p2');
    final taluk = _getValue(data, 'p3');
    final latitude = _getValue(data, 'p6');
    final longitude = _getValue(data, 'p7');
    final mobile = _getValue(data, 'p12');
    final createdDate = _getValue(data, 'p17');
    final syncStatus = _getValue(data, 'syncStatus');

    final isSynced =
        syncStatus.toLowerCase() == 'synced';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(14),

        onTap: () {
          _showDataDetails(
            context,
            data,
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(14),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ------------------------------------------------
              // UNIQUE ID + STATUS
              // ------------------------------------------------

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Text(
                      uniqueId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF087443),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  _buildStatusChip(
                    status: syncStatus,
                    isSynced: isSynced,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ------------------------------------------------
              // DISTRICT / TALUK
              // ------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.location_city_outlined,
                      title: 'District',
                      value: district,
                    ),
                  ),

                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.map_outlined,
                      title: 'Taluk',
                      value: taluk,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ------------------------------------------------
              // LATITUDE / LONGITUDE
              // ------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.gps_fixed,
                      title: 'Latitude',
                      value: latitude,
                    ),
                  ),

                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.gps_fixed,
                      title: 'Longitude',
                      value: longitude,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ------------------------------------------------
              // MOBILE / DATE
              // ------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.phone_outlined,
                      title: 'Mobile',
                      value: mobile,
                    ),
                  ),

                  Expanded(
                    child: _buildDetailItem(
                      icon: Icons.calendar_today_outlined,
                      title: 'Created',
                      value: createdDate,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ------------------------------------------------
              // VIEW DETAILS
              // ------------------------------------------------

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: const [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color: Color(0xFF087443),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(width: 4),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color: Color(0xFF087443),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // STATUS CHIP
  // ==========================================================

  Widget _buildStatusChip({
    required String status,
    required bool isSynced,
  }) {
    final color = isSynced
        ? const Color(0xFF087443)
        : Colors.orange.shade800;

    final background = isSynced
        ? const Color(0xFFE7F5ED)
        : const Color(0xFFFFF3E0);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSynced
                ? Icons.cloud_done
                : Icons.cloud_upload_outlined,
            size: 14,
            color: color,
          ),

          const SizedBox(width: 4),

          Text(
            isSynced ? 'Synced' : 'Pending',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DETAIL ITEM
  // ==========================================================

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),

        const SizedBox(width: 7),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value.isEmpty ? '-' : value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // DATA DETAILS
  // ==========================================================

  void _showDataDetails(
    BuildContext context,
    Map<String, dynamic> data,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      builder: (_) {
        return _DataDetailsSheet(
          data: data,
          onDelete: () {
            Navigator.of(context).pop();

            final uniqueId =
                _getValue(data, 'p1');

            _confirmDelete(
              context,
              uniqueId,
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // DELETE CONFIRMATION
  // ==========================================================

  void _confirmDelete(
    BuildContext context,
    String uniqueId,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Delete Data',
        ),

        content: const Text(
          'Are you sure you want to delete this data?',
        ),

        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              Get.back();

              await controller.deleteData(
                uniqueId,
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),

            child: const Text(
              'Delete',
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GET VALUE
  // ==========================================================

  String _getValue(
    Map<String, dynamic> data,
    String key,
  ) {
    final value = data[key];

    if (value == null) {
      return '';
    }

    return value.toString();
  }
}


// ============================================================
// DATA DETAILS SHEET
// ============================================================

class _DataDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDelete;

  const _DataDetailsSheet({
    required this.data,
    required this.onDelete,
  });

  String _getValue(String key) {
    final value = data[key];

    if (value == null) {
      return '';
    }

    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final photo1Path = _getValue('p8');
    final photo2Path = _getValue('p9');

    final syncStatus =
        _getValue('syncStatus');

    final isSynced =
        syncStatus.toLowerCase() == 'synced';

    return DraggableScrollableSheet(
      initialChildSize: 0.90,
      minChildSize: 0.55,
      maxChildSize: 0.95,

      builder: (
        context,
        scrollController,
      ) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF4F7FA),

            borderRadius: BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),

          child: Column(
            children: [
              // ------------------------------------------------
              // HANDLE
              // ------------------------------------------------

              Container(
                width: 45,
                height: 5,
                margin:
                    const EdgeInsets.only(top: 10),

                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              // ------------------------------------------------
              // TITLE
              // ------------------------------------------------

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  18,
                  14,
                  8,
                  10,
                ),

                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Data Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              // ------------------------------------------------
              // CONTENT
              // ------------------------------------------------

              Expanded(
                child: ListView(
                  controller: scrollController,

                  padding:
                      const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    25,
                  ),

                  children: [
                    _buildSection(
                      title: 'Data Information',
                      children: [
                        _buildRow(
                          'P1 - Unique ID',
                          _getValue('p1'),
                        ),
                        _buildRow(
                          'P2 - District',
                          _getValue('p2'),
                        ),
                        _buildRow(
                          'P3 - Taluk',
                          _getValue('p3'),
                        ),
                        _buildRow(
                          'P4 - District Code',
                          _getValue('p4'),
                        ),
                        _buildRow(
                          'P5 - Taluk Code',
                          _getValue('p5'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // LOCATION
                    // ------------------------------------------------

                    _buildSection(
                      title: 'Geo-Tagging',
                      children: [
                        _buildRow(
                          'P6 - Latitude',
                          _getValue('p6'),
                        ),
                        _buildRow(
                          'P7 - Longitude',
                          _getValue('p7'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // PHOTO 1
                    // ------------------------------------------------

                    _buildPhotoSection(
                      title: 'Photo 1',
                      path: photo1Path,
                      details: _getValue('p10'),
                    ),

                    // ------------------------------------------------
                    // PHOTO 2
                    // ------------------------------------------------

                    _buildPhotoSection(
                      title: 'Photo 2',
                      path: photo2Path,
                      details: _getValue('p11'),
                    ),

                    // ------------------------------------------------
                    // DEVICE INFORMATION
                    // ------------------------------------------------

                    _buildSection(
                      title: 'Device / User Information',
                      children: [
                        _buildRow(
                          'P12 - Mobile Number',
                          _getValue('p12'),
                        ),
                        _buildRow(
                          'P13 - Device ID',
                          _getValue('p13'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // REMARKS
                    // ------------------------------------------------

                    _buildSection(
                      title: 'Remarks',
                      children: [
                        _buildRow(
                          'P14 - Remarks',
                          _getValue('p14'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // VERSION
                    // ------------------------------------------------

                    _buildSection(
                      title: 'Version Information',
                      children: [
                        _buildRow(
                          'P15 - Collected Version',
                          _getValue('p15'),
                        ),
                        _buildRow(
                          'P16 - Synced Version',
                          _getValue('p16'),
                        ),
                        _buildRow(
                          'P17 - Created Date',
                          _getValue('p17'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // P100
                    // ------------------------------------------------

                    _buildSection(
                      title: 'File Information',
                      children: [
                        _buildRow(
                          'P100 - Filename',
                          _getValue('p100'),
                        ),
                      ],
                    ),

                    // ------------------------------------------------
                    // SYNC STATUS
                    // ------------------------------------------------

                    _buildSection(
                      title: 'Synchronization',
                      children: [
                        _buildRow(
                          'Sync Status',
                          syncStatus.isEmpty
                              ? 'Pending'
                              : syncStatus,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // ------------------------------------------------
                    // SYNC MESSAGE
                    // ------------------------------------------------

                    Container(
                      padding:
                          const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: isSynced
                            ? const Color(
                                0xFFE8F5E9,
                              )
                            : const Color(
                                0xFFFFF3E0,
                              ),

                        borderRadius:
                            BorderRadius.circular(12),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            isSynced
                                ? Icons.cloud_done
                                : Icons
                                    .cloud_upload_outlined,

                            color: isSynced
                                ? const Color(
                                    0xFF087443,
                                  )
                                : Colors
                                    .orange
                                    .shade800,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              isSynced
                                  ? 'This data has been synchronized.'
                                  : 'This data is saved locally and is waiting for synchronization.',

                              style: TextStyle(
                                fontSize: 13,
                                color: isSynced
                                    ? const Color(
                                        0xFF087443,
                                      )
                                    : Colors
                                        .orange
                                        .shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // SECTION
  // ==========================================================

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF087443),
            ),
          ),

          const SizedBox(height: 10),

          ...children,
        ],
      ),
    );
  }

  // ==========================================================
  // ROW
  // ==========================================================

  Widget _buildRow(
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 9),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 155,

            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,

              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PHOTO SECTION
  // ==========================================================

  Widget _buildPhotoSection({
    required String title,
    required String path,
    required String details,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF087443),
            ),
          ),

          const SizedBox(height: 12),

          if (path.isEmpty)
            Container(
              height: 130,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: const Center(
                child: Text(
                  'No Photo',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),

              child: Image.file(
                File(path),

                height: 220,
                width: double.infinity,

                fit: BoxFit.cover,

                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    height: 130,

                    color:
                        Colors.grey.shade100,

                    child: const Center(
                      child: Text(
                        'Photo not available',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          if (details.isNotEmpty) ...[
            const SizedBox(height: 10),

            Text(
              details,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}