import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/login/domain/entities/user_auth_info.dart';
import '../entities/user_form.dart';

abstract class UserRegisterRepository {
  Future<Either<Failure, UserAuthInfo>> registerUser(
      {required UserForm userForm});
}
