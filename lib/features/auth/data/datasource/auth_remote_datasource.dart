import 'dart:convert';

import 'package:groovix/core/constants/string_constants.dart';
import 'package:groovix/core/error/server_exception.dart';
import 'package:groovix/core/services/api_service.dart';
import 'package:groovix/core/services/api_urls.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> loginViaEmail(SignInParams params);
  Future<AuthResponse> signUpViaEmail(SignUpParams params);
  Future<bool> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  final LocalCache _cache = getIt<LocalCache>();
  final apiService = getIt<ApiService>();

  @override
  Future<AuthResponse> loginViaEmail(SignInParams params) async {
    try {
      final response =
          await apiService.post(ApiUrls.login, data: params.toJson());
      if (response.statusCode == 200) {
        if (response.headers.value("authorization") != null) {
          _cache.setString(
              PrefKeys.token, response.headers.value("authorization") ?? "");
        }
        return AuthResponse.fromJson(response.data);
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Auth Login Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }

  @override
  Future<AuthResponse> signUpViaEmail(SignUpParams params) async {
    try {
      final response =
          await apiService.post(ApiUrls.signup, data: params.toJson());
      if (response.statusCode == 201) {
        if (response.headers.value("authorization") != null) {
          _cache.setString(
              PrefKeys.token, response.headers.value("authorization") ?? "");
        }
        return AuthResponse.fromJson(response.data);
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Auth Sign Up Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }

  @override
  Future<bool> logout() async {
    final cachedUser = _cache.getMap(PrefKeys.userDetails);
    final user = AuthResponse.fromJson(cachedUser ?? {});
    try {
      final response = await apiService.post(ApiUrls.logout,
          data: jsonEncode({'id': user.id}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Auth Sign Up Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }
}
