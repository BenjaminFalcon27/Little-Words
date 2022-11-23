import 'package:freezed_annotation/freezed_annotation.dart';

part 'up.response.g.dart';

@JsonSerializable()
class UpResponse {
  // Constructeur
  UpResponse(this.version);

  //  Attributs de class
  final String version;

  // FactoryJSON
  factory UpResponse.fromJson(Map<String, dynamic> json) =>
      _$UpResponseFromJson(json);
}

// Command: flutter pub run build_runner build
