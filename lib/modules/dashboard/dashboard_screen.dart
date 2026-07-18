import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namma_kaimagga_app/routes/app_routes.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _AppDrawer(),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Namma Kaimagga",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [Color(0xff1565C0), Color(0xff42A5F5)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.blue, size: 32),
                      ),

                      const SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Survey Officer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            "GPS Active • Ready for Survey",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 15),

            // const Text(
            //   "Survey Statistics",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            // Obx(
            //   () => Row(
            //     children: [
            //       Expanded(
            //         child: _StatCard(
            //           title: "Total",
            //           value: controller.totalSurvey.value.toString(),
            //           color: Colors.blue,
            //         ),
            //       ),

            //       const SizedBox(width: 10),

            //       Expanded(
            //         child: _StatCard(
            //           title: "Completed",
            //           value: controller.completedSurvey.value.toString(),
            //           color: Colors.green,
            //         ),
            //       ),

            //       const SizedBox(width: 10),

            //       Expanded(
            //         child: _StatCard(
            //           title: "Pending",
            //           value: controller.pendingSurvey.value.toString(),
            //           color: Colors.orange,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 15),

            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.85,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _DashboardCard(
                  icon: Icons.assignment_add,
                  title: "Start Geo-Tagging",
                  subtitle: "Start Collecting Details",
                  color: Colors.blue,
                  onTap: () {
                    Get.toNamed(AppRoutes.geotagging);
                  },
                ),

                _DashboardCard(
                  icon: Icons.folder_copy,
                  title: "View Data",
                  subtitle: "Offline Records",
                  color: Colors.orange,
                  onTap: () {
                    Get.toNamed(AppRoutes.savedSurvey);
                  },
                ),

                _DashboardCard(
                  icon: Icons.sync,
                  title: "Sync Data",
                  subtitle: "Upload Records",
                  color: Colors.green,
                  onTap: () {
                    Get.toNamed(AppRoutes.sync);
                  },
                ),

                _DashboardCard(
                  icon: Icons.exit_to_app,
                  title: "Log Out",
                  subtitle: "Sign Out of App",
                  color: Colors.purple,
                  onTap: () {
                    Get.toNamed(AppRoutes.geotagging);
                  },
                ),

                // _DashboardCard(
                //   icon: Icons.lock_reset,
                //   title: "Password",
                //   subtitle: "Reset Password",
                //   color: Colors.red,
                //   onTap: () {
                //     Get.toNamed(AppRoutes.resetPassword);
                //   },
                // ),

                // _DashboardCard(
                //   icon: Icons.info,
                //   title: "About",
                //   subtitle: "Application",
                //   color: Colors.teal,
                //   onTap: () {
                //     Get.toNamed(AppRoutes.about);
                //   },
                // ),
              ],
            ),

            const SizedBox(height: 30),

            // const SizedBox(height: 15),

            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

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
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withValues(alpha: .15),
                child: Icon(icon, color: color, size: 30),
              ),

              const SizedBox(height: 14),

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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text("Survey Officer"),
            accountEmail: Text("KSRSAC"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),

          // _drawerItem(
          //   context,
          //   Icons.dashboard,
          //   "Dashboard",
          //   AppRoutes.dashboard,
          // ),

          // _drawerItem(
          //   context,
          //   Icons.assignment_add,
          //   "New Survey",
          //   AppRoutes.startSurvey,
          // ),

          // _drawerItem(
          //   context,
          //   Icons.folder,
          //   "Saved Survey",
          //   AppRoutes.savedSurvey,
          // ),

          // _drawerItem(context, Icons.sync, "Sync Data", AppRoutes.sync),

          // _drawerItem(
          //   context,
          //   Icons.location_on,
          //   "Geo Tagging",
          //   AppRoutes.geoTagging,
          // ),

          

          _drawerItem(context, Icons.info_outline, "About", AppRoutes.about),

          _drawerItem(
            context,
            Icons.description,
            "Disclaimer",
            AppRoutes.disclaimer,
          ),

          const Divider(),

          _drawerItem(
            context,
            Icons.lock_reset,
            "Reset Password",
            AppRoutes.resetPassword,
          ),

          _drawerItem(context, Icons.logout, "Logout", AppRoutes.login),
        ],
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
          Get.offAllNamed(route);
        } else {
          Get.toNamed(route);
        }
      },
    );
  }
}
