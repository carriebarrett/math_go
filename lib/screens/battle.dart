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
  String optionSelected = '';

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
    Navigator.pop(context, BattleResult.lost);
  }

  // This is a placeholder for more complex logic when we have the
  // actual question from the db
  bool isCorrectAnswer(answer, expectedResponse) {
    return expectedResponse is String
        ? answer == expectedResponse
        : answer == expectedResponse.toString();
  }

// placeholder function to add the beastie to the db
  void addBeastieToCollection() {
    BeastieCollectionsData()
        .updateCollection(widget.collectionId, widget.beastie.beastieID);
  }

  Widget form() {
    if (['true', 'false'].contains(widget.beastie.answer.toString())) {
      return Column(
        children: [
          FormField(
              validator: (value) => null,
              onSaved: (Object? _) {
                _answerDTO.answer = optionSelected;
              },
              builder: (FormFieldState state) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            optionSelected = 'true';
                            setState(() {});
                          },
                          child: const Text('True',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green))),
                      TextButton(
                          onPressed: () {
                            optionSelected = 'false';
                            setState(() {});
                          },
                          child: const Text('False',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)))
                    ]);
              }),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('You selected: '), Text(optionSelected)],
          )
        ],
      );
    }
    return TextFormField(
      textAlign: TextAlign.center,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Answer may not be empty';
        }
        return null;
      },
      onSaved: (value) {
        _answerDTO.answer = value as String;
      },
      decoration: const InputDecoration(hintText: "Enter your answer"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(logoImage, height: 40),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  widget.beastie.imagePath,
                  fit: BoxFit.contain, // Fixes border issues
                  width: 100,
                  height: 100,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.beastie.question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        const SizedBox(height: 5),
                        form(),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: const Text('Exit battle',
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Fleeing the battle!'),
                        ));
                        Navigator.pop(context, BattleResult.fledBattle);
                      },
                    ),
                    TextButton(
                      child: const Text('Enter'),
                      onPressed: () {
                        final validatedAnswer =
                            _formKey.currentState!.validate();
                        if (validatedAnswer) {
                          _formKey.currentState?.save();
                          var beastieName = widget.beastie.name;
                          if (isCorrectAnswer(
                              _answerDTO.answer, widget.beastie.answer)) {
                            addBeastieToCollection();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'You successfully captured $beastieName'),
                            ));
                            Navigator.pop(context, BattleResult.captured);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('$beastieName got away!'),
                            ));
                            Navigator.pop(context, BattleResult.lost);
                          }
                        }
                      },
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
