import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/usecase/signup_uc.dart';

abstract class AuthRepository {
  EitherDynamic<bool> loginViaEmail(LoginParams params);
  EitherDynamic<bool> signUpViaEmail(SignUpParams params);
  EitherDynamic<bool> logout();
}
