part of 'form_validation_bloc.dart';

abstract class FormValidationState extends Equatable {
  const FormValidationState();

  @override
  List<Object> get props => [];
}

class SubmitState extends FormValidationState {
  final bool isReady;

  SubmitState({required this.isReady});
  @override
  List<Object> get props => [isReady];
}

class EmailValidationState extends FormValidationState {
  final bool isValid;
  final String? message;

  EmailValidationState({required this.isValid, this.message});
  @override
  List<Object> get props => [isValid];
}

class PasswordValidationState extends FormValidationState {
  final bool isValid;
  final String? message;

  PasswordValidationState({required this.isValid, this.message});
  @override
  List<Object> get props => [isValid];
}

class NameValidationState extends FormValidationState {
  final bool isValid;
  final String? message;

  NameValidationState({required this.isValid, this.message});
  @override
  List<Object> get props => [isValid];
}
