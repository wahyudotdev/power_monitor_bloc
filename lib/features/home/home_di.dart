import 'package:power_monitor_app/features/home/data/repositories/device_realtime_repository_impl.dart';
import 'package:power_monitor_app/features/home/domain/repositories/device_realtime_repository.dart';
import 'package:power_monitor_app/features/home/presentation/bloc/realtime_bloc.dart';
import 'package:power_monitor_app/injection_container.dart';

void homeDi() {
  // BloC
  sl.registerFactory(() => RealtimeBloc(sl()));

  // Repository
  sl.registerLazySingleton<DeviceRealtimeRepository>(
      () => DeviceRealtimeRepositoryImpl(db: sl()));
}
