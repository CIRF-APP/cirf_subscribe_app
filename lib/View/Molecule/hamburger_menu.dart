import 'package:cirf_subscription_app/Service/auth_service.dart';
import 'package:cirf_subscription_app/View/Molecule/list_card.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                ListCard(
                  title: 'プレイリスト',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.menu,
                ),
                ListCard(
                  title: 'パスワード変更',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/pass_change');
                  },
                  icon: Icons.settings,
                ),
                ListCard(
                  title: 'ログアウト',
                  onPressed: () {
                    Navigator.pop(context);
                    AuthService.logOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
