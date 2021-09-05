part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {
  final int? numOfData;

  LoadHistoryEvent({this.numOfData});
}
