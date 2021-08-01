part of 'realtime_bloc.dart';

abstract class RealtimeState extends Equatable {
  const RealtimeState();

  @override
  List<Object> get props => [];
}

class RealtimeInitial extends RealtimeState {}

class RealtimeDataLoaded extends RealtimeState {
  final DeviceRealtimeStatus data;

  RealtimeDataLoaded({required this.data});
  @override
  List<Object> get props => [data];
}
