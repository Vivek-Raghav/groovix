import 'package:groovix/core/utils/generic_typedef.dart';

abstract class UserRepository {
  EitherDynamic<bool> deleteUser(String userId);
  EitherDynamic<bool> userExists(String userId);
}
