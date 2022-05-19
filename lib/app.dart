import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/battle.dart';
import 'screens/map_view.dart';
import 'screens/collection.dart';
import 'screens/tutorial.dart';
import 'screens/login.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = {
    MapViewScreen.routeName: (context) => const MapViewScreen(title: appTitle),
    BattleScreen.routeName: (context) => const BattleScreen(title: appTitle),
    CollectionScreen.routeName: (context) => const CollectionScreen(title: appTitle),
    Tutorial.routeName: (context) => const Tutorial(title: appTitle)
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
