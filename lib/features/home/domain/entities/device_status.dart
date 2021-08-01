import 'package:equatable/equatable.dart';

class DeviceRealtimeStatus extends Equatable {
  final double volt;
  final double current;
  final double power;
  final double? voltTh;
  final double? currentTh;
  final double? powerTh;
  final bool load1;
  final bool load2;
  final bool load3;
  DeviceRealtimeStatus({
    required this.volt,
    required this.current,
    required this.power,
    required this.load1,
    required this.load2,
    required this.load3,
    this.voltTh,
    this.currentTh,
    this.powerTh,
  });
  @override
  List<Object?> get props => [
        volt,
        current,
        power,
        load1,
        load2,
        load3,
        voltTh,
        currentTh,
        powerTh,
      ];
}
