import 'package:groovix/features/auth/auth_index.dart';

abstract class AuthRepository {
  EitherDynamic<bool> loginViaEmail(LoginParams params);
  EitherDynamic<bool> signUpViaEmail(SignUpParams params);
  EitherDynamic<bool> logout();
}
