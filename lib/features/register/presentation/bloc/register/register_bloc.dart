import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/features/register/domain/entities/user_form.dart';
import 'package:power_monitor_app/features/register/domain/usecases/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUserEvent) {
      yield RegisterLoading();
      final userForm = UserForm(
          email: event.email,
          password: event.password,
          displayName: event.displayName);
      final result = await registerUser(Params(userForm: userForm));
      yield* result.fold((failure) async* {
        if (failure is UserRegisterFailure) {
          yield RegisterFail(message: UserRegisterFailure.MESSAGE);
        }
        if (failure is ServerFailure) {
          yield RegisterFail(message: ServerFailure.MESSAGE);
        }
      }, (data) async* {
        yield RegisterSuccess(message: 'Sekarang anda dapat login');
      });
    }
  }
}
