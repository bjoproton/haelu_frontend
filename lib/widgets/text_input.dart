// External
import 'package:flutter/material.dart';

// Internal

class TextInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  TextInput({
      required this.hintText,
      this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
