import 'package:cirf_subscription_app/Common/hex_color.dart';
import 'package:cirf_subscription_app/View/Atom/FitText.dart';
import 'package:cirf_subscription_app/View/Atom/FixedText.dart';
import 'package:cirf_subscription_app/View/Atom/gradation_background.dart';
import 'package:cirf_subscription_app/View/Atom/simple_icon.dart';
import 'package:flutter/material.dart';

import 'list_card.dart';


class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({
    required this.targetName,
    required this.targetTel,
    required this.targetIcon,
  });

  final String targetName;
  final String targetTel;
  final Widget targetIcon;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GradationBackGround(
        topColor: HexColor('#F5C170'),
        bottomColor: HexColor('#FEF5E4'),
        startPoint: 0.3,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              width: 330,
              // ヘッダーの高さ＋ステータスバーの高さを指定する（グラデーション部分がステータスバーにくるため）
              height: 258 + MediaQuery.of(context).padding.top,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    targetIcon,
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      // TODO(you): 名前と電話番号のエリア押下時の処理
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 286.0,
                          maxHeight: 60.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 35.0,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 150.0,
                                          maxHeight: 30.0,
                                        ),
                                        child: FitText(
                                          text: targetName,
                                          size: 24,
                                          color: HexColor('FDF3E4'),
                                          weight: FontWeight.bold,
                                          lineHeight: 1.0,
                                          minFontSize: 17,
                                        ),
                                      ),
                                      FixedText(
                                        text: 'さん',
                                        size: 12,
                                        color: HexColor('FDF3E4'),
                                        lineHeight: 3.0,
                                      ),
                                    ],
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 160.0,
                                    maxHeight: 25.0,
                                  ),
                                  child: FitText(
                                    text: targetTel,
                                    size: 18,
                                    color: HexColor('FDF3E4'),
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SimpleIcon(
                              icon: Icon(Icons.chevron_right_rounded),
                              color: Colors.white,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 286,
                      height: 40,
                      child: ElevatedButton(
                        child: const FixedText(
                          text: '見守り対象を変更',
                          size: 16,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.black54,
                          primary: HexColor('#FCB74C'),
                          onPrimary: HexColor('#FFA61C'),
                          shape: const StadiumBorder(),
                        ),
                        // TODO(you): ボタン押下時の処理（見守り対象変更）
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: HexColor('#FFA61C'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Column(
                children: <Widget>[
                  ListCard(
                    title: '活動量',
                    iconImage: 'images/heart-solid.png',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListCard(
                    title: '活動量ログ',
                    iconImage: 'images/file.png',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/activity_log');
                    },
                  ),
                  ListCard(
                    title: '通知一覧',
                    iconImage: 'images/info-circle-hamburger.png',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/notification_list');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
