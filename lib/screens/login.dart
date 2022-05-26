import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:math_go/constants.dart';

import 'map_view.dart';
import 'tutorial.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Checks if a user is currently logged in.
  bool _isDisabled() {
    return false;
    // return FirebaseAuth.instance.currentUser == null;
  }

  final _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // currentUser might be null at first for erroneous reasons
    // so we need to wait until it's not null
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        // Set initial values on sign in  with Google
        final User? user = auth.currentUser;
        final path = user?.uid;
        final userDatabase = _database.child('/Users/').child(path!);
        userDatabase.update({
          'userID': user?.uid,
          'beastieCollectionID': user?.uid,
          'email': user?.email
        });

        // Setup the Beastie Collection for the user
        final addCollection =
            _database.child('/BeastieCollection/').child(path);
        addCollection
            .update({'beastieCollectionID': user?.uid, 'beastieIDs': '[]'});
      }
    });
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    super.initState();
    //Ensures that buttons are greyed out if user is not logged in.
    _isDisabled();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/logos_and_icons/background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 200,
              height: 125,
              child:
                  Image.asset("assets/images/logos_and_icons/logoshrink.png")),
          ElevatedButton(
              style: style,
              //Button is disabled if user is not logged in.
              onPressed: _isDisabled()
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapViewScreen(
                                  title: appTitle,
                                  collectionId:
                                      'F7pByf4fiUfGApYkGlOOjez1MW23')));
                    },
              child: const Text("Existing Account")),
          const SizedBox(
            width: 25,
            height: 25,
          ),
          ElevatedButton(
              style: style,
              onPressed: () async {
                await signInWithGoogle();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Tutorial(
                            title: appTitle,
                            collectionId: 'F7pByf4fiUfGApYkGlOOjez1MW23')));
                setState(() {
                  _isDisabled();
                });
              },
              child: const Text("Sign in using Google")),
          const SizedBox(
            width: 25,
            height: 25,
          ),
          ElevatedButton(
              style: style,
              onPressed: _isDisabled()
                  ? null
                  : () async {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isDisabled();
                      });
                    },
              child: const Text("Sign out"))
        ]));
  }
}
