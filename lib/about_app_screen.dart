import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:namma_kaimagga_app/widgets/common_footer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      if (!mounted) return;

      setState(() {
        _appVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint('Could not fetch app version: $e');

      if (!mounted) return;

      setState(() {
        _appVersion = 'Unavailable';
      });
    }
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link.')),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('URL launch error: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'About Application',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBar: CommonFooter(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff1565C0), Color(0xff42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image(
                          image: AssetImage('assets/icons/app_icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Namma Kaimagga',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Handloom Survey Application',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _infoCard(
                icon: Icons.info_outline,
                title: 'Application Name',
                value: 'Namma Kaimagga',
              ),
              _infoCard(
                icon: Icons.verified,
                title: 'Version',
                value: _appVersion,
              ),
              _infoCard(
                icon: Icons.business,
                title: 'Developed By',
                value:
                    'Karnataka GIS - 2.0\n'
                    ''
                    'KSRSAC (Karnataka State Remote Sensing '
                    'Applications Centre), Bengaluru',
              ),
              _infoCard(
                icon: Icons.description,
                title: 'Description',
                value:
                    'This mobile application is developed for '
                    'identification and geo-tagging of Handloom '
                    'Weaver locations and photographs of handlooms '
                    'along with the weavers across Karnataka.',
              ),
              _infoCard(
                icon: Icons.public,
                title: 'KGIS',
                value: 'https://kgis.ksrsac.in/kgis/',
                onTap: () => _openUrl(context, 'https://kgis.ksrsac.in/kgis/'),
              ),
              _infoCard(
                icon: Icons.language,
                title: 'KSRSAC',
                value: 'https://ksrsac.karnataka.gov.in',
                onTap: () =>
                    _openUrl(context, 'https://ksrsac.karnataka.gov.in'),
              ),
              const SizedBox(height: 25),
              Text(
                '© 2026 Karnataka State Remote Sensing '
                'Applications Centre',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade50,
                child: Icon(icon, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 4),
                  child: Icon(Icons.open_in_new, size: 18, color: Colors.blue),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
