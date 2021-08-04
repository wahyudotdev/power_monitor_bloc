import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';

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
