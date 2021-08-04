import 'data/repositories/device_realtime_repository_impl.dart';
import 'domain/repositories/device_realtime_repository.dart';
import 'presentation/bloc/realtime_bloc.dart';
import '../../injection_container.dart';

void homeDi() {
  // BloC
  sl.registerFactory(() => RealtimeBloc(sl()));

  // Repository
  sl.registerLazySingleton<DeviceRealtimeRepository>(
      () => DeviceRealtimeRepositoryImpl(db: sl()));
}
