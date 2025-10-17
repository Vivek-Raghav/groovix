// Project imports:
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';

abstract class AuthRepository {
  EitherDynamic<AuthResponse> loginViaEmail(SignInParams params);
  EitherDynamic<AuthResponse> signUpViaEmail(SignUpParams params);
  EitherDynamic<bool> logout();
}
