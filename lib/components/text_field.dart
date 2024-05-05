import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Text_Field extends StatelessWidget {
  Text_Field({
    super.key,
    required this.label,
    required this.hint,
    required this.isPassword,
    required this.keyboard,
    required this.txtEditController,
    required this.focusNode,
  });

  final String label;
  final String hint;
  final bool isPassword;
  final TextInputType keyboard;
  final TextEditingController txtEditController;
  late FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      keyboardType: keyboard,
      obscureText: isPassword,
      controller: txtEditController,
      style: GoogleFonts.roboto(
        height: 2,
        color: const Color.fromARGB(255, 16, 15, 15),
      ),
      cursorColor: const Color.fromARGB(255, 7, 82, 96),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        // fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 7, 82, 96),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: const Color.fromARGB(255, 16, 15, 15),
        ),
      ),
    );
  }
}
