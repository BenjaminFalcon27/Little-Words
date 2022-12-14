import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_words/views/home.view.dart';
import 'package:little_words/themes/colors.dart';
import 'package:little_words/widgets/pseudo.widget.dart';

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
