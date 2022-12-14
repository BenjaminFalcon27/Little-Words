import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:little_words/views/home.view.dart';
import 'package:little_words/themes/colors.dart';
import 'package:little_words/widgets/pseudo.widget.dart';
import 'package:location/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LittleWords',
      theme: MyTheme.defaultTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("LittleWords"),
        ),
        body: const PseudoWidget(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Divider(height: 32),
          ],
        ),
      ),
    );
  }
}
