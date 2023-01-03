import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tuple/tuple.dart';

import '../dto/word.dto.dart';

class LittlewordsMap extends StatelessWidget {
  LittlewordsMap({Key? key}) : super(key: key);

  final _mapController = MapController();

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<dynamic> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    return _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          zoom: 18.0,
          onMapReady: () {
            getLocation().then((value) {
              _mapController.move(
                  LatLng(value.latitude, value.longitude), 18.0);
              print(value);
            });
          }),
      mapController: _mapController,
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
      ],
    );
  }
}

// class WordsAroundMarkerLayer extends ConsumerWidget {
//     const WordsAroundMarkerLayer({Key? key}) : super(key: key);

//     @override
//     Widget build(BuildContext context, WidgetRef ref){
//       return ref.watch(wordsAroundProvider).map(data: (data){
//         return Text('data ${data.value}');
//       }, error: (error){
//         return Text('error : $error');
//       } ,loading: (loading){
//         return const CircularProgressIndicator();
//       });
//     }
//   }
