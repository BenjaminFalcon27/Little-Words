import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Expanded(
            child: FlutterMap(
          options: MapOptions(center: LatLng(50.95129, 1.858686), zoom: 18.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //TODO Ajouter code pour ouvrir sac
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.backpack),
      ),
    );
  }
}
