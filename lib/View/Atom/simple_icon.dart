import 'package:flutter/material.dart';

class SimpleIcon extends StatelessWidget {
  const SimpleIcon({
    required this.icon,
    this.color = Colors.black,
    this.size = 17,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
