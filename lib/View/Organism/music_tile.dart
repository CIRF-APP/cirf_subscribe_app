import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Common/ads_interstitial.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Organism/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicTile extends StatefulWidget {
  const MusicTile({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  State<StatefulWidget> createState() {
    return _MusicTileState();
  }
}

class _MusicTileState extends State<MusicTile> {
  AdsInterstitial adsInterstitial = AdsInterstitial();

  @override
  void initState() {
    super.initState();
    adsInterstitial.interstitialLoad();
  }

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;
    final MusicControlBloc bloc = Provider.of<MusicControlBloc>(context);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        side: MaterialStateProperty.all<BorderSide>(const BorderSide(
          color: Colors.white,
          width: 3.0,
        )),
        fixedSize: MaterialStateProperty.all<Size>(Size(displayWidth - 20, 80)),
        alignment: Alignment.center,
      ),
      onPressed: () {
        bloc.setMusicData.add(widget.musicData);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return MusicPage(musicData: widget.musicData);
          },
        );

        adsInterstitial.show(() async {
          await bloc.playFromCard();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.cover,
            child: Image.network(widget.musicData.imageFile, width: 80, height: 80),
          ),
          const SizedBox(width: 30),
          FixedText(
            text: widget.musicData.audioName,
            size: 30,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
