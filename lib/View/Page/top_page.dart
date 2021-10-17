import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/gradation_background.dart';
import 'package:cirf_subscription_app/View/Molecule/main_app_bar.dart';
import 'package:cirf_subscription_app/View/Organism/scroll_list.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollList();


    /*MainAppBar(
      backColor: HexColor('#E7E7E7'),
      textColor: HexColor('#000000'),
      body: SafeArea(
        child: GradationBackGround(
          topColor: HexColor('#E7E7E7'),
          bottomColor: HexColor('#FFFFFF'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // const Expanded(flex: 1, child: ServicedeskArea()),
              // TODO(you): デザイン決定後、不要なViewの削除
              // const SizedBox(
              //   height: 20,
              // ),
              // const GraphArea(),
              // const SizedBox(
              //   height: 20,
              // ),
              // const TopCellButton(),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Expanded(flex: 9, child: ActivityArea()),
            ],
          ),
        ),
        top: true,
        bottom: false,
      ),
    );*/
  }
}
