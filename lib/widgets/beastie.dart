import 'package:flutter/material.dart';
import '../screens/battle.dart';

class Beastie extends StatelessWidget {
  const Beastie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BattleScreen.routeName);
      },
      child: Image.asset('images/beasties/blob1.png'),
    );
  }
}
