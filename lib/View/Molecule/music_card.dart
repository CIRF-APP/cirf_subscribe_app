import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Page/music_page_modal.dart';
import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    // final AudioDatabaseBloc bloc = Provider.of<AudioDatabaseBloc>(context);

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
          // await bloc.playAudio(musicData.audioName);
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
