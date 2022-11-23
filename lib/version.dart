import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_words/dio.provider.dart';

class Version extends ConsumerWidget {
  const Version({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, widget) {
      return ref.watch(versionProvider).when(data: (version) {
        return Text(version);
      }, error: (error, stack) {
        return const Text("Impossible de récupérer la version");
      }, loading: () {
        return const CircularProgressIndicator();
      });
    });
    ;
  }
}
