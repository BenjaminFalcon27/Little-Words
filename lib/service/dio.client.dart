import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:little_words/up.response.dart';

import '../models/word.model.dart';

class DioClient {
  final Dio dio = Dio();
  final baseUrl = 'https://backend.smallwords.samyn.ovh';
  final Provider<Dio> dioProvider = Provider<Dio>((ref) {
    final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://backend.smallwords.samyn.ovh',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));
    return dio;
  });

  // Post
  Future<Word?> throwWord({required Word word}) async {
    Word? retrievedUser;
    try {
      Response response = await dio.post(
        '$baseUrl/users',
        data: word.toJson(),
      );
      print('Word created: ${response.data}');
      retrievedUser = Word.fromJson(response.data);
    } catch (e) {
      print('Error creating word: $e');
    }
    return retrievedUser;
  }

  // Get
  Future<List<Word>?> getWordsAround({required LatLng location}) async {
    List<Word>? retrievedWords;
    try {
      Response response = await dio.get(
        '$baseUrl/word/around?latitude=${location.latitude}&longitude=${location.longitude}',
      );
      print('Words retrieved: ${response.data}');
      retrievedWords =
          (response.data as List).map((word) => Word.fromJson(word)).toList();
    } catch (e) {
      print('Error retrieving words: $e');
    }
    return retrievedWords;
  }
}
