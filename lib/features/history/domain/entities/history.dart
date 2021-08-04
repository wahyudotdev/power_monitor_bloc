import 'package:equatable/equatable.dart';

class History extends Equatable {
  final double volt;
  final double current;
  final double power;
  final DateTime time;

  History({
    required this.volt,
    required this.current,
    required this.power,
    required this.time,
  });
  @override
  List<Object?> get props => [volt, current, power, time];
}
