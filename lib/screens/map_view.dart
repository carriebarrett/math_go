import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';
import 'package:math_go/database/beasties.dart';
import 'package:math_go/models/beastie_model.dart';

import '../widgets/avatar.dart';
import '../widgets/beastie_widget.dart';
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
  late Avatar myAvatar = Avatar(locationData: locationData);
  final random = Random();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    setMapBeasties();
  }

  void setMapBeasties() async {
    await getLocation();

    final BeastiesData beastiesData = BeastiesData();
    final List<Beastie> allBeastieList = await beastiesData.getBeasties();

    markers = [
      myAvatar.avatarMarker(),
      // This is hardcoded to 3 but we could use a for loop with a random number
      // to generate a random number of beasties if we wanted to
      ...[1, 2, 3].map((_) => BeastieWidget(
              locationData: locationData,
              beastie: allBeastieList[random.nextInt(allBeastieList.length)])
          .spawnMarker())
    ];
    setState(() {});
  }

  Future<void> getLocation() async {
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
    setState(() {});
  }

  Widget map(BuildContext context, List<Marker> markers) {
    MapControllerImpl mapController = MapControllerImpl();
    if (locationData == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return StreamBuilder(
          stream: locationService.onLocationChanged.asBroadcastStream(),
          builder: (context, AsyncSnapshot<LocationData> currLocation) {
            if (!currLocation.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            latlng.LatLng mapCenter = latlng.LatLng(
                currLocation.data!.latitude!, currLocation.data!.longitude!);
            const zoomLevel = 18.0;
            mapController.onReady.then((_) {
              mapController.move(mapCenter, zoomLevel);
            });
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                zoom: zoomLevel,
                interactiveFlags: InteractiveFlag.none,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate: dotenv.env['MAPBOX_URL'],
                    attributionBuilder: (_) {
                      return const Text("© Mapbox");
                    },
                    additionalOptions: {
                      'accessToken': dotenv.env['MAPBOX_API_KEY']!,
                      'id': 'mapbox.mapbox-streets-v8'
                    }),
                MarkerLayerOptions(markers: markers),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset(logoImage, height: 40),
          automaticallyImplyLeading: false),
      body: Center(
          child: Stack(children: [
        map(context, markers),
        IgnorePointer(child: buildCompass())
      ])),
      // borrowed this button temporarily to link to collection screen
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            {Navigator.of(context).pushNamed(CollectionScreen.routeName)},
        child: const Icon(Icons.collections_bookmark),
      ),
    );
  }
}
