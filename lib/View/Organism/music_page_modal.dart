import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Molecule/music_control_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final MusicControlBloc bloc = Provider.of<MusicControlBloc>(context);

    return GestureDetector(
      onVerticalDragEnd: (DragEndDetails? details) {
      },
      child: Container(
        margin: const EdgeInsets.only(top: 64),
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: FutureBuilder<void>(
            future: bloc.playFromCard(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.network(musicData.imageFile),
                    FixedText(
                      text: musicData.audioName,
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                    MusicControlArea(
                      musicData: musicData,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
