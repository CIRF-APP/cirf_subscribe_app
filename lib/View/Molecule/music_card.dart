import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:cigarandcoffee/Model/music_model.dart';
import 'package:cigarandcoffee/View/Page/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final AudioManager audioManager = Provider.of<AudioManager>(context);

    return SizedBox(
      width: 275,
      height: 240,
      child: ElevatedButton(
        onPressed: () async {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return MusicPage(musicData: musicData);
            },
          );
          await audioManager.playOneFile(musicData.audioName);
        },
        child: SizedBox(
          width: 275,
          height: 240,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('assets/images/${musicData.imageFile}'),
          ),
        ),
      ),
    );
  }
}
