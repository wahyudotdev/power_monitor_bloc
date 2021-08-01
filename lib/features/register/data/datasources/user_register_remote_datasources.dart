import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/auth/domain/entities/user_auth_info.dart';
import '../../domain/entities/user_form.dart';

abstract class UserRegisterRemoteDataSource {
  Future<UserAuthInfo> createUser({required UserForm userForm});
}

class UserRegisterRemoteDataSourceImpl implements UserRegisterRemoteDataSource {
  final FirebaseAuth auth;

  UserRegisterRemoteDataSourceImpl(this.auth);
  @override
  Future<UserAuthInfo> createUser({required UserForm userForm}) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: userForm.email, password: userForm.password);
      await result.user!.updateDisplayName(userForm.displayName);
      final user = auth.currentUser;
      return UserAuthInfo(
        displayName: user!.displayName!,
        email: user.email!,
        frontName: user.displayName!.split(' ')[0],
      );
    } catch (e) {
      throw UserRegisterException();
    }
  }
}
