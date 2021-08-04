import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/history_model.dart';
import '../../domain/entities/history.dart';
import '../../domain/repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.repository}) : super(HistoryInitial());
  final HistoryRepository repository;

  StreamSubscription? _subscription;
  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is LoadHistoryEvent) {
      await _subscription?.cancel();
      _subscription = repository.listenHistory().listen((event) {
        final history = HistoryModel.fromSnapshotList(event.snapshot.value);
        add(_HistoryHasData(history: history));
      });
    }
    if (event is _HistoryHasData) {
      yield LoadedHistory(history: event.history);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
