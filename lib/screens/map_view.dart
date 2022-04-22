import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);
  static const routeName = 'map view';

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(children: [
        FlutterMap(
          options: MapOptions(
            center: latlng.LatLng(51.5, -0.09),
            zoom: 18.0,
            interactiveFlags: InteractiveFlag.none,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/jorellana28/", // I removed this url for privacy so this won't work
                attributionBuilder: (_) {
                  return const Text("© Mapbox");
                },
                additionalOptions: {'id': 'mapbox.mapbox-streets-v8'}),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: latlng.LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: const Image(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    ),
                  ),
                ),
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