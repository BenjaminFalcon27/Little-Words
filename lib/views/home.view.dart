import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_words/views/word.view.dart';
import 'package:little_words/widgets/map.widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'words.view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LittlewordsMap(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: Theme.of(context).primaryColor,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.backpack),
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WordsScreen()));
              },
              label: 'Sac à mots',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: const Color(0xFF801E48)),
          // FAB 2
          SpeedDialChild(
              child: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WordScreen()));
              },
              label: 'Nouveau mot',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: const Color(0xFF801E48))
        ],
      ),
    );
  }
}
