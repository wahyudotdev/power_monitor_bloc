part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class _HistoryHasData extends HistoryEvent {
  final List<History> history;

  _HistoryHasData({required this.history});
  @override
  List<Object> get props => [history];
}

class LoadHistoryEvent extends HistoryEvent {}
