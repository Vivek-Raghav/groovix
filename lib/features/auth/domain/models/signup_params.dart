import 'package:json_annotation/json_annotation.dart';

part 'signup_params.g.dart';

@JsonSerializable()
class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
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

  AuthResponse({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
