import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key, required this.title}) : super(key: key);

  final String title;
  static const routeName = "Tutorial";

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/logos_and_icons/background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(user!.displayName!)])),
    );
  }
}
