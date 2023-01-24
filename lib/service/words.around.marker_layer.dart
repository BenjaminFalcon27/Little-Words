import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../dto/word.dto.dart';
import '../providers/words_around.provider.dart';

class WordsAroundMarkerLayer extends ConsumerWidget {
  const WordsAroundMarkerLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(wordsAroundProvider)
        .when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(List<WordDTO> words) {
    final List<Marker> markers = <Marker>[];
    for (final WordDTO w in words) {
      var wordPosition = LatLng(w.latitude!, w.longitude!);
      markers.add(Marker(
          point: wordPosition,
          builder: (context) {
            return _WordMarkerContent(w);
          }));
    }
    return MarkerLayer(markers: markers);
  }

  Widget _onLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _onError(error, stack) {
    return Container(
      color: Colors.red.withOpacity(0.9),
    );
  }

  GestureDetector _WordMarkerContent(WordDTO w) {
    return GestureDetector(
      onTap: () {
        print(w.uid);
      },
      child: const Icon(Icons.message_rounded,
          color: Colors.purpleAccent, size: 30.0),
    );
  }
}
