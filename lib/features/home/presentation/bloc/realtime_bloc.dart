import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_monitor_app/features/home/data/models/device_realtime_status_model.dart';
import 'package:power_monitor_app/features/home/domain/entities/device_status.dart';
import 'package:power_monitor_app/features/home/domain/repositories/device_realtime_repository.dart';

part 'realtime_event.dart';
part 'realtime_state.dart';

class RealtimeBloc extends Bloc<RealtimeEvent, RealtimeState> {
  RealtimeBloc(this.repository) : super(RealtimeInitial());
  final DeviceRealtimeRepository repository;
  DeviceRealtimeStatus? _status;
  StreamSubscription? _realtimeSubscribtion;
  @override
  Stream<RealtimeState> mapEventToState(
    RealtimeEvent event,
  ) async* {
    if (event is ListenRealtimeData) {
      await _realtimeSubscribtion?.cancel();
      _realtimeSubscribtion = repository.realtimeData().listen((event) {
        final data = event.snapshot.value;
        DeviceRealtimeStatus status =
            DeviceRealtimStatusModel.fromSnapshot(data).toEntity();
        _status = status;
        add(_RepositoryHasDataEvent(status: status));
      });
    }
    if (event is _RepositoryHasDataEvent) {
      yield RealtimeDataLoaded(data: event.status);
    }

    if (event is RefreshRealtimeDataEvent) {
      yield RealtimeDataLoaded(data: _status!);
    }

    if (event is ToggleLoadEvent) {
      await repository.toggleLoadState(event.load);
    }

    if (event is SetMaxValueEvent) {
      await repository.setMaxValue(path: event.path, value: event.value);
    }
  }

  @override
  Future<void> close() {
    _realtimeSubscribtion?.cancel();
    return super.close();
  }
}
