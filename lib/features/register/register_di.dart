import 'data/datasources/user_register_remote_datasources.dart';
import 'data/repositories/user_register_repository_impl.dart';
import 'domain/repositories/user_register_repository.dart';
import 'domain/usecases/register_user.dart';

import 'presentation/bloc/form_validation/form_validation_bloc.dart';
import '../../injection_container.dart';

import 'presentation/bloc/register/register_bloc.dart';

void registerDi() {
  // BloC
  sl.registerFactory(() => RegisterBloc(registerUser: sl()));
  sl.registerFactory(() => FormValidationBloc());

  // Usecase
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRegisterRepository>(() =>
      UserRegisterRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // Datasource
  sl.registerLazySingleton<UserRegisterRemoteDataSource>(
      () => UserRegisterRemoteDataSourceImpl(sl()));
}
