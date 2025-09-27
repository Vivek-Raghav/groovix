import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';
import 'package:groovix/features/auth/domain/repositories/auth_repository.dart';

class SignupUc extends UseCase<AuthResponse, SignUpParams> {
  SignupUc({required this.authRepository});
  final AuthRepository authRepository;
  @override
  EitherDynamic<AuthResponse> call(SignUpParams params) =>
      authRepository.signUpViaEmail(params);
}
