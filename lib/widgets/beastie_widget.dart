import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';
import 'package:math_go/constants.dart';
// import 'package:math_go/database/beasties.dart';

import '../models/beastie_model.dart';
import '../screens/battle.dart';

class BeastieWidget extends StatelessWidget {
  final LocationData? locationData;
  BeastieWidget({Key? key, required this.locationData}) : super(key: key);
  final random = Random();

  late final double beastieLatitude = setLatitude();
  late final double beastieLongitude = setLongitude();

  double setLatitude() {
    int randNum = random.nextInt(2);
    int sign = randNum == 0 ? -1 : 1;
    double randomLat =
        sign * (random.nextDouble() * latitudeRange + vertAvatarPad);
    double beastieLatitude = (locationData?.latitude)! + randomLat;
    return beastieLatitude;
  }

  double setLongitude() {
    int randNum = random.nextInt(2);
    int sign = randNum == 0 ? -1 : 1;
    double randomLon =
        sign * (random.nextDouble() * longitudeRange + horizAvatarPad);
    double beastieLongitude = (locationData?.longitude)! + randomLon;
    return beastieLongitude;
  }
  // final BeastiesData beastiesData = BeastiesData();
  // late final Future<List> beastiesFuture = beastiesData.getBeasties();
  // late final List<Beastie> allBeastieList = await beastiesData.getBeasties();

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

  // Beastie getRandomBeastie() {
  //   BeastiesData beastiesData = BeastiesData();
  //   beastiesData.getBeasties().then((allBeastiesList) {
  //     Beastie randomBeastie =
  //         allBeastiesList[random.nextInt(allBeastiesList.length)];
  //         return randomBeastie;
  //   });
  // }

  late final Beastie randomBeastie =
      allBeastieList[random.nextInt(allBeastieList.length)];

  Marker spawnMarker() {
    return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng.LatLng(beastieLatitude, beastieLongitude),
        builder: (ctx) => this);
  }

  // this popup will show when you are too far from the beastie that you clicked
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BattleScreen(title: appTitle, beastie: randomBeastie)));
      },
      child: Image.asset(randomBeastie.imagePath),
    );
  }
}
