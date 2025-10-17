class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String error;
  AuthLoginFailure({required this.error});
}

class AuthSignupLoading extends AuthState {}

class AuthSignupSuccess extends AuthState {}

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
