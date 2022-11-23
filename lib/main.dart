import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                  child: FlutterMap(
                options: MapOptions(zoom: 8),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
