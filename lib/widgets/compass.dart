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
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      double? direction = snapshot.data!.heading;

      // if direction is null, then device does not support this sensor
      // show error message
      if (direction == null)
        return Center(
          child: Text("Device does not have sensors !"),
        );

      double compass_image_offset = 45; // the compass image default is NE

      return
          // Material(
          // shape: CircleBorder(),
          // clipBehavior: Clip.antiAlias,
          // elevation: 4.0,
          // child:
          Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Transform.rotate(
          angle: ((direction + compass_image_offset) * (math.pi / 180) * -1),
          child: Image.asset(
            'images/compass.png',
            height: 50,
            width: 50,
        ),
      ));
      //);
    },
  );
}
