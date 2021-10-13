import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/Page/top_page.dart';

void main() {
  runApp(const CirfApp());
}

class CirfApp extends StatelessWidget {
  const CirfApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 画面遷移用
      routes: <String, WidgetBuilder>{
        // 画面名「/top」トップ画面
        '/top': (BuildContext context) => const TopPage(),
      },
      // Blocパターン用
      home: const TopPage(),
    );
  }
}
