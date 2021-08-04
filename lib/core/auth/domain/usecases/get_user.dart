import 'package:dartz/dartz.dart';
import '../entities/user_auth_info.dart';
import '../repositories/user_auth_repository.dart';
import '../../../error/failure.dart';
import '../../../usecases/no_params.dart';
import '../../../usecases/usecase.dart';

class GetUser extends UseCase<UserAuthInfo, NoParams> {
  final UserAuthRepository repository;

  GetUser(this.repository);
  @override
  Future<Either<Failure, UserAuthInfo>> call(NoParams params) async {
    return await repository.getUser();
  }
}
