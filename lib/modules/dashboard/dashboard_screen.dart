import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';
import 'package:namma_kaimagga_app/services/app_session.dart';
import 'package:namma_kaimagga_app/database/database_helper.dart';
import 'package:namma_kaimagga_app/widgets/common_footer.dart';
import 'package:namma_kaimagga_app/widgets/common_header.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final String mobileNumber;

  final String districtName;
  final String districtCode;

  final String talukName;
  final String talukCode;

  DashboardScreen({
    super.key,
    required this.mobileNumber,
    required this.districtName,
    required this.districtCode,
    required this.talukName,
    required this.talukCode,
  });

  final DashboardController controller = Get.put(DashboardController());

  // Dynamically fetch the installed application version.
  final Future<PackageInfo> _packageInfo = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg',
            ), // Or NetworkImage('url')
            fit: BoxFit.cover, // Ensures the image fills the entire screen
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const _AppDrawer(),

          // =========================================================
          // APP BAR
          // =========================================================
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color(0xff1565C0),
            foregroundColor: Colors.white,
            title: const Text(
              "Namma Kaimagga",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          bottomNavigationBar: CommonFooter(),

          // =========================================================
          // BODY
          // =========================================================
          body: SingleChildScrollView(
            child: Column(
              children: [
                // ===================================================
                // COMMON HEADER
                // ===================================================
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff1565C0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: CommonHeader(
                    mobileNumber: mobileNumber,
                    districtName: districtName,
                    talukName: talukName,
                  ),
                ),

                // ===================================================
                // DASHBOARD CONTENT
                // ===================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ============================================
                      // QUICK ACTIONS
                      // ============================================
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ============================================
                      // ACTION CARDS
                      // ============================================
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.88,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // ========================================
                          // GEO TAGGING
                          // ========================================
                          _DashboardCard(
                            icon: Icons.assignment_add,
                            title: "Start Geo-Tagging",
                            subtitle: "Start Collecting Details",
                            color: Colors.blue,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.geoTagging,
                                arguments: {
                                  'mobileNumber': mobileNumber,

                                  'districtName': districtName,

                                  'districtCode': districtCode,

                                  'talukName': talukName,

                                  'talukCode': talukCode,
                                },
                              );
                            },
                          ),

                          // ========================================
                          // VIEW DATA
                          // ========================================
                          _DashboardCard(
                            icon: Icons.folder_copy,
                            title: "View Data",
                            subtitle: "Offline Records",
                            color: Colors.orange,
                            onTap: () {
                              Get.toNamed(AppRoutes.dataView);
                            },
                          ),

                          // ========================================
                          // SYNC DATA
                          // ========================================
                          _DashboardCard(
                            icon: Icons.sync,
                            title: "Sync Data",
                            subtitle: "Upload Records",
                            color: Colors.green,
                            onTap: () {
                              Get.toNamed(AppRoutes.syncData);
                            },
                          ),

                          // ========================================
                          // LOGOUT
                          // ========================================
                          // _DashboardCard(
                          //   icon: Icons.exit_to_app,
                          //   title: "Log Out",
                          //   subtitle: "Sign Out of App",
                          //   color: Colors.purple,
                          //   onTap: () => _confirmLogout(context),
                          // ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ============================================
                      // VERSION
                      // ============================================
                      Center(
                        child: FutureBuilder<PackageInfo>(
                          future: _packageInfo,
                          builder: (context, snapshot) {
                            final version = snapshot.hasData
                                ? snapshot.data!.version
                                : snapshot.hasError
                                ? 'Unavailable'
                                : 'Loading...';

                            return Text(
                              'Version $version',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ============================================
                      // FOOTER
                      // ============================================
                      // const CommonFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =================================================================
// DASHBOARD CARD
// =================================================================

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ICON
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 31),
              ),

              const SizedBox(height: 14),

              // TITLE
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              // SUBTITLE
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =================================================================
// DRAWER
// =================================================================

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // const UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(color: Color(0xff1565C0)),
            //   accountName: Text(
            //     "Survey Officer",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   accountEmail: Text("KSRSAC"),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Icon(Icons.person, color: Color(0xff1565C0), size: 40),
            //   ),
            // ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff1565C0), Color(0xff42A5F5)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  // FIX: ClipRRect clips its child widget to a rounded shape
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ), // Adjust this value to change the roundness
                    child: const Image(
                      image: AssetImage('assets/icons/app_icon.png'),

                      fit: BoxFit
                          .cover, // Ensures the image fills the rounded boundary nicely
                    ),
                  ),
                ),
              ),
            ),
            _drawerItem(context, Icons.info_outline, "About", AppRoutes.about),

            _drawerItem(
              context,
              Icons.description,
              "Disclaimer",
              AppRoutes.disclaimer,
            ),

            _drawerItem(
              context,
              Icons.phone_android,
              "Contact Us",
              AppRoutes.contact,
            ),

            const Divider(),

            _drawerItem(context, Icons.logout, "Logout", AppRoutes.login),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);

        if (title == "Logout") {
          _confirmLogout(context);
        } else {
          Get.toNamed(route);
        }
      },
    );
  }
}

