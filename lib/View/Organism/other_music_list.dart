import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Organism/music_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherMusicList extends StatelessWidget {
  const OtherMusicList({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioDatabaseBloc bloc = Provider.of<AudioDatabaseBloc>(context);

    return Center(
      child: StreamBuilder<List<MusicModel>>(
        stream: bloc.allMusic,
        builder: (BuildContext context, AsyncSnapshot<List<MusicModel>> musicList) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const FixedText(
                text: 'その他',
                size: 24,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 10),
              for (MusicTile tile in convertMusicTile(musicList.data)) tile,
            ],
          );
        },
      ),
    );
  }

  List<MusicTile> convertMusicTile(List<MusicModel>? musicList) {
    if (musicList == null) {
      return <MusicTile>[];
    } else {
      final List<MusicTile> musicTiles = <MusicTile>[];
      for (final MusicModel music in musicList) {
        musicTiles.add(MusicTile(musicData: music));
      }
      return musicTiles;
    }
  }
}
