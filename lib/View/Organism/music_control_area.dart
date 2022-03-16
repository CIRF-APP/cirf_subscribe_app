import 'package:cirf_subscription_app/Bloc/audio_database_bloc.dart';
import 'package:cirf_subscription_app/Bloc/play_button_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/play_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicControlArea extends StatelessWidget {
  const MusicControlArea({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final PlayButtonBloc bloc = Provider.of<PlayButtonBloc>(context);
    // final SeekBarBloc seekBarBloc = Provider.of<SeekBarBloc>(context);
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);
    //final AudioFile audioFile = audioManager.find(musicData.audioName) ?? AudioFile();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<String>(
                initialData: '0:00',
                stream: null,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return FixedText(
                    text: snapshot.data ?? '0:00',
                    size: 12,
                  );
                },
              ),
              // FixedText(
              //   text: audioFile.getAudioLength(),
              //   size: 12,
              // ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<bool>(
            stream: bloc.playStatus,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? false,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  bloc.pushButton.add(!(snapshot.data ?? false));
                  // await audioDatabaseBloc.playAudio(musicData.audioName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
