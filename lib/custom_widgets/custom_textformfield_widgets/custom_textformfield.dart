import 'package:flutter/material.dart';

class Textformfield extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        decoration: TextDecoration.none,
        decorationThickness: 0,
        fontFamily: 'Roboto-Black',
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),

    );
  }
}