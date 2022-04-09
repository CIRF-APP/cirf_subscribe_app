import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/music_seek_bar.dart';
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
          MusicSeekBar(
            musicData: musicData,
            audioFile: musicBloc.targetAudio,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<Duration>(
                initialData: Duration.zero,
                stream: musicBloc.targetAudio.getPosition(),
                builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                  return FixedText(
                    text: convertDuration(snapshot.data),
                    size: 12,
                  );
                },
              ),
              FixedText(
                text: musicBloc.targetAudio.getAudioLength(),
                size: 12,
              ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<bool>(
            initialData: true,
            stream: musicBloc.playStatus,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? true,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  musicBloc.pushButton.add(!musicBloc.targetAudio.isPlay());
                  await musicBloc.playFromButton();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  String convertDuration(Duration? duration) {
    if(duration == null){
      return '0:00';
    } else {
      int seconds = duration.inSeconds;
      int minutes = 0;
      int hours = 0;

      while (seconds >= 60) {
        minutes++;
        seconds -= 60;
      }

      while (minutes >= 60) {
        hours++;
        minutes -= 60;
      }

      String sStr = seconds.toString();
      String mStr = minutes.toString();
      String hStr = hours.toString();

      if(sStr.length == 1)
        sStr = '0$sStr';
      if(mStr.length == 1)
        mStr = '0$mStr';
      if(hStr.length == 1)
        hStr = '0$hStr';

      String nowTime = hStr == '00' ? '' : hStr;
      nowTime += '$mStr:$sStr';
      return nowTime;
    }
  }
}
