import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Common/enum_set.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/Model/music_status_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:cirf_subscription_app/View/Molecule/play_button.dart';
import 'package:cirf_subscription_app/View/Organism/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallestMusic extends StatelessWidget {
  const SmallestMusic({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;
    final MusicControlBloc bloc = Provider.of<MusicControlBloc>(context);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
        side: MaterialStateProperty.all<BorderSide>(const BorderSide(
          color: Colors.white,
          width: 3.0,
        )),
        fixedSize: MaterialStateProperty.all<Size>(Size(displayWidth - 20, 80)),
        alignment: Alignment.center,
      ),
      onPressed: () {
        bloc.tapMusic.add(MusicStatusModel(
          status: MusicPageStatus.smallest,
          model: musicData,
        ));

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return MusicPage(musicData: musicData);
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.cover,
            child: Image.network(musicData.imageFile, width: 80, height: 80),
          ),
          FixedText(
            text: musicData.audioName,
            size: 30,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          StreamBuilder<bool>(
            initialData: true,
            stream: bloc.playStatus,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return PlayButton(
                isPlay: snapshot.data ?? true,
                musicTitle: musicData.audioName,
                onPressed: () async {
                  bloc.pushButton.add(!bloc.targetAudio.isPlay());
                  await bloc.playFromButton();
                },
                padding: const EdgeInsets.only(bottom: 20),
                size: 50,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: () async {
                bloc.tapMusic.add(MusicStatusModel(
                  status: MusicPageStatus.disabled,
                  model: musicData,
                ));
                await bloc.stopMusic();
              },
              icon: const SimpleIcon(
                icon: Icons.cancel_presentation_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
