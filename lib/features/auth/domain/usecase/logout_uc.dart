// Project imports:
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/auth/domain/repositories/auth_repository.dart';

class LogoutUc extends UseCase<bool, NoParams> {
  LogoutUc({required this.authRepository});
  final AuthRepository authRepository;
  @override
  EitherDynamic<bool> call(NoParams params) => authRepository.logout();
}
