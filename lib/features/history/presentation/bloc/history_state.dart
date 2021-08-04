part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class LoadedHistory extends HistoryState {
  final List<History> history;

  LoadedHistory({required this.history});
  @override
  List<Object> get props => [history];
}
