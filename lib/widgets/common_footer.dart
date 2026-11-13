import 'package:flutter/material.dart';

/// Fixed, compact footer used on all authenticated and login screens.
class CommonFooter extends StatelessWidget {
  const CommonFooter({super.key});

  static const Color brandBlue = Color(0xff1565C0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: const BoxDecoration(
        color: brandBlue,
        border: Border(top: BorderSide(color: Color(0xff0D47A1), width: 1)),
      ),
      child: const SafeArea(
        top: false,
        child: Text(
          'KGIS - 2.0 | KSRSAC | Bengaluru',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
