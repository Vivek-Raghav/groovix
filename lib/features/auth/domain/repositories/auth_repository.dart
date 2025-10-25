// Project imports:
import 'package:groovix/features/auth/auth_index.dart';

abstract class AuthRepository {
  EitherDynamic<AuthResponse> loginViaEmail(SignInParams params);
  EitherDynamic<AuthResponse> signUpViaEmail(SignUpParams params);
  EitherDynamic<bool> logout();
}
