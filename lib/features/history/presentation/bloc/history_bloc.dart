import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_monitor_app/features/history/domain/usecases/get_history_data.dart';
import '../../domain/entities/history.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryData getHistoryData;

  HistoryBloc({required this.getHistoryData}) : super(HistoryInitial());
  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is LoadHistoryEvent) {
      yield LoadingHistory();
      final result = await getHistoryData(Params(numOfData: event.numOfData));
      yield* result.fold((failure) async* {
        yield LoadErrorHistory();
      }, (data) async* {
        yield LoadedHistory(history: data);
      });
    }
  }
}
