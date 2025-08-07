import 'package:groovix/features/auth/auth_index.dart';

class LoginUc extends UseCase<bool, LoginParams> {
  LoginUc({required this.authRepository});
  final AuthRepository authRepository;
  @override
  EitherDynamic<bool> call(LoginParams params) =>
      authRepository.loginViaEmail(params);
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}
