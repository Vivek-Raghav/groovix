// Project imports:
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';

sealed class AuthEvent {
  const AuthEvent();
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final SignInParams params;
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
