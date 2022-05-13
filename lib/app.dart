import 'package:flutter/material.dart';
import 'package:math_go/screens/battle.dart';
import 'package:math_go/screens/home.dart';
import 'package:math_go/screens/map_view.dart';
import 'package:math_go/screens/collection.dart';
import 'package:math_go/screens/tutorial.dart';
import 'screens/login.dart';

String appTitle = 'Math GO!';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = {
    MapViewScreen.routeName: (context) => MapViewScreen(title: appTitle),
    HomeScreen.routeName: (context) => HomeScreen(title: appTitle),
    BattleScreen.routeName: (context) => BattleScreen(title: appTitle),
    CollectionScreen.routeName: (context) => CollectionScreen(title: appTitle),
    Tutorial.routeName: (context) => Tutorial(title: appTitle)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: _routes,
    );
  }
}
