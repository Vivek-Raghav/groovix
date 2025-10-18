import 'package:groovix/features/auth/domain/models/signup_params.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final AuthResponse data;
  AuthLoginSuccess({required this.data});
}

class AuthLoginFailure extends AuthState {
  final String error;
  AuthLoginFailure({required this.error});
}

class AuthSignupLoading extends AuthState {}

class AuthSignupSuccess extends AuthState {
  final AuthResponse data;
  AuthSignupSuccess({required this.data});
}

class AuthSignupFailure extends AuthState {
  final String error;
  AuthSignupFailure({required this.error});

}

class AuthLogoutLoading extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  final String error;
  AuthLogoutFailure({required this.error});
}
