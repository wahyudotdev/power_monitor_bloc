import '../../../../core/error/exception.dart';
import '../../../../core/login/domain/entities/user_auth_info.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_register_remote_datasources.dart';
import '../../domain/entities/user_form.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_register_repository.dart';

class UserRegisterRepositoryImpl implements UserRegisterRepository {
  final UserRegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  UserRegisterRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserAuthInfo>> registerUser(
      {required UserForm userForm}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.createUser(userForm: userForm);
        return Right(result);
      } on UserRegisterException {
        return Left(UserRegisterFailure());
      }
    } else
      return Left(ServerFailure());
  }
}
