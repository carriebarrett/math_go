import 'package:flutter/material.dart';
import '../screens/collection.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CollectionScreen.routeName);
      },
      child: Image.asset('assets/images/user.png'),
    );
  }
}