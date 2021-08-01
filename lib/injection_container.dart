import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:power_monitor_app/core/network/network_info.dart';

import 'features/register/register_di.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());

  // Utils
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  registerDi();
}
