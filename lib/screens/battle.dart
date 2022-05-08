import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../constants.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final _formKey = GlobalKey<FormState>();
  late ArCoreController arCoreController;

  Future<void> _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    final bytes = (await rootBundle.load('assets/images/beasties/blob1.png')).buffer.asUint8List();
    final beastie = ArCoreImage(bytes: bytes, width: 100, height: 100);
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
              TextButton(
                child: const Text('Enter'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(logoImage, height: 40)
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
 /*       child: TextButton(
          onPressed: () async {
            await showQuestion(context);
          },
          child: const Text('Show Question',),
        ),*/
      ),
    );
  }
}
