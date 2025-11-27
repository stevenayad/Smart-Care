import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscure,
        validator: (value) =>
            value!.isEmpty ? "Please enter ${widget.hint}" : null,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () => setState(() => obscure = !obscure),
          ),
        ),
      ),
    );
  }
}
