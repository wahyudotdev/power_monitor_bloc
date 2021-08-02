part of 'realtime_bloc.dart';

abstract class RealtimeEvent extends Equatable {
  const RealtimeEvent();

  @override
  List<Object> get props => [];
}

class ListenRealtimeData extends RealtimeEvent {
  @override
  List<Object> get props => [];
}

class RefreshRealtimeDataEvent extends RealtimeEvent {
  @override
  List<Object> get props => [];
}

class ToggleLoadEvent extends RealtimeEvent {
  final String load;

  ToggleLoadEvent({required this.load});
}

class _RepositoryHasDataEvent extends RealtimeEvent {
  final DeviceRealtimeStatus status;

  _RepositoryHasDataEvent({required this.status});
  List<Object> get props => [status];
}

class SetMaxValueEvent extends RealtimeEvent {
  final String path;
  final double value;

  SetMaxValueEvent({required this.path, required this.value});
}
