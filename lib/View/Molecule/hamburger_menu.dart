 import 'package:cigarandcoffee/Common/hex_color.dart';
 import 'package:cigarandcoffee/View/Atom/fit_text.dart';
 import 'package:cigarandcoffee/View/Atom/fixed_text.dart';
 import 'package:cigarandcoffee/View/Atom/gradation_background.dart';
 import 'package:cigarandcoffee/View/Atom/simple_icon.dart';
 import 'package:flutter/material.dart';

 import 'list_card.dart';



// ログアウト、プレイリスト、

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
             /*SizedBox(
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
                               icon:Icons.chevron_right_rounded,
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

              */

             SizedBox(
                 width: 330,
                 // ヘッダーの高さ＋ステータスバーの高さを指定する（グラデーション部分がステータスバーにくるため）
                 height: 50),//258
             Container(
               padding: const EdgeInsets.only(
                   top: 10, left: 20, right: 20, bottom: 10),
               child: Column(
                 children: <Widget>[
                   ListCard(
                     iconImage: '',
                     title: 'トップ',
                     onPressed: () {
                       //Navigator.pop(context);
                       Navigator.pushNamed(context, '/top');
                     },
                   ),
                   ListCard(
                     iconImage: '',
                     title: 'videoplayertest',
                     onPressed: () {
                       //Navigator.pop(context);
                       Navigator.pushNamed(context, '/videoplayer');
                     },
                   ),
                   /*ListCard(
                     iconImage: '',
                     title: '音声',
                     onPressed: () {
                       //Navigator.pop(context);//前画面にもどる
                       Navigator.pushNamed(context, '/audio');

                     },
                   ),
                   ListCard(
                     iconImage: '',
                     title: '孫子の兵法',
                     onPressed: () {
                       Navigator.pushNamed(context, '/artofwar');
                       //Navigator.pop(context);
                     },
                   ),
                   */
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }
 }
