import 'package:dartz/dartz.dart';
import '../entities/user_auth_info.dart';
import '../repositories/user_auth_repository.dart';
import '../../../error/failure.dart';
import '../../../usecases/usecase.dart';

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
