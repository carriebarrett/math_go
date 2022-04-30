import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  String title;
  BattleScreen({Key? key, required this.title}) : super(key: key);
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(widget.title))),
      body: const Center(
        child: Text("This is where it goes down"),
      ),
    );
  }
}
