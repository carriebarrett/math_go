import 'package:flutter/material.dart';
import 'package:math_go/screens/home.dart';
import 'package:math_go/screens/map_view.dart';
// import 'package:math_go/screens/map_view.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _routes = {
    // ignore: todo
    // MapViewScreen.routeName: (context) => const MapViewScreen(), // TODO: Will probably move everything to a separate screen
    HomeScreen.routeName: (context) => const HomeScreen(title: 'Math Go')
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapViewScreen(),
      routes: _routes,
    );
  }
}
