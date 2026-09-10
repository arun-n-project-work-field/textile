import 'package:flutter/material.dart';

class CommonFooter extends StatelessWidget {
  const CommonFooter({
    super.key,
  });

  @override                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [

          // ======================================================
          // KSRSAC LOGO
          // ======================================================

          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/images/ksrsac_logo.png',
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    size: 25,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // FOOTER TEXT
          // ======================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: const [

                Text(
                  'Designed and Developed for K-GIS - 2.0',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  'by KSRSAC, Bengaluru',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}