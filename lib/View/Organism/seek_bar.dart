import 'package:cigarandcoffee/Bloc/play_button_bloc.dart';
import 'package:cigarandcoffee/Common/audio_file.dart';
import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:cigarandcoffee/Model/music_model.dart';
import 'package:cigarandcoffee/View/Atom/fixed_text.dart';
import 'package:cigarandcoffee/View/Molecule/play_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final PlayButtonBloc bloc = Provider.of<PlayButtonBloc>(context);
    final AudioManager audioManager = Provider.of<AudioManager>(context);
    final AudioFile audioFile = audioManager.find(musicData.audioName) ?? AudioFile();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            height: 5,
            color: Colors.white,
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
              FixedText(
                text: audioFile.getAudioLength(),
                size: 12,
              ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<bool>(
            stream: bloc.writeController.stream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? false,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  bloc.actionController.sink.add(!(snapshot.data ?? false));
                  await audioManager.playOneFile(musicData.audioName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
