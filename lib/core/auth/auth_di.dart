import 'data/repositories/user_auth_repository_impl.dart';
import 'domain/repositories/user_auth_repository.dart';
import 'domain/usecases/request_password.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/bloc/auth_bloc.dart';
import '../../injection_container.dart';

void authDi() {
  // BloC
  sl.registerFactory(() => AuthBloc(
      changeName: sl(),
      changePassword: sl(),
      requestPassword: sl(),
      getUser: sl(),
      signIn: sl(),
      signOut: sl()));

  // Usecase
  sl.registerLazySingleton(() => ChangeName(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => RequestPassword(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  // Repository
  sl.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(networkInfo: sl(), auth: sl()));
}
