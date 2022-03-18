import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Page/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    // final AudioDatabaseBloc bloc = Provider.of<AudioDatabaseBloc>(context);
    final double displayWidth = MediaQuery.of(context).size.width;

    return Container(
      width: displayWidth,
      height: 80,
      color: Colors.black,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/${musicData.imageFile}', width: 80, height: 80),
            ),
          ],
        ),
      ),
    );
  }
}
