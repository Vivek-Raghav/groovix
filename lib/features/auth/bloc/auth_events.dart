import 'package:groovix/features/auth/auth_index.dart';

sealed class AuthEvent {
  const AuthEvent();
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final LoginParams params;
  AuthLoginEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class AuthSignupEvent extends AuthEvent {
  final SignUpParams params;
  AuthSignupEvent({required this.params});
  @override
  List<Object?> get props => [params];
}

class AuthLogoutEvent extends AuthEvent {
  AuthLogoutEvent();
}
