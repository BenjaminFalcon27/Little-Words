import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:little_words/providers/device.location.provider.dart';
import 'package:little_words/service/words.around.marker_layer.dart';
import 'package:location/location.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

// ignore: must_be_immutable
class LittlewordsMap extends ConsumerWidget {
  LittlewordsMap({Key? key}) : super(key: key);

  final _mapController = MapController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(deviceLocationProvider)
        .when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(LatLng? data) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: data!,
        zoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        CurrentLocationLayer(),
        const WordsAroundMarkerLayer(),
      ],
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return Container(
      color: Colors.red.withOpacity(0.9),
    );
  }

  Widget _onLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
