import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';
import 'package:math_go/constants.dart';
//import 'package:math_go/database/beasties.dart';

import '../models/beastie_model.dart';
import '../screens/battle.dart';

class BeastieWidget extends StatelessWidget {
  final LocationData? locationData;
  BeastieWidget({Key? key, required this.locationData}) : super(key: key);

  final random = Random();
  final double longitudeRange = 0.00085;
  final double latitudeRange = 0.00088;
  final double horizAvatarPad = .00015;
  final double vertAvatarPad = .00032;
  late final int randNum = random.nextInt(2);
  late final int sign = randNum == 0 ? -1 : 1;
  late final double randomLon =
      sign * (random.nextDouble() * longitudeRange + horizAvatarPad);
  late final double randomLat =
      sign * (random.nextDouble() * latitudeRange + vertAvatarPad);
  late final double beastieLatitude = (locationData?.latitude)! + randomLat;
  late final double beastieLongitude = (locationData?.longitude)! + randomLon;
  late final double horizDistToAvatar =
      beastieLatitude - (locationData?.latitude)!;
  late final double vertDistToAvatar =
      beastieLongitude - (locationData?.longitude)!;

  // final BeastiesData beastiesData = BeastiesData();
  // late final List<Beastie> allBeastieList = beastiesData.beasties;
  late final List<Beastie> allBeastieList = [
    Beastie(
        beastieID: 1,
        question: '1+1',
        answer: '2',
        imagePath: 'assets/images/beasties/blob1.png',
        name: 'blob1',
        type: 'math'),
    Beastie(
        beastieID: 2,
        question: '2+2',
        answer: '4',
        imagePath: 'assets/images/beasties/leaf1.png',
        name: 'leaf1',
        type: 'math')
  ];
  late final Beastie randomBeastie =
      allBeastieList[random.nextInt(allBeastieList.length)];

  Marker spawnMarker() {
    return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng.LatLng(beastieLatitude, beastieLongitude),
        builder: (ctx) => this);
  }

  Future<void> tooFarPopup(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Move closer to capture that beastie!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if ((horizDistToAvatar.abs() < latitudeRange * .9) &&
            vertDistToAvatar.abs() < longitudeRange * .9) {
          Navigator.push(
            context, 
            MaterialPageRoute(builder:(context) => BattleScreen(title: appTitle, beastie: randomBeastie)));
        } else {
          await tooFarPopup(context);
        }
      },
      child: Image.asset(randomBeastie.imagePath),
    );
  }
}

