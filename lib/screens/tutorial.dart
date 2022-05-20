import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:math_go/screens/map_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

var tutorials = [
  {
    "prompt":
        '''Welcome to the world of Math Go, ${user!.displayName!}. This is a brief tutorial to help you get acclimated to the world around you. Click on this chat bubble when you are ready to proceed.''',
    "asset": ""
  },
  {
    "prompt":
        '''The game map will display your current position and any beasties nearby. If you tap a beastie, you will be prompted for a question. Answer it correctly, and the beastie is yours!. Be warned, if you input the wrong answer, the beastie will flee!''',
    "asset": "assets/images/logos_and_icons/sample_map.png"
  },
  {
    "prompt": '''That's all there is to it! Good luck and have fun!''',
    "asset": "assets/images/logos_and_icons/question.png"
  }
];

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key, required this.title}) : super(key: key);

  final String title;
  //Each prompt represents a new animated text bubble
  //final String firstPrompt = tutorials["firstScreen"]!;
  //final String secondPrompt = tutorials["secondScreen"]!;
  //final String thirdPrompt = tutorials["thirdScreen"]!;
  static const routeName = "Tutorial";

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  //Tracks which screen to utilize
  int screenCounter = 0;
  //Saves string to be used for animated text
  String currentString = "";
  //Saves path to image asset for displaying map
  String asset = "";

  @override
  void initState() {
    super.initState();
    currentString = tutorials[screenCounter]['prompt']!;
  }

  //Contains the box holding screencaptures that are displayed during tutorial
  //Initially the widget is created to take up whitespace until an asset file is provided
  Widget imageContainer(BuildContext context, String asset) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.40,
        decoration: asset == ""
            ? null
            : BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.black)),
        alignment: Alignment.center,
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.15,
            child: asset == "" ? null : Image.asset(asset)));
  }

  //Contains the animated text, currentString changes with each onTap.
  Widget customText(String currentString) {
    return AnimatedTextKit(
        animatedTexts: [TypewriterAnimatedText(currentString)],
        isRepeatingAnimation: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/logos_and_icons/background.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
              bottom: MediaQuery.of(context).size.height * 0.25),
          child: Column(
            children: [
              imageContainer(context, asset),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/logos_and_icons/leaf1.png")
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      //String used in customText is set here.
                      //Each tap increments the counter, and ultimately routes to
                      //game map.
                      onTap: () {
                        screenCounter++;
                        if (screenCounter == 3) {
                          Navigator.of(context)
                              .pushNamed(MapViewScreen.routeName);
                          return; //Prevents invoking setState when routing.
                        }
                        setState(() {
                          currentString = tutorials[screenCounter]['prompt']!;
                          asset = tutorials[screenCounter]['asset']!;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            key:
                                UniqueKey(), //This is necessary for the animation to repeat on each click.
                            padding: const EdgeInsets.all(10),
                            child: customText(currentString), //Animated text
                          )),
                    ),
                  ),
                ],
              ),
            ],
          )),
    ));
  }
}
