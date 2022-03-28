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
    final PlayButtonBloc buttonBloc = Provider.of<PlayButtonBloc>(context);
    final AudioDatabaseBloc audioDatabaseBloc = Provider.of<AudioDatabaseBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Slider(
            value: 0.5,
            onChanged: (double v) {},
          ),
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
            stream: buttonBloc.playStatus,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? false,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  buttonBloc.pushButton.add(!(snapshot.data ?? false));
                  await audioDatabaseBloc.playAudio(musicData.audioName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
