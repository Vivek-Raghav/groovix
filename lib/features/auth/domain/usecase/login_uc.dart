// Project imports:
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';

class LoginUc extends UseCase<AuthResponse, SignInParams> {
  LoginUc({required this.authRepository});
  final AuthRepository authRepository;
  @override
  EitherDynamic<AuthResponse> call(SignInParams params) =>
      authRepository.loginViaEmail(params);
}
