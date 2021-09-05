import 'package:power_monitor_app/features/history/data/datasources/history_remote_datasources.dart';
import 'package:power_monitor_app/features/history/domain/usecases/get_history_data.dart';

import 'data/repositories/history_repository_impl.dart';
import 'domain/repositories/history_repository.dart';
import 'presentation/bloc/history_bloc.dart';
import '../../injection_container.dart';

void historyDi() {
  // BloC
  // sl.registerFactory(() => HistoryBloc(getHistoryData: sl()));
  sl.registerFactory(() => HistoryBloc(getHistoryData: sl()));

  // Usecases
  sl.registerLazySingleton<GetHistoryData>(() => GetHistoryData(sl()));

  // Repository
  sl.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(rtdb: sl(), remoteDatasource: sl()));

  // Datasource
  sl.registerLazySingleton<HistoryRemoteDatasource>(
      () => HistoryRemoteDatasourceImpl(sl()));
}
