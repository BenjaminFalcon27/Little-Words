import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:little_words/up.response.dart';

import '../models/word.model.dart';

// Créer une instance de Dio
final dio = Dio();
final baseUrl = 'https://backend.smallwords.samyn.ovh';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
  return dio;
});

// Post
Future<Word?> createUser({required Word userInfo}) async {
  Word? retrievedUser;
  try {
    Response response = await dio.post(
      baseUrl + '/users',
      data: userInfo.toJson(),
    );
    print('Word created: ${response.data}');
    retrievedUser = Word.fromJson(response.data);
  } catch (e) {
    print('Error creating word: $e');
  }
  return retrievedUser;
}

// Get
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
