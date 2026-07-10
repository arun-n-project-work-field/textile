import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hint;

  final IconData icon;

  final bool obscure;

  final Widget? suffix;

  final String? Function(String?)? validator;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      obscureText: obscure,

      validator: validator,

      decoration: InputDecoration(
        prefixIcon: Icon(icon),

        suffixIcon: suffix,

        hintText: hint,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
