import 'package:flutter/material.dart';
import '../screens/battle.dart';

class Beastie extends StatelessWidget {
  const Beastie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Navigator.of(context).pushNamed(BattleScreen.routeName)},
      child: Container(
        child: const Image(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
        ),
      ),
    );
  }
}