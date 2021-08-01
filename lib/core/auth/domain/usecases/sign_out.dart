import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

class SignOut extends UseCase<void, NoParams> {
  final UserAuthRepository repository;

  SignOut(this.repository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
