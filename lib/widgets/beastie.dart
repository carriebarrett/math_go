import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import '../screens/battle.dart';

class Beastie extends StatelessWidget {
  final LocationData? locationData;
  const Beastie({Key? key, required this.locationData}) : super(key: key);

  Marker spawnMarker() {
    var random = Random();
    double longitudeRange = 0.00085;
    double latitudeRange = 0.00088;
    double horizAvatarPad = .00015;
    double vertAvatarPad = .00032;
    int randNum = random.nextInt(2);
    int sign = randNum == 0 ? -1 : 1;
    double randomLon = sign * (random.nextDouble() * longitudeRange + horizAvatarPad);
    double randomLat = sign * (random.nextDouble() * latitudeRange + vertAvatarPad);
    debugPrint('($randomLat, $randomLon)');
    return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng.LatLng((locationData?.latitude)! + randomLat,
            (locationData?.longitude)! + randomLon),
        builder: (ctx) => Beastie(locationData: locationData,));
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
