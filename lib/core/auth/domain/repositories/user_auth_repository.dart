import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, UserAuthInfo>> signIn(
      {required String email, required String password});

  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserAuthInfo>> changeName({required String name});
  Future<Either<Failure, void>> changePassword({required String password});
  Future<Either<Failure, void>> forgotPassword({required String email});
  Future<Either<Failure, UserAuthInfo>> getUser();
}
