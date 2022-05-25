import 'dart:async';

import 'package:flutter/material.dart';

import 'package:math_go/database/answer_dto.dart';
import 'package:math_go/database/beastie_collection.dart';

import '../constants.dart';
import '../models/beastie_model.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen(
      {Key? key,
      required this.title,
      required this.beastie,
      required this.collectionId})
      : super(key: key);
  final Beastie beastie;
  final String title;
  final String collectionId;
  static const routeName = 'battle';
  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final _formKey = GlobalKey<FormState>();
  final AnswerDTO _answerDTO = AnswerDTO();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 30000), handleTimeout);
  }

  void handleTimeout() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('The beastie got away!'),
    ));
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  // This is a placeholder for more complex logic when we have the
  // actual question from the db
  bool isCorrectAnswer(answer, expectedResponse) {
    return answer == expectedResponse;
  }

// placeholder function to add the beastie to the db
  void addBeastieToCollection() {
    BeastieCollectionsData()
        .updateCollection(widget.collectionId, widget.beastie.beastieID);
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
                    Text(
                      widget.beastie.question,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
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
                      onSaved: (value) {
                        _answerDTO.answer = value as String;
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
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text('Enter'),
                    onPressed: () {
                      final validatedAnswer = _formKey.currentState!.validate();
                      if (validatedAnswer) {
                        _formKey.currentState?.save();
                        // The answer and beastie name are hardcoded until
                        // we have data from db
                        var beastieName = widget.beastie.name;
                        if (isCorrectAnswer(_answerDTO.answer, widget.beastie.answer)) {
                          addBeastieToCollection();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content:
                                Text('You successfully captured $beastieName'),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text('$beastieName got away!'),
                          ));
                        }
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
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
      backgroundColor: Colors.cyan[100],
      appBar:
          AppBar(centerTitle: true, title: Image.asset(logoImage, height: 40)),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await showQuestion(context);
          }, // Image tapped
          child: Image.asset(
            widget.beastie.imagePath,
            fit: BoxFit.contain, // Fixes border issues
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
