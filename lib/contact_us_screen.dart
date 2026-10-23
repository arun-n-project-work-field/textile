import 'package:flutter/material.dart';
import 'package:namma_kaimagga_app/widgets/common_footer.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const Color blue = Color(0xff1565C0);

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Contact Us",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBar: CommonFooter(),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: blue.withValues(alpha: 0.18)),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: blue,
                    child: Icon(
                      Icons.contact_phone,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Karnataka State Remote Sensing Applications Centre',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: blue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Department of Personnel and Administrative Reforms'
                    ' (e-Governance), Government of Karnataka',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _ContactCard(
              icon: Icons.location_on_outlined,
              title: 'Address',
              value:
                  'Doora Samvedi Bhavana, Major Sandeep Unnikrishnan Road, '
                  'Doddabettahalli, Bengaluru-560 097.',
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.phone_outlined,
              title: 'Telephone',
              value: '+91-80-2972 0557',
              // onTap: () => Get.snackbar('Telephone', '+91-80-2972 0557'),
            ),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.email_outlined,
              title: 'Email',
              value: 'ksrsac-gok@karnataka.gov.in',
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xff1565C0).withValues(alpha: 0.10),
          child: Icon(icon, color: const Color(0xff1565C0)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(value, style: const TextStyle(height: 1.35)),
        ),
      ),
    );
  }
}
