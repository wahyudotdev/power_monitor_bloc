import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';
import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

class SignIn extends UseCase<UserAuthInfo, AuthParams> {
  final UserAuthRepository repository;

  SignIn(this.repository);
  @override
  Future<Either<Failure, UserAuthInfo>> call(AuthParams params) async {
    return await repository.signIn(
        email: params.email, password: params.password);
  }
}

class AuthParams {
  final String email;
  final String password;

  AuthParams({required this.email, required this.password});
}
