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

class _RepositoryHasDataEvent extends RealtimeEvent {
  final DeviceRealtimeStatus status;

  _RepositoryHasDataEvent({required this.status});
  List<Object> get props => [status];
}
