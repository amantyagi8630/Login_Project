import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final double conWidth;
  final double conHeight;
  final Widget? widget;
  const AppBackground({super.key, required this.conHeight, required this.conWidth,required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: conHeight,
      width: conWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0C187A),
            Color(0xFF030F56),
            Color(0xFF019CDF)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: widget,
    );
  }
}
