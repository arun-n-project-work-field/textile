import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/widgets/common_footer.dart';

import 'sync_data_controller.dart';

class SyncDataScreen
    extends GetView<SyncDataController> {
  const SyncDataScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FA),
    
      appBar: AppBar(
      title: const Text(
        'Sync Data',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xff1565C0),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBar: CommonFooter(),
    
      body: Obx(
        () {
          if (controller.isLoading.value &&
              controller.pendingData.isEmpty) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }
    
          return RefreshIndicator(
            onRefresh:
                controller.refresh,
    
            child: ListView(
              physics:
                  const AlwaysScrollableScrollPhysics(),
    
              padding:
                  const EdgeInsets.all(16),
    
              children: [
                // -------------------------------------------------------------
                // HEADER
                // -------------------------------------------------------------
    
                _buildHeaderCard(),
    
                const SizedBox(
                  height: 16,
                ),
    
                // -------------------------------------------------------------
                // SUMMARY
                // -------------------------------------------------------------
    
                _buildSummaryCard(),
    
                const SizedBox(
                  height: 16,
                ),
    
                // -------------------------------------------------------------
                // CURRENT STATUS
                // -------------------------------------------------------------
    
                _buildStatusCard(),
    
                const SizedBox(
                  height: 16,
                ),
    
                // -------------------------------------------------------------
                // PENDING RECORDS
                // -------------------------------------------------------------
    
                _buildPendingRecordsCard(),
    
                const SizedBox(
                  height: 20,
                ),
    
                // -------------------------------------------------------------
                // SYNC BUTTON
                // -------------------------------------------------------------
    
                _buildSyncButton(),
    
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // HEADER CARD
  // ===========================================================================

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration:
                  BoxDecoration(
                color:
                    const Color(0xFFE8F5E9),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Icon(
                Icons.sync_rounded,
                size: 30,
                color:
                    Color(0xFF2E7D32),
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sync Data',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Synchronize locally saved survey data with the server.',
                    style: TextStyle(
                      fontSize: 13,
                      color:
                          Colors.black54,
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

  // ===========================================================================
  // SUMMARY CARD
  // ===========================================================================

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Synchronization Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                Expanded(
                  child:
                      _buildCountBox(
                    title:
                        'Pending',
                    value:
                        controller.pendingData.length,
                    icon:
                        Icons.pending_actions,
                    iconColor:
                        Colors.orange,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child:
                      _buildCountBox(
                    title:
                        'Success',
                    value:
                        controller.successCount.value,
                    icon:
                        Icons.check_circle_outline,
                    iconColor:
                        Colors.green,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child:
                      _buildCountBox(
                    title:
                        'Failed',
                    value:
                        controller.failedCount.value,
                    icon:
                        Icons.error_outline,
                    iconColor:
                        Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // COUNT BOX
  // ===========================================================================

  Widget _buildCountBox({
    required String title,
    required int value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFFF8F9FB),
        borderRadius:
            BorderRadius.circular(12),
        border:
            Border.all(
          color:
              const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 25,
          ),

          const SizedBox(
            height: 7,
          ),

          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 21,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color:
                  Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // STATUS CARD
  // ===========================================================================

  Widget _buildStatusCard() {
    final syncing =
        controller.isSyncing.value;

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  syncing
                      ? Icons.sync
                      : Icons.info_outline,
                  color:
                      syncing
                          ? const Color(
                              0xFF1976D2,
                            )
                          : Colors.black54,
                ),

                const SizedBox(
                  width: 8,
                ),

                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Container(
              width:
                  double.infinity,
              padding:
                  const EdgeInsets.all(
                12,
              ),
              decoration:
                  BoxDecoration(
                color:
                    syncing
                        ? const Color(
                            0xFFE3F2FD,
                          )
                        : const Color(
                            0xFFF5F5F5,
                          ),
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),
              child: Row(
                children: [
                  if (syncing)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),

                  if (syncing)
                    const SizedBox(
                      width: 10,
                    ),

                  Expanded(
                    child: Text(
                      controller
                          .statusMessage
                          .value,
                      style:
                          const TextStyle(
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (controller
                .currentUniqueId
                .value
                .isNotEmpty) ...[
              const SizedBox(
                height: 10,
              ),

              Text(
                'Current ID: ${controller.currentUniqueId.value}',
                style:
                    const TextStyle(
                  fontSize: 12,
                  color:
                      Colors.black54,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PENDING RECORDS
  // ===========================================================================

  Widget _buildPendingRecordsCard() {
    final records =
        controller.pendingData;

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pending Records',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),

                Text(
                  '${records.length}',
                  style:
                      const TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(0xFF1976D2),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            if (records.isEmpty)
              Container(
                width:
                    double.infinity,
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 25,
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons
                          .cloud_done_outlined,
                      size: 45,
                      color:
                          Colors.green,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      'No pending records',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Text(
                      'All locally saved data has been synchronized.',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...List.generate(
                records.length,
                (index) {
                  final item =
                      records[index];

                  return _buildRecordItem(
                    item,
                    index,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // RECORD ITEM
  // ===========================================================================

  Widget _buildRecordItem(
    Map<String, dynamic> item,
    int index,
  ) {
    final uniqueId =
        item['p1']
                ?.toString()
                .trim()
                .isNotEmpty ==
            true
        ? item['p1'].toString()
        : 'Unknown ID';

    final district =
        item['p2']?.toString() ?? '';

    final taluk =
        item['p3']?.toString() ?? '';

    final mobile =
        item['p12']?.toString() ?? '';

    final status =
        item['syncStatus']
                ?.toString() ??
            'Pending';

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),
      padding:
          const EdgeInsets.all(12),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFFF8F9FB),
        borderRadius:
            BorderRadius.circular(10),
        border:
            Border.all(
          color:
              const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFFFF3E0),
              borderRadius:
                  BorderRadius.circular(
                9,
              ),
            ),
            alignment:
                Alignment.center,
            child: Text(
              '${index + 1}',
              style:
                  const TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
                color:
                    Color(0xFFE65100),
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  uniqueId,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                if (district
                    .isNotEmpty)
                  Text(
                    'District: $district',
                    style:
                        const TextStyle(
                      fontSize: 11,
                      color:
                          Colors.black54,
                    ),
                  ),

                if (taluk.isNotEmpty)
                  Text(
                    'Taluk: $taluk',
                    style:
                        const TextStyle(
                      fontSize: 11,
                      color:
                          Colors.black54,
                    ),
                  ),

                if (mobile.isNotEmpty)
                  Text(
                    'Mobile: $mobile',
                    style:
                        const TextStyle(
                      fontSize: 11,
                      color:
                          Colors.black54,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Container(
            padding:
                const EdgeInsets
                    .symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFFFF3E0),
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),
            child: Text(
              status,
              style:
                  const TextStyle(
                fontSize: 10,
                fontWeight:
                    FontWeight.w600,
                color:
                    Color(0xFFE65100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SYNC BUTTON
  // ===========================================================================

  Widget _buildSyncButton() {
    final syncing =
        controller.isSyncing.value;

    final hasData =
        controller.pendingData.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed:
            syncing || !hasData
                ? null
                : controller.syncAllData,

        icon: syncing
            ? const SizedBox(
                width: 20,
                height: 20,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              )
            : const Icon(
                Icons.sync_rounded,
              ),

        label: Text(
          syncing
              ? 'Synchronizing...'
              : 'Sync Data',
          style:
              const TextStyle(
            fontSize: 15,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        style:
            ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}