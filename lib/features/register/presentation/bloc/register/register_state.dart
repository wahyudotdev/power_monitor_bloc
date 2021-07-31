part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {
  final String message;

  RegisterFail({required this.message});
}

class EmailInvalid extends RegisterState {
  final String message;

  EmailInvalid({required this.message});
}

class PasswordInvalid extends RegisterState {
  final String message;

  PasswordInvalid({required this.message});
}
