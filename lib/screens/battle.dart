import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('This app bar is temporary')),
      body: const Center(
        child: Text("This is where it goes down"),
      ),
    );
  }
}
