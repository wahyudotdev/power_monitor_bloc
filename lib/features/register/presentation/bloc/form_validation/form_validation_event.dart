part of 'form_validation_bloc.dart';

abstract class FormValidationEvent extends Equatable {
  const FormValidationEvent();

  @override
  List<Object> get props => [];
}

class ValidateName extends FormValidationEvent {
  final String name;

  ValidateName({required this.name});
}

class ValidatePassword extends FormValidationEvent {
  final String password;

  ValidatePassword({required this.password});
}

class ValidateConfirmPassword extends FormValidationEvent {
  final String password;

  final String confirmPassword;

  ValidateConfirmPassword(
      {required this.password, required this.confirmPassword});
}

class ValidateEmail extends FormValidationEvent {
  final String email;

  ValidateEmail({required this.email});
}

class ValidateForm extends FormValidationEvent {}
