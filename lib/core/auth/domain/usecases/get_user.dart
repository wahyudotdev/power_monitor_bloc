import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';
import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

class GetUser extends UseCase<UserAuthInfo, NoParams> {
  final UserAuthRepository repository;

  GetUser(this.repository);
  @override
  Future<Either<Failure, UserAuthInfo>> call(NoParams params) async {
    return await repository.getUser();
  }
}
