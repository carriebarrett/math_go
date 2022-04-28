import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';

import 'package:math_go/.mapbox_credentials.dart';

import '../widgets/beastie.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);
  static const routeName = 'map view';

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  LocationData? locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: [
        FlutterMap(
          options: MapOptions(
            center: latlng.LatLng(locationData?.latitude ?? 51.5,
                locationData?.longitude ?? -0.09),
            zoom: 18.0,
            interactiveFlags: InteractiveFlag.none,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: mapboxURL,
                attributionBuilder: (_) {
                  return const Text("© Mapbox");
                },
                additionalOptions: {
                  'accessToken': mapboxAPIKey,
                  'id': 'mapbox.mapbox-streets-v8'
                }),
            MarkerLayerOptions(
              markers: [
                Marker(
                    width: 40.0,
                    height: 40.0,
                    point: latlng.LatLng(51.5, -0.09),
                    builder: (ctx) => Beastie())
              ],
            ),
          ],
        ),
        const Positioned(
          bottom: 0,
          left: 1,
          right: 1,
          child: Image(
            height: 80.0,
            width: 80.0,
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
