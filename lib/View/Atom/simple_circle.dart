import 'package:flutter/material.dart';

class SimpleCircle extends StatelessWidget {
  const SimpleCircle({
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
