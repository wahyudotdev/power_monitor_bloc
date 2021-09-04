part of 'latest_bloc.dart';

abstract class LatestEvent extends Equatable {
  const LatestEvent();

  @override
  List<Object> get props => [];
}

class GetLatestDataEvent extends LatestEvent {}
