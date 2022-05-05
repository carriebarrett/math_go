import 'package:flutter/material.dart';
import 'package:math_go/screens/map_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/logos_and_icons/background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/images/logos_and_icons/logoshrink.png")),
          ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.of(context).pushNamed(MapViewScreen.routeName);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const MapViewScreen()));
              },
              child: const Text("Existing Account")),
          const SizedBox(
            width: 25,
            height: 25,
          ),
          ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text("Sign in using Google"))
        ]));
  }
}
