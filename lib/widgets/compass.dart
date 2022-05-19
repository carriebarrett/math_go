import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

Widget buildCompass() {
  return StreamBuilder<CompassEvent>(
    stream: FlutterCompass.events,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error reading heading: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      double? direction = snapshot.data!.heading;

      // If direction is null, then device does not support this sensor
      // show error message
      if (direction == null) {
        return const Center(
          child: Text("Device does not have sensors !"),
        );
      }
      double compassImageOffset = 45; // the compass image default is NE

      return Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: ((direction + compassImageOffset) * (math.pi / 180) * -1),
            child: Image.asset(
              'assets/images/logos_and_icons/compass_orange.png',
              height: 50,
              width: 50,
            ),
          ));
    },
  );
}
