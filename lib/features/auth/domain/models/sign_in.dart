// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'sign_in.g.dart';

@JsonSerializable()
class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });

  /// From JSON
  factory SignInParams.fromJson(Map<String, dynamic> json) =>
      _$SignInParamsFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$SignInParamsToJson(this);
}
