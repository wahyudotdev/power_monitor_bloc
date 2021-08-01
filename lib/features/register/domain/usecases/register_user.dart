import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/auth/domain/entities/user_auth_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_form.dart';
import '../repositories/user_register_repository.dart';

class RegisterUser implements UseCase<UserAuthInfo, Params> {
  final UserRegisterRepository repository;

  RegisterUser(this.repository);
  @override
  Future<Either<Failure, UserAuthInfo>> call(Params params) async {
    return await repository.registerUser(userForm: params.userForm);
  }
}

class Params extends Equatable {
  final UserForm userForm;

  Params({required this.userForm});
  @override
  List<Object?> get props => [userForm];
}
