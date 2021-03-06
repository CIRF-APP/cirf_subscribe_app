import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    required this.isPlay,
    required this.musicTitle,
    required this.onPressed,
  });

  final bool isPlay;
  final String musicTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: IconButton(
        onPressed: onPressed,
        icon: isPlay
            ? const SimpleIcon(
                icon: Icons.pause_circle_outline_outlined,
                size: 60,
                color: Colors.white,
              )
            : const SimpleIcon(
                icon: Icons.play_circle_outline_outlined,
                size: 60,
                color: Colors.white,
              ),
      ),
    );
  }
}
