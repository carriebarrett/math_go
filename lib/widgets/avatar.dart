import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import '../screens/collection.dart';

class Avatar extends StatelessWidget {
  final LocationData? locationData;
  const Avatar({Key? key, required this.locationData}) : super(key: key);

  Marker avatarMarker() {
    return Marker(
        width: 110.0,
        height: 110.0,
        point: latlng.LatLng(
            locationData!.latitude!, locationData!.longitude!),
        builder: (ctx) => this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CollectionScreen.routeName);
      },
      child: Image.asset('assets/images/user.png'),
    );
  }
}
