import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';
import 'map_view.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 30000), handleTimeout);
  }

  void handleTimeout() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('The beastie got away!'),
    ));
    Navigator.of(context).pushNamed(MapViewScreen.routeName);
  }

  Future<void> showQuestion(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                      child: Container(
                        alignment: FractionalOffset.topRight,
                        child: GestureDetector(
                          child: const Icon(Icons.close_rounded),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '2 + 3 = ?',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      textAlign: TextAlign.center,
                      controller: _textEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Answer may not be empty';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter your answer"),
                    ),
                  ],
                )),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    child: const Text('Exit battle',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Fleeing the battle!'),
                      ));
                      Navigator.of(context).pushNamed(MapViewScreen.routeName);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text('Enter'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Image.asset(logoImage, height: 40)),
      body: Center(
        child: TextButton(
            onPressed: () async {
              await showQuestion(context);
            },
            child: const Text(
              'Show Question',
            )),
      ),
    );
  }
}
