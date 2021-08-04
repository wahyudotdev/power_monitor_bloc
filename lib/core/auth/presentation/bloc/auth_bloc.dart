import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../domain/entities/user_auth_info.dart';
import '../../domain/usecases/request_password.dart';
import '../../domain/usecases/usecases.dart';
import '../../../error/failure.dart';
import '../../../usecases/no_params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.changeName,
      required this.changePassword,
      required this.requestPassword,
      required this.getUser,
      required this.signIn,
      required this.signOut})
      : super(AuthInitial());

  final ChangeName changeName;
  final ChangePassword changePassword;
  final RequestPassword requestPassword;
  final GetUser getUser;
  final SignIn signIn;
  final SignOut signOut;

  UserAuthInfo? currentUser;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield AuthLoading();
      final result = await signIn(
          AuthParams(email: event.email, password: event.password));
      yield* result.fold((failure) async* {
        if (failure is ServerFailure) {
          yield AuthenticationFail(message: ServerFailure.MESSAGE);
        }
        if (failure is UserLoginFailure) {
          yield AuthenticationFail(message: UserLoginFailure.MESSAGE);
        }
      }, (userInfo) async* {
        currentUser = userInfo;
        await FirebaseMessaging.instance.subscribeToTopic('notification');
        yield UserAuthenticated(userAuthInfo: userInfo);
      });
    }

    if (event is GetUserEvent) {
      yield AuthLoading();
      final result = await getUser(NoParams());
      yield* result.fold((failure) async* {
        yield AuthenticationFail(message: 'Gagal mengautentikasi user');
      }, (userInfo) async* {
        currentUser = userInfo;

        yield UserAuthenticated(userAuthInfo: userInfo);
      });
    }

    if (event is SignOutEvent) {
      yield AuthLoading();
      final result = await signOut(NoParams());
      yield* result.fold((failure) async* {}, (userInfo) async* {
        await FirebaseMessaging.instance.unsubscribeFromTopic('notification');
        yield LogoutSuccess();
      });
    }

    if (event is ChangeNameEvent) {
      yield AuthLoading();
      final result = await changeName(ChangeNameParams(name: event.name));
      yield* result.fold((failure) async* {
        yield UpdateFailure(message: 'Gagal mengubah nama');
      }, (authInfo) async* {
        currentUser = authInfo;
        yield UpdatedProfile(
            authInfo: authInfo, message: 'Berhasil mengubah nama');
      });
    }

    if (event is ChangePasswordEvent) {
      yield AuthLoading();
      final result =
          await changePassword(ChangePasswordParams(password: event.password));
      yield* result.fold((failure) async* {
        yield UpdateFailure(message: 'Gagal mengubah password');
      }, (authInfo) async* {
        yield UpdatedProfile(
            authInfo: currentUser!, message: 'Berhasil mengubah password');
      });
    }

    if (event is ForgotPasswordEvent) {
      yield AuthLoading();
      final result = await requestPassword(EmailParams(email: event.email));
      yield* result.fold((failure) async* {
        if (failure is UserNotFoundFailure) {
          yield EmailNotSent(message: UserNotFoundFailure.MESSAGE);
        } else {
          yield EmailNotSent(message: 'Error tidak diketahui');
        }
      }, (success) async* {
        yield EmaiSent(message: 'Password reset terkirim ke ${event.email}');
      });
    }
  }
}
