import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    required this.isPlay,
    required this.musicTitle,
    required this.onPressed,
    this.padding = const EdgeInsets.only(right: 30.0, bottom: 28),
    this.size = 60,
  });

  final bool isPlay;
  final String musicTitle;
  final void Function()? onPressed;
  final EdgeInsetsGeometry padding;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: onPressed,
        icon: isPlay
            ? SimpleIcon(
                icon: Icons.pause_circle_outline_outlined,
                size: size,
                color: Colors.white,
              )
            : SimpleIcon(
                icon: Icons.play_circle_outline_outlined,
                size: size,
                color: Colors.white,
              ),
      ),
    );
  }
}
