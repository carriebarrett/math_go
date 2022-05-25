import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import '../models/beastie_model.dart';

class BeastieWidget extends StatelessWidget {
  final LocationData? initialLocationData;
  final Location locationService;
  BeastieWidget(
      {Key? key,
      required this.initialLocationData,
      required this.beastie,
      required this.onTapFn,
      required this.locationService})
      : super(key: key);
  final Function(Beastie) onTapFn;

  final Beastie beastie;
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
  late final double beastieLatitude =
      (initialLocationData?.latitude)! + randomLat;
  late final double beastieLongitude =
      (initialLocationData?.longitude)! + randomLon;
  late final double horizDistToAvatar =
      beastieLatitude - (initialLocationData?.latitude)!;
  late final double vertDistToAvatar =
      beastieLongitude - (initialLocationData?.longitude)!;

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

  Future<bool> isCloseEnough(BuildContext context) async {
    LocationData currLocationData = await locationService.getLocation();
    double? currLat = currLocationData.latitude;
    double? currLon = currLocationData.longitude;
    double latDifference = currLat! - beastieLatitude;
    double lonDifference = currLon! - beastieLongitude;
    double allowedDistPercent = 0.9;
    if (latDifference.abs() < latitudeRange * allowedDistPercent &&
        lonDifference.abs() < longitudeRange * allowedDistPercent) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isCloseEnough(context).then((isClose) {
          if (isClose) {
            return onTapFn(beastie);
          } else {
            return tooFarPopup(context);
          }
        });
      },
      child: Image.asset(beastie.imagePath),
    );
  }
}
