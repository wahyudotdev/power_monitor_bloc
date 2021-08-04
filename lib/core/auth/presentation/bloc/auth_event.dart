part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class GetUserEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class ChangeNameEvent extends AuthEvent {
  final String name;

  ChangeNameEvent({required this.name});
}

class ChangePasswordEvent extends AuthEvent {
  final String password;

  ChangePasswordEvent({required this.password});
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}
