import 'presentation/bloc/form_validation/form_validation_bloc.dart';
import '../../injection_container.dart';

import 'presentation/bloc/register/register_bloc.dart';

void registerDi() {
  sl.registerFactory(() => RegisterBloc());
  sl.registerFactory(() => FormValidationBloc());
}
