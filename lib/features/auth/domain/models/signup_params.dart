// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'signup_params.g.dart';

@JsonSerializable()
class SignUpParams {
  final String name;
  final String email;
  final String password;

  @JsonKey(name: 'secret_key')
  String? secretKey;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    this.secretKey,
  });

  /// From JSON
  factory SignUpParams.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamsFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SignUpParamsToJson(this);
}

@JsonSerializable()
class AuthResponse {
  final String id;
  final String name;
  final String email;
  final String role;

  AuthResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
