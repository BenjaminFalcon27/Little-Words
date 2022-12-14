import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:little_words/widgets/map.dart';
import 'package:location/location.dart';

import 'words.view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LittlewordsMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WordsScreen()));
          //TODO Ajouter code pour ouvrir sac
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.backpack),
      ),
    );
  }
}

Location location = new Location();

late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _locationData;

Future<dynamic> getLocation() async{
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) _serviceEnabled = await location.requestService();

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  _locationData = await location.getLocation();
  return _locationData;
}
