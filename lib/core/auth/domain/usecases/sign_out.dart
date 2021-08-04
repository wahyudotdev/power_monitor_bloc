import '../repositories/user_auth_repository.dart';
import '../../../error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../usecases/no_params.dart';
import '../../../usecases/usecase.dart';

class SignOut extends UseCase<void, NoParams> {
  final UserAuthRepository repository;

  SignOut(this.repository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
