import 'package:power_monitor_app/features/history/domain/entities/history.dart';

class HistoryModel extends History {
  final double volt;
  final double current;
  final double power;
  final DateTime time;
  HistoryModel({
    required this.volt,
    required this.current,
    required this.power,
    required this.time,
  }) : super(volt: volt, current: current, power: power, time: time);

  factory HistoryModel.fromSnapshot(Map<dynamic, dynamic> map) {
    final v = (map['volt'] as num).toDouble();
    final i = (map['current'] as num).toDouble();
    final p = (map['power'] as num).toDouble();
    final t =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['time']) * 1000));
    return HistoryModel(volt: v, current: i, power: p, time: t);
  }

  History toEntity() {
    return History(volt: volt, current: current, power: power, time: time);
  }

  static List<History> fromSnapshotList(Map<dynamic, dynamic> list) {
    List<History> history = [];
    list.forEach((key, value) =>
        history.add(HistoryModel.fromSnapshot(value).toEntity()));
    return history.reversed.toList();
  }
}
