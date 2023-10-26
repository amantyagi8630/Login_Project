import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String btnName;
  final Color? bgColor;
  final VoidCallback? callback;

  const CustomElevatedButton({super.key, required this.btnName, this.bgColor, this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        elevation: 10,
        minimumSize: const Size(370, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      onPressed: () {
        callback!();
      },
      child: Text(
        btnName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontFamily: 'Roboto-Black',
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
