import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';
import 'package:power_monitor_app/features/home/domain/entities/latest_data.dart';
import 'package:power_monitor_app/features/home/domain/usecases/get_latest_data.dart';

part 'latest_event.dart';
part 'latest_state.dart';

class LatestBloc extends Bloc<LatestEvent, LatestState> {
  LatestBloc({required this.getLatestData}) : super(LatestInitial());
  final GetLatestData getLatestData;
  @override
  Stream<LatestState> mapEventToState(
    LatestEvent event,
  ) async* {
    if (event is GetLatestDataEvent) {
      yield LoadingLatestData();
      final result = await getLatestData(NoParams());
      yield* result.fold((failure) async* {
        yield LoadFailLatestData(message: ServerFailure.MESSAGE);
      }, (data) async* {
        yield LoadedLatestData(data: data);
      });
    }
  }
}
