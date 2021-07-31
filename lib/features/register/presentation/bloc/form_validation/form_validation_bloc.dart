import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  FormValidationBloc() : super(SubmitState(isReady: false));
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;
  @override
  Stream<FormValidationState> mapEventToState(
    FormValidationEvent event,
  ) async* {
    if (event is ValidateName) {
      isNameValid = event.name.length >= 3;
      yield (NameValidationState(
        isValid: isNameValid,
        message: isNameValid ? null : 'Nama minimal 3 karakter',
      ));
    }

    if (event is ValidateEmail) {
      isEmailValid = _validateEmail(event.email);
      yield EmailValidationState(
        isValid: isEmailValid,
        message: isEmailValid ? null : 'Format email tidak valid',
      );
    }

    if (event is ValidatePassword) {
      isPasswordValid = (event.password.length >= 8);
      yield PasswordValidationState(
        isValid: isPasswordValid,
        message: isPasswordValid ? null : 'Password minimal 8 karakter',
      );
    }

    if (event is ValidateConfirmPassword) {
      isConfirmPasswordValid = (event.password == event.confirmPassword);
      yield PasswordValidationState(
        isValid: isConfirmPasswordValid,
        message: isConfirmPasswordValid ? null : 'Password harus sama',
      );
    }

    if (event is ValidateForm) {
      yield SubmitState(
        isReady: (isNameValid &&
            isEmailValid &&
            isPasswordValid &&
            isConfirmPasswordValid),
      );
    }
  }

  bool _validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
