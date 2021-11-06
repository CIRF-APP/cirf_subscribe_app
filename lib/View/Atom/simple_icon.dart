import 'package:flutter/material.dart';

class SimpleIcon extends StatelessWidget {//（flutterに付属してる）
  const SimpleIcon({
    required this.icon,//icon
    this.color = Colors.black,
    this.size = 17,
  });

  final Icon icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
     // Icons.search
    return Icon(
      icon.icon,
      color: color,
      size: size,
    );
  }
}
