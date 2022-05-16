import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import '../screens/battle.dart';

class Beastie extends StatelessWidget {
  final LocationData? locationData;
  Beastie({Key? key, required this.locationData}) : super(key: key);
    
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
  // debugPrint('($randomLat, $randomLon)');
  late final double beastieLatitude = (locationData?.latitude)! + randomLat;
  late final double beastieLongitude = (locationData?.longitude)! + randomLon;

  Marker spawnMarker() {
    return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng.LatLng(beastieLatitude, beastieLongitude),
        builder: (ctx) => this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(BattleScreen.routeName);
      },
      child: Image.asset('assets/images/beasties/blob1.png'),
    );
  }
}
