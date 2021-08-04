import 'package:power_monitor_app/features/history/data/repositories/history_repository_impl.dart';
import 'package:power_monitor_app/features/history/domain/repositories/history_repository.dart';
import 'package:power_monitor_app/features/history/presentation/bloc/history_bloc.dart';
import 'package:power_monitor_app/injection_container.dart';

void historyDi() {
  // BloC
  sl.registerFactory(() => HistoryBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(sl()));
}
