import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    String? hintText,
    required String labelText,
    IconData? icon,
  }) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 18),
      prefixIcon: icon != null ? Icon(icon) : null,
    );
  }
}
