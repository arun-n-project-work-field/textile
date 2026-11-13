// import 'package:flutter/material.dart';
// import 'package:namma_kaimagga_app/widgets/common_footer.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ContactUsScreen extends StatelessWidget {
//   const ContactUsScreen({super.key});

//   static const Color blue = Color(0xff1565C0);

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
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: const Text(
//             "Contact Us",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.blue,
//           foregroundColor: Colors.white,
//           centerTitle: true,
//           elevation: 0,
//         ),
//         bottomNavigationBar: CommonFooter(),
//         body: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             Container(
//               padding: const EdgeInsets.all(22),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: blue.withValues(alpha: 0.18)),
//               ),
//               child: const Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 32,
//                     backgroundColor: blue,
//                     child: Icon(
//                       Icons.contact_phone,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                   ),
//                   SizedBox(height: 14),
//                   Text(
//                     'Department of Personnel and Administrative Reforms'
//                     ' (e-Governance), Government of Karnataka',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Karnataka State Remote Sensing Applications Centre',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 18),
//             _ContactCard(
//               icon: Icons.location_on_outlined,
//               title: 'Address',
//               value:
//                   'Doora Samvedi Bhavana, '
//                   'Major Sandeep Unnikrishnan Road, '
//                   'Doddabettahalli, '
//                   'Bengaluru - 560 097. ',
//             ),
//             const SizedBox(height: 12),
//             _ContactCard(
//               icon: Icons.phone_outlined,
//               title: 'Telephone',
//               value: '+91-80-2972 0557',
//               onTap: () async {
//                 final Uri phoneUri = Uri(
//                   scheme: 'tel',
//                   path: '+91-80-2972 0557',
//                 );

//                 if (await canLaunchUrl(phoneUri)) {
//                   await launchUrl(phoneUri);
//                 } else {
//                   debugPrint('Could not open phone dialer');
//                 }
//               },
//             ),
//             _ContactCard(
//               icon: Icons.fax_outlined,
//               title: 'Fax',
//               value: '+91-80-2972 0556',
//             ),
//             const SizedBox(height: 12),
//             _ContactCard(
//               icon: Icons.email_outlined,
//               title: 'Email',
//               value: 'ksrsac-gok@karnataka.gov.in',
//               onTap: () async {
//                 final Uri emailUri = Uri(
//                   scheme: 'mailto',
//                   path: 'ksrsac-gok@karnataka.gov.in',
//                 );

//                 if (await canLaunchUrl(emailUri)) {
//                   await launchUrl(emailUri);
//                 } else {
//                   debugPrint('Could not open email app');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ContactCard extends StatelessWidget {
//   const _ContactCard({
//     required this.icon,
//     required this.title,
//     required this.value,
//     this.onTap,
//   });

//   final IconData icon;
//   final String title;
//   final String value;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1,
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       child: ListTile(
//         onTap: onTap,
//         contentPadding: const EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: const Color(0xff1565C0).withValues(alpha: 0.10),
//           child: Icon(icon, color: const Color(0xff1565C0)),
//         ),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 6),
//           child: Text(value, style: const TextStyle(height: 1.35)),
//         ),
//         trailing: onTap != null
//             ? const Icon(
//                 Icons.open_in_new,
//                 size: 18,
//                 color: Colors.blue,
//               )
//             : null,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/common_footer.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactUsScreen> {
  static const Color primaryColor = Color(0xff1565C0);

  static const String contactEmail = 'ksrsac-gok@karnataka.gov.in';
  static const String contactPhone = '+91-80-2972 0557';

  static const String contactAddress =
      'Doora Samvedi Bhavana,\n'
      'Major Sandeep Unnikrishnan Road,\n'
      'Doddabettahalli,\n'
      'Bengaluru - 560 097. ';

  static const String googleMapsUrl =
      'https://maps.app.goo.gl/FD8mULXdUeX7RRMB8';

  Future<void> _openLink(Uri uri, String errorMessage) async {
    try {
      final bool opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        _showMessage(errorMessage);
      }
    } catch (e) {
      debugPrint('Unable to open $uri: $e');

      if (mounted) {
        _showMessage(errorMessage);
      }
    }
  }

  Future<void> _openAddressInMaps() async {
    await _openLink(
      Uri.parse(googleMapsUrl),
      'Unable to open the Google Maps location.',
    );
  }

  Future<void> _openPhone() async {
    await _openLink(
      Uri(scheme: 'tel', path: '+91 80 2972 0557'),
      'Unable to open the phone dialler.',
    );
  }

  Future<void> _openEmail() async {
    // Try Gmail directly first.
    final Uri gmailUri = Uri.parse(
      'googlegmail://co?to=${Uri.encodeComponent(contactEmail)}'
      '&subject=${Uri.encodeComponent('Namma Kaimagga - Contact')}',
    );

    try {
      final bool gmailOpened = await launchUrl(
        gmailUri,
        mode: LaunchMode.externalApplication,
      );

      if (gmailOpened) return;
    } catch (e) {
      debugPrint('Unable to open Gmail directly: $e');
    }

    // Fall back to the device's default email application.
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: contactEmail,
      query: 'subject=${Uri.encodeComponent('Namma Kaimagga - Contact')}',
    );

    try {
      final bool emailOpened = await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );

      if (emailOpened) return;
    } catch (e) {
      debugPrint('Unable to open default email app: $e');
    }

    // Final fallback: compose the email in Gmail's website.
    await _openLink(
      Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=${Uri.encodeComponent(contactEmail)}'
        '&su=${Uri.encodeComponent('Namma Kaimagga - Contact')}',
      ),
      'Unable to open Gmail. Please check your internet connection.',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
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
        bottomNavigationBar: const CommonFooter(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: const Text(
            'Contact Us',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(18),
                  //   border: Border.all(
                  //     color: primaryColor.withValues(alpha: 0.18),
                  //   ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff1565C0), Color(0xff42A5F5)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.contact_phone,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Department of Personnel and Administrative Reforms'
                        ' (e-Governance), Government of Karnataka',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Karnataka State Remote Sensing Applications Centre',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                _ContactCard(
                  icon: Icons.location_on,
                  title: 'Address',
                  value: contactAddress,
                  onTap: _openAddressInMaps,
                ),
                const SizedBox(height: 18),
                _ContactCard(
                  icon: Icons.phone,
                  title: 'Phone',
                  value: contactPhone,
                  onTap: _openPhone,
                ),
                const SizedBox(height: 18),
                _ContactCard(
                  icon: Icons.fax_outlined,
                  title: 'Fax',
                  value: '+91-80-2972 0556',
                ),
                const SizedBox(height: 18),
                _ContactCard(
                  icon: Icons.email,
                  title: 'Email',
                  value: contactEmail,
                  onTap: _openEmail,
                ),
              ],
            ),
          ),
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
        trailing: onTap != null
            ? const Icon(Icons.open_in_new, size: 18, color: Colors.blue)
            : null,
      ),
    );
  }
}
