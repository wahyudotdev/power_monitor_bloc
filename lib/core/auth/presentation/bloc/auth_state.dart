part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends AuthState {
  final UserAuthInfo userAuthInfo;

  UserAuthenticated({required this.userAuthInfo});
  @override
  List<Object> get props => [userAuthInfo];
}

class AuthenticationFail extends AuthState {
  final String message;

  AuthenticationFail({required this.message});
}

class LogoutSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class UpdatedProfile extends AuthState {
  final UserAuthInfo authInfo;
  final String message;
  UpdatedProfile({
    required this.authInfo,
    required this.message,
  });
  @override
  List<Object> get props => [authInfo];
}

class UpdateFailure extends AuthState {
  final String message;

  UpdateFailure({required this.message});
}
