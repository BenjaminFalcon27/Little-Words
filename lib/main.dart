import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:little_words/views/form.view.dart';
import 'package:little_words/views/home.view.dart';
import 'package:little_words/themes/colors.dart';
import 'package:location/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LittleWords',
      theme: MyTheme.defaultTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("LittleWords"),
        ),
        body: const FormView(),
      ),
    );
  }
}
