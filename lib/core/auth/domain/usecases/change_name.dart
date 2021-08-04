import 'package:dartz/dartz.dart';
import '../entities/user_auth_info.dart';
import '../repositories/user_auth_repository.dart';
import '../../../error/failure.dart';
import '../../../usecases/usecase.dart';

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
