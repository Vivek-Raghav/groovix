import 'package:groovix/core/shared/model/user_model.dart';
import 'package:groovix/core/utils/generic_typedef.dart';

abstract class UserRepository {
  EitherDynamic<UserModel> createUser(UserModel user);
  EitherDynamic<UserModel> getUserById(String userId);
  EitherDynamic<UserModel> getUserByEmail(String email);
  EitherDynamic<UserModel> updateUser(UserModel user);
  EitherDynamic<bool> deleteUser(String userId);
  EitherDynamic<bool> userExists(String userId);
}
