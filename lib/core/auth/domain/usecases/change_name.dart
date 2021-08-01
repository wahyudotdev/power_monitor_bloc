import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';
import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

class ChangeName extends UseCase<UserAuthInfo, ChangeNameParams> {
  final UserAuthRepository repository;

  ChangeName(this.repository);
  @override
  Future<Either<Failure, UserAuthInfo>> call(params) async {
    return await repository.changeName(name: params.name);
  }
}

class ChangeNameParams {
  final String name;

  ChangeNameParams({required this.name});
}
