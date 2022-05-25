import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:location/location.dart';
import 'package:math_go/models/beastie_model.dart';
import 'package:math_go/screens/battle.dart';

import '../widgets/avatar.dart';
import '../widgets/beastie_widget.dart';
import '../widgets/compass.dart';
import '../constants.dart';
import './collection.dart';
import '/database/beasties.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen(
      {Key? key, required this.title, required this.collectionId})
      : super(key: key);

  final String title;
  final String collectionId;
  static const routeName = 'map view';

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  LocationData? locationData;
  var locationService = Location();
  final random = Random();
  late List<Marker> beastieMarkers = [];

  @override
  void initState() {
    super.initState();
    getLocation();
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

  void removeOutOfBoundsBeasties(
      List<Marker> markers, MapController mapController) {
    if (mapController.bounds != null) {
      for (int i = 0; i < markers.length; i++) {
        if (!mapController.bounds!.contains(markers[i].point)) {
          markers.remove(markers[i]);
        }
      }
    }
  }

  Future<void> onTapBeastie(Beastie beastie) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BattleScreen(
                title: appTitle,
                beastie: beastie,
                collectionId: widget.collectionId)));
  }

  Widget map(BuildContext context) {
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
            return FutureBuilder(
                future: BeastiesData().getBeasties(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final allBeastieList = snapshot.data;
                  while (beastieMarkers.length < 4) {
                    beastieMarkers.add(BeastieWidget(
                            initialLocationData: currLocation.data,
                            beastie: allBeastieList[
                                random.nextInt(allBeastieList.length)],
                            onTapFn: onTapBeastie,
                            locationService: locationService)
                        .spawnMarker());
                  }
                  mapController.onReady.then((_) {
                    mapController.move(mapCenter, zoomLevel);
                    removeOutOfBoundsBeasties(beastieMarkers, mapController);
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
                      MarkerLayerOptions(markers: [...beastieMarkers]),
                    ],
                  );
                });
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
          map(context),
          const Avatar(),
          IgnorePointer(child: buildCompass())
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CollectionScreen(
                        title: appTitle, collectionId: widget.collectionId))),
          },
          child: const Icon(Icons.collections_bookmark),
        ));
  }
}
