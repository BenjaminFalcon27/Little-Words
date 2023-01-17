import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:little_words/up.response.dart';

import '../dto/word.dto.dart';
import '../models/word.model.dart';

final Provider<Dio> dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
  return dio;
});

class DioClient {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
  final baseUrl = 'https://backend.smallwords.samyn.ovh';

  // Post word
  Future<WordDTO> throwWord({required Word word, required String uid}) async {
    Word wordToThrow = word;
    try {
      Response response = await dio.put(
        '$baseUrl/word/$uid',
        data: word,
      );
      print('Word posted: ${response.data}');
      wordToThrow = Word.fromJson(response.data);
    } catch (e) {
      print('Error posting word: $e');
    }

    return WordDTO.fromModel(wordToThrow);
  }

  // Get words around
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

  // Get word
  Future<Word?> getWord({required String id}) async {
    Word? retrievedWord;
    try {
      Response response = await dio.get(
        '$baseUrl/word/$id',
      );
      print('Word retrieved: ${response.data}');
      retrievedWord = Word.fromJson(response.data);
    } catch (e) {
      print('Error retrieving word: $e');
    }
    return retrievedWord;
  }

  // Get version
  Future<UpResponse?> getUp() async {
    UpResponse? upResponse;
    try {
      Response response = await dio.get(
        '$baseUrl/up',
      );
      print('Up response: ${response.data}');
      upResponse = UpResponse.fromJson(response.data);
    } catch (e) {
      print('Error retrieving up response: $e');
    }
    return upResponse;
  }
}
