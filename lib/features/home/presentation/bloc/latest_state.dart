part of 'latest_bloc.dart';

abstract class LatestState extends Equatable {
  const LatestState();

  @override
  List<Object> get props => [];
}

class LatestInitial extends LatestState {}

class LoadingLatestData extends LatestState {}

class LoadedLatestData extends LatestState {
  final LatestData data;

  LoadedLatestData({required this.data});
}

class LoadFailLatestData extends LatestState {
  final String message;

  LoadFailLatestData({required this.message});
}
