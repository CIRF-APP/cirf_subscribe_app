import 'package:cirf_subscription_app/Bloc/music_control_bloc.dart';
import 'package:cirf_subscription_app/Common/ads_interstitial.dart';
import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Organism/music_page_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCard extends StatefulWidget {
  const MusicCard({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  State<StatefulWidget> createState() {
    return _MusicCardState();
  }
}

class _MusicCardState extends State<MusicCard> {
  AdsInterstitial adsInterstitial = AdsInterstitial();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MusicControlBloc bloc = Provider.of<MusicControlBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: GestureDetector(
            onTap: () {
              bloc.setMusicData.add(widget.musicData);
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                enableDrag: false,
                context: context,
                builder: (BuildContext context) {
                  return MusicPage(musicData: widget.musicData);
                },
              );

              setState(() {
                adsInterstitial.interstitialLoad();
              });

              adsInterstitial.show(() async {
                await bloc.playFromCard();
              });
            },
            child: Image.network(widget.musicData.imageFile),
          ),
        ),
        const SizedBox(height: 5),
        FixedText(
          text: widget.musicData.audioName,
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
