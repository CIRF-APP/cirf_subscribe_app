import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    required this.musicName,
    required this.imageFile,
  });

  final String musicName;
  final String imageFile;

  @override
  Widget build(BuildContext context) {
    final AudioManager audioManager = Provider.of<AudioManager>(context);

    return SizedBox(
      width: 275,
      height: 240,
      child: GestureDetector(
        onTap: () async {
          await audioManager.playOneFile(musicName);
        },
        child: Image.asset('assets/images/' + imageFile,),
      ),
    );
  }
}
