import 'package:power_monitor_app/features/home/data/repositories/latest_data_repository_impl.dart';
import 'package:power_monitor_app/features/home/domain/repositories/latest_data_repository.dart';
import 'package:power_monitor_app/features/home/domain/usecases/get_latest_data.dart';
import 'package:power_monitor_app/features/home/presentation/bloc/latest_bloc.dart';

import 'data/datasources/latest_data_remote_datasource.dart';
import 'data/repositories/device_realtime_repository_impl.dart';
import 'domain/repositories/device_realtime_repository.dart';
import '../../injection_container.dart';

void homeDi() {
  // BloC
  sl.registerFactory(() => LatestBloc(getLatestData: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetLatestData(sl()));

  // Repository
  sl.registerLazySingleton<DeviceRealtimeRepository>(
      () => DeviceRealtimeRepositoryImpl(db: sl()));
  sl.registerLazySingleton<LatestDataRepository>(
      () => LatestDataRepositoryImpl(sl()));

  // Datasource
  sl.registerLazySingleton<LatestDataRemoteDatasource>(
      () => LatestDataRemoteDataSourceImpl(sl()));
}
