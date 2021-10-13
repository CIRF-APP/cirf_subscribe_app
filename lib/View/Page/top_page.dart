import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/gradation_background.dart';
import 'package:cirf_subscription_app/View/Molecule/main_app_bar.dart';
import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainAppBar(
      backColor: HexColor('#FFA61C'),
      textColor: HexColor('#FFFFFFCC'),
      // TODO(you): rightImage(設定アイコン)押下時の処理
      rightOnPressed: () {},
      // TODO(you): ユーザ画像取得
      leftImage: const Icon(Icons.account_circle),
      rightImage: 'images/cog.png',
      body: SafeArea(
        child: GradationBackGround(
          topColor: HexColor('#F7C473'),
          bottomColor: HexColor('#FAF3E4'),
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
    );
  }
}
