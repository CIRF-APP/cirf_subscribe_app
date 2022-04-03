import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Common/audio_file.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicSeekBar extends StatefulWidget {
  const MusicSeekBar({
    required this.musicData,
    required this.audioFile,
  });

  final MusicModel musicData;
  final AudioFile audioFile;

  @override
  State<StatefulWidget> createState() => _SeekBar();
}

class _SeekBar extends State<MusicSeekBar> {
  double cursorPos = 0;

  @override
  Widget build(BuildContext context) {
    final MusicControlBloc musicBloc = Provider.of<MusicControlBloc>(context);

    return StreamBuilder<Duration>(
      initialData: Duration.zero,
      stream: widget.audioFile.getPosition(),
      builder: (BuildContext context, AsyncSnapshot<Duration> nowPosition) {
        cursorPos = nowPosition.data!.inSeconds.toDouble() / widget.audioFile.getTotalSecond().toDouble();
        return Slider(
          value: cursorPos,
          onChanged: (double v) {
            musicBloc.moveSeek.add(v);
            setState(() {
              cursorPos = v;
              print(cursorPos);
            });
          },
        );
      },
    );
  }
}
