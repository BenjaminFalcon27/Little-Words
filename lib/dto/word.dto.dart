import 'dart:convert';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:little_words/models/word.model.dart';

part 'word.dto.g.dart';

@JsonSerializable()
class WordDTO {
  WordDTO(this.uid, this.author, this.content, this.latitude, this.longitude);

  final int? uid;
  final String? author;
  final String? content;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => _$WordDTOToJson(this);

  factory WordDTO.fromJson(Map<String, dynamic> json) =>
      _$WordDTOFromJson(json);

  // Créer un word dto avec le résultat d'une requête SqlLite
  static fromResultSet(Map<String, dynamic> map) => WordDTO.fromJson(map);

  static Future<WordDTO> fromModel(Word wordToThrow) {
    return Future.value(WordDTO(
      wordToThrow.uid,
      wordToThrow.author,
      wordToThrow.content,
      wordToThrow.latitude,
      wordToThrow.longitude,
    ));
  }
}
