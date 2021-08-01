import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

class ChangePassword extends UseCase<void, ChangePasswordParams> {
  final UserAuthRepository repository;

  ChangePassword(this.repository);
  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(password: params.password);
  }
}

class ChangePasswordParams {
  final String password;

  ChangePasswordParams({required this.password});
}
