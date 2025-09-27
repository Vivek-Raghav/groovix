import 'package:dartz/dartz.dart';
import 'package:groovix/core/constants/string_constants.dart';
import 'package:groovix/core/error/failure.dart';
import 'package:groovix/core/error/server_exception.dart';
import 'package:groovix/features/auth/auth_index.dart';
import 'package:groovix/features/auth/domain/models/sign_in.dart';
import 'package:groovix/features/auth/domain/models/signup_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  EitherDynamic<AuthResponse> loginViaEmail(SignInParams params) async {
    try {
      final data = await authRemoteDataSource.loginViaEmail(params);
      if (data.id.isNotEmpty) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(
            error: StringConstants.strSomethingWentWrong,
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }

  @override
  EitherDynamic<bool> logout() async {
    try {
      final data = await authRemoteDataSource.logout();
      if (data) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(
            error: StringConstants.strSomethingWentWrong,
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }

  @override
  EitherDynamic<AuthResponse> signUpViaEmail(SignUpParams params) async {
    try {
      final data = await authRemoteDataSource.signUpViaEmail(params);
      if (data.id.isNotEmpty) {
        return Right(data);
      } else {
        return Left(
          ServerFailure(
            error: StringConstants.strSomethingWentWrong,
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(error: e.error));
    }
  }
}
