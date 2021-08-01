import 'package:power_monitor_app/core/auth/data/repositories/user_auth_repository_impl.dart';
import 'package:power_monitor_app/core/auth/domain/repositories/user_auth_repository.dart';
import 'package:power_monitor_app/core/auth/domain/usecases/usecases.dart';
import 'package:power_monitor_app/core/auth/presentation/bloc/auth_bloc.dart';
import 'package:power_monitor_app/injection_container.dart';

void authDi() {
  // BloC
  sl.registerFactory(() => AuthBloc(
      changeName: sl(),
      changePassword: sl(),
      getUser: sl(),
      signIn: sl(),
      signOut: sl()));

  // Usecase
  sl.registerLazySingleton(() => ChangeName(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  // Repository
  sl.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(networkInfo: sl(), auth: sl()));
}
