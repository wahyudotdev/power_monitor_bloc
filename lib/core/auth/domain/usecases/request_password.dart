import '../repositories/user_auth_repository.dart';
import '../../../error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../usecases/usecase.dart';

class RequestPassword extends UseCase<void, EmailParams> {
  final UserAuthRepository repository;

  RequestPassword(this.repository);
  @override
  Future<Either<Failure, void>> call(EmailParams params) async {
    return await repository.forgotPassword(email: params.email);
  }
}

class EmailParams {
  final String email;

  EmailParams({required this.email});
}
