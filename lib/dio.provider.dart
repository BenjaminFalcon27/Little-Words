import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://backend.smallwords.samyn.ovh',
    connectTimeout: 10000,
    receiveTimeout: 10000,
  ));
  return dio;
});