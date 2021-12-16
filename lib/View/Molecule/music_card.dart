import 'package:cigarandcoffee/Common/audio_controller.dart';
import 'package:cigarandcoffee/Model/audio_card_model.dart';
import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    // required this.data,
    required this.musicName,
    required this.imageFile,
  });

  // final AudioCardModel data;
  final String musicName;
  final String imageFile;

  @override
  Widget build(BuildContext context) {
    final AudioFile audioController = AudioFile(musicName);

    return SizedBox(
      width: 275,
      height: 240,
      child: ElevatedButton(
        onPressed: () {
          if (audioController.isPlay()) {
            audioController.audioPause();
          } else {
            audioController.audioPlay();
          }
        },
        child: Image.asset(
          'assets/images/' + imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
