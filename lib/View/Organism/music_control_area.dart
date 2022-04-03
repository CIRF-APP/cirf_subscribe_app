import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
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
    final MusicControlBloc musicBloc = Provider.of<MusicControlBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<double>(
            initialData: 0,
            stream: musicBloc.nowTime,
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              return Slider(
                value: snapshot.data ?? 0,
                onChanged: (double v) {
                  musicBloc.moveSeek.add(v);
                },
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
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<bool>(
            stream: musicBloc.playStatus,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? false,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  musicBloc.pushButton.add(!(snapshot.data ?? false));
                  await musicBloc.playAudio();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
