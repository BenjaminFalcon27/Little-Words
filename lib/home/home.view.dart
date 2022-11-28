import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_words/dio.provider.dart';
import 'package:little_words/version.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Version(),
          ElevatedButton(
              onPressed: () async {
                final AsyncValue<String> value = ref.read(versionProvider);
                value.when(data: (data) {
                  print('response: $data');
                }, error: (object, stackTrace) {
                  print(object.toString());
                  print(stackTrace.toString());
                }, loading: () {
                  print("loading");
                });
              },
              child: const Text('Get backend version')),
        ],
      )),
    );
  }
}
