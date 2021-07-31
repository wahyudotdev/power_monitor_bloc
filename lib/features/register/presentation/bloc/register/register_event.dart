part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String displayName;

  RegisterUserEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.displayName,
  });
}
