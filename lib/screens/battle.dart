import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {

  final _formKey = GlobalKey<FormState>();

  Future<void> showQuestion(BuildContext context) async {
    return await showDialog(context: context, builder: (context) {
      final TextEditingController _textEditingController = TextEditingController();
      return AlertDialog(
        content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('2 + 3 = ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextFormField(
                  controller: _textEditingController,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Answer may not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Enter your answer"),
                ),
              ],
            )),
        actions: <Widget>[
          TextButton(
            child: const Text('Enter'),
            onPressed: (){
              if(_formKey.currentState!.validate()) {
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
      appBar: AppBar(title: const Text('This app bar is temporary')),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await showQuestion(context);
          },
          child: Text('Show Question',)
        ),
      ),
    );
  }
}
