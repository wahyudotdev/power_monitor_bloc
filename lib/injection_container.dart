import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'core/auth/auth_di.dart';
import 'core/network/network_info.dart';
import 'features/history/history_di.dart';
import 'features/home/home_di.dart';

import 'features/register/register_di.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);

  // Utils
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  authDi();
  registerDi();
  homeDi();
  historyDi();
}
