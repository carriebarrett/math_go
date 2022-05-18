import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

var tutorialText = {
  "firstScreen":
      '''Welcome to the world of Math Go, ${user!.displayName!}. This is a brief tutorial to help you get acclimated to the world around you. Click on this chat bubble when you are ready to proceed.''',
  "secondScreen":
      '''The game map will display your current position and any beasties nearby. If you tap a beastie, you will be prompted for a question. Answer it correctly, and the beastie is yours!. Be warned, if you input the wrong answer, the beastie will flee!''',
  "thirdScreen": '''That's all there is to it! Good luck and have fun!'''
};