/// Before logging out, require the user to sync or intentionally delete
/// locally saved survey records. Local records are not removed by clearing
/// SharedPreferences; deletion is an explicit, separate action.
Future<void> _confirmLogout(BuildContext context) async {
  try {
    final database = DatabaseHelper.instance;
    final int savedCount = await database.getSurveyCount();

    if (!context.mounted) return;

    if (savedCount == 0) {
      final bool? confirmed = await Get.dialog<bool>(
        AlertDialog(
          icon: const Icon(Icons.logout, color: Color(0xff1565C0), size: 32),
          title: const Text('Confirm Logout'),
          content: const Text(
            'You have no locally saved survey records. Do you want to log out?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              child: const Text('LOG OUT'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      if (confirmed == true) await _finishLogout();
      return;
    }

    final _LogoutChoice? choice = await Get.dialog<_LogoutChoice>(
      AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 34,
        ),
        title: const Text('Saved Data Before Logout'),
        content: Text(
          'There are $savedCount locally saved survey record(s).\n\n'
          'WARNING: Logging out will cause all local saved data to be lost. '
          'Sync the records before logging out, or deliberately delete the saved '
          'records. Records that are not successfully synced will remain on this '
          'device until you delete them.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: _LogoutChoice.cancel),
            child: const Text('CANCEL'),
          ),
          OutlinedButton.icon(
            onPressed: () => Get.back(result: _LogoutChoice.sync),
            icon: const Icon(Icons.sync),
            label: const Text('SYNC SAVED DATA'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Get.back(result: _LogoutChoice.delete),
            icon: const Icon(Icons.delete_forever),
            label: const Text('DELETE & LOG OUT'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (choice == null || choice == _LogoutChoice.cancel) return;

    if (choice == _LogoutChoice.sync) {
      // Successfully synced rows are removed by the existing sync controller.
      // Return to Dashboard and press Logout again to review any remaining rows.
      Get.toNamed(AppRoutes.syncData);
      return;
    }

    if (choice == _LogoutChoice.delete) {
      final bool? deleteConfirmed = await Get.dialog<bool>(
        AlertDialog(
          icon: const Icon(Icons.delete_forever, color: Colors.red, size: 34),
          title: const Text('Permanently Delete Saved Data?'),
          content: Text(
            'This will permanently delete all $savedCount locally saved survey '
            'record(s), including records that have not synced. This cannot be undone. '
            'Your account session will then be logged out.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('KEEP DATA'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Get.back(result: true),
              child: const Text('DELETE DATA & LOG OUT'),
            ),
          ],
        ),
        barrierDismissible: false,
      );

      if (deleteConfirmed != true) return;
      await database.clearSurveyData();
      await _finishLogout();
    }
  } catch (e, stackTrace) {
    debugPrint('LOGOUT PREPARATION ERROR: $e');
    debugPrintStack(stackTrace: stackTrace);
    Get.snackbar(
      'Logout failed',
      'Unable to check or clear saved data. Nothing has been logged out; please try again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
    );
  }
}

enum _LogoutChoice { sync, delete, cancel }

Future<void> _finishLogout() async {
  try {
    await AppSession.logout();
    // Remove dashboard and all protected pages from the back stack.
    Get.offAllNamed(AppRoutes.login);
  } catch (e, stackTrace) {
    debugPrint('LOGOUT ERROR: $e');
    debugPrintStack(stackTrace: stackTrace);
    Get.snackbar(
      'Logout failed',
      'Unable to clear the login session. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }
}
