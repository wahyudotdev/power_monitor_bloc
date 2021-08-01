import 'package:firebase_auth/firebase_auth.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/network/network_info.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuth auth;
  UserAuthRepositoryImpl({
    required this.networkInfo,
    required this.auth,
  });
  @override
  Future<Either<Failure, UserAuthInfo>> changeName(
      {required String name}) async {
    if (await networkInfo.isConnected) {
      try {
        await auth.currentUser!.updateDisplayName(name);
        final result = auth.currentUser;
        return Right(UserAuthInfo(
            email: result!.email!,
            displayName: result.displayName!,
            frontName: result.displayName!.split('')[0]));
      } catch (e) {
        return Left(UserUpdateFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await auth.currentUser!.updatePassword(password);
        return Right(null);
      } catch (e) {
        return Left(UserUpdateFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    if (await networkInfo.isConnected) {
      await auth.sendPasswordResetEmail(email: email);
      return Right(null);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuthInfo>> signIn(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        return Right(UserAuthInfo(
            email: result.user!.email!,
            displayName: result.user!.displayName!,
            frontName: result.user!.displayName!.split('')[0]));
      } catch (e) {
        return Left(UserLoginFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await networkInfo.isConnected) {
      await auth.signOut();
      return Right(null);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuthInfo>> getUser() async {
    if (await networkInfo.isConnected) {
      final user = auth.currentUser;
      if (user != null) {
        return Right(UserAuthInfo(
            email: user.email!,
            displayName: user.displayName!,
            frontName: user.displayName!.split(' ')[0]));
      } else {
        return Left(UserLoginFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
