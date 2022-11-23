import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_words/up.response.dart';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
  return dio;
});

final versionProvider = FutureProvider<String>((ref) async {
  final Dio dio = ref.read(dioProvider);
  final Response response = await dio.get('/up');

  // On transforme la réponse en string
  var jsonAsString = response.toString();
  // On transforme le string en map<String, dynamic>
  final Map<String, dynamic> jsonDecoded = jsonDecode(jsonAsString);

  // On instancie UpResponse
  final UpResponse upResponse = UpResponse.fromJson(jsonDecoded);

  // On retourne un des attributs de UpResponse
  return upResponse.version;
});
