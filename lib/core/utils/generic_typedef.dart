// Package imports:
import "package:dartz/dartz.dart";

// Project imports:
import 'package:groovix/core/error/failure.dart';

typedef EitherDynamic<T> = Future<Either<Failure, T>>;
