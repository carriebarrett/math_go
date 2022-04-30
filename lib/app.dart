import 'package:flutter/material.dart';
import 'package:math_go/screens/battle.dart';
import 'package:math_go/screens/home.dart';
import 'package:math_go/screens/map_view.dart';

String appTitle = 'Math GO!';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = {
    // ignore: todo
    // MapViewScreen.routeName: (context) => MapViewScreen(title: appTitle), // TODO: Will probably move everything to a separate screen
    HomeScreen.routeName: (context) => HomeScreen(title: appTitle),
    BattleScreen.routeName: (context) => BattleScreen(title: appTitle),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapViewScreen(title: appTitle),
      routes: _routes,
    );
  }
}
