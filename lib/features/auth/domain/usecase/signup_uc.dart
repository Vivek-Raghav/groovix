import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/auth/domain/repositories/auth_repository.dart';

class SignupUc extends UseCase<bool, SignUpParams> {
  SignupUc({required this.authRepository});
  final AuthRepository authRepository;
  @override
  EitherDynamic<bool> call(SignUpParams params) =>
      authRepository.signUpViaEmail(params);
}

class SignUpParams {
  final String email;
  final String password;
  SignUpParams({required this.email, required this.password});
}
