import 'dart:math';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import '../.mapbox_credentials.dart';
import '../widgets/avatar.dart';
import '../widgets/beastie.dart';
import '../widgets/compass.dart';
import '../constants.dart';
import './collection.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  static const routeName = 'map view';

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          debugPrint('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          debugPrint('Location service permission not granted. Returning.');
          return;
        }
      }

      locationData = await locationService.getLocation();

    } on PlatformException catch (e) {
      debugPrint('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Widget map(BuildContext context) {
    if (locationData == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return FlutterMap(
        options: MapOptions(
          center: latlng.LatLng(
              locationData?.latitude ?? 51.5, locationData?.longitude ?? -0.09),
          zoom: 18.0,
          interactiveFlags: InteractiveFlag.none,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: mapboxURL, // ignore: undefined_identifier
              attributionBuilder: (_) {
                return const Text("© Mapbox");
              },
              additionalOptions: {
                'accessToken': mapboxAPIKey, // ignore: undefined_identifier
                'id': 'mapbox.mapbox-streets-v8'
              }),
          MarkerLayerOptions(
            markers: [
              Marker(
                  width: 110.0,
                  height: 110.0,
                  point: latlng.LatLng(locationData?.latitude ?? 51.5,
                      locationData?.longitude ?? -0.09),
                  builder: (ctx) => const Avatar()),
              spawnBeastie(),
              spawnBeastie(),
              spawnBeastie()
            ],
          ),
        ],
      );
    }
  }

  Marker spawnBeastie() {
    var random = Random();
    double longitudeRange = 0.00085;
    double latitudeRange = 0.00088;
    int randNum = random.nextInt(2);
    int sign = 0;
    if (randNum == 0) {
      sign = -1;
    } else {
      sign = 1;
    }
    double randomLon = sign * (random.nextDouble() * longitudeRange + .00015);
    double randomLat = sign * (random.nextDouble() * latitudeRange + .00032);
    debugPrint('($randomLat, $randomLon)');
    return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng.LatLng((locationData?.latitude ?? 51.5) + randomLat,
            (locationData?.longitude! ?? -0.09) + randomLon),
        builder: (ctx) => const Beastie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(logoImage, height: 40),
        automaticallyImplyLeading: false
        ),
      body: Center(
          child: Stack(children: [
        map(context),
        IgnorePointer(child: buildCompass())
      ])),
      // borrowed this button temporarily to link to collection screen
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {Navigator.of(context).pushNamed(CollectionScreen.routeName)},
        child: const Icon(Icons.add),
      ),
    );
  }
}
