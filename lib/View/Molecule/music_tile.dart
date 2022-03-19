import 'package:cirf_subscription_app/Model/music_model.dart';
import 'package:cirf_subscription_app/View/Atom/fixed_text.dart';
import 'package:cirf_subscription_app/View/Page/music_page_modal.dart';
import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({
    required this.musicData,
  });

  final MusicModel musicData;

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;

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
        onPressed: () async {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/${musicData.imageFile}', width: 80, height: 80),
            ),
            const SizedBox(width: 30),
            FixedText(
              text: musicData.audioName,
              size: 30,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
    );
  }
}
