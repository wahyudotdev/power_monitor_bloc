import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_monitor_app/core/auth/domain/entities/user_auth_info.dart';
import 'package:power_monitor_app/core/auth/domain/usecases/usecases.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.changeName,
      required this.changePassword,
      required this.getUser,
      required this.signIn,
      required this.signOut})
      : super(AuthInitial());

  final ChangeName changeName;
  final ChangePassword changePassword;
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
        yield UserAuthenticated(userAuthInfo: userInfo);
      });
    }

    if (event is GetUserEvent) {
      print('get user event');
      yield AuthLoading();
      final result = await getUser(NoParams());
      yield* result.fold((failure) async* {
        yield AuthenticationFail(message: 'Gagal mengautentikasi user');
      }, (userInfo) async* {
        yield UserAuthenticated(userAuthInfo: userInfo);
      });
    }

    if (event is SignOutEvent) {
      print('kudune signout');
      yield AuthLoading();
      final result = await signOut(NoParams());
      yield* result.fold((failure) async* {
        // if (failure is ServerFailure) {
        //   yield AuthenticationFail(message: ServerFailure.MESSAGE);
        // }
      }, (userInfo) async* {
        yield LogoutSuccess();
      });
    }
  }
}
