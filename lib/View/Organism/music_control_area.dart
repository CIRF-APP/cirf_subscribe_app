import 'package:cigarandcoffee/Bloc/play_button_bloc.dart';
import 'package:cigarandcoffee/Bloc/seek_bar_bloc.dart';
import 'package:cigarandcoffee/Common/audio_file.dart';
import 'package:cigarandcoffee/Common/audio_manager.dart';
import 'package:cigarandcoffee/Model/music_model.dart';
import 'package:cigarandcoffee/View/Atom/fixed_text.dart';
import 'package:cigarandcoffee/View/Molecule/play_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cigarandcoffee/View/Organism/seek_bar.dart';

class MusicControlArea extends StatelessWidget {
  const MusicControlArea({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final PlayButtonBloc bloc = Provider.of<PlayButtonBloc>(context);
    // final SeekBarBloc seekBarBloc = Provider.of<SeekBarBloc>(context);
    final AudioManager audioManager = Provider.of<AudioManager>(context);
    final AudioFile audioFile = audioManager.find(musicData.audioName) ?? AudioFile();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<double>(
            initialData: 0,
            stream: null,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              return SeekBar(
                onStartTrackingTouch: () {},
                onStopTrackingTouch: () {},
                onProgressChanged: (double value) {
                  //seekBarBloc.seekJumpController.sink.add(value);
                  // await audioFile.setPosition(value);
                  // print(value * audioFile.getTotalSecond());
                },
                value: snapshot.data ?? 0,
                progressWidth: 3.0,
              );
            },
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
