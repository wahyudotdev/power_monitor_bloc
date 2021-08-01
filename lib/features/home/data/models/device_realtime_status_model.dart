import 'package:power_monitor_app/features/home/domain/entities/device_status.dart';

class DeviceRealtimStatusModel extends DeviceRealtimeStatus {
  final double volt;
  final double current;
  final double power;
  final bool load1;
  final bool load2;
  final bool load3;
  final double? voltTh;
  final double? currentTh;
  final double? powerTh;
  DeviceRealtimStatusModel({
    required this.volt,
    required this.current,
    required this.power,
    required this.load1,
    required this.load2,
    required this.load3,
    this.voltTh,
    this.currentTh,
    this.powerTh,
  }) : super(
          volt: volt,
          current: current,
          power: power,
          load1: load1,
          load2: load2,
          load3: load3,
          voltTh: voltTh,
          currentTh: currentTh,
          powerTh: powerTh,
        );
  factory DeviceRealtimStatusModel.fromSnapshot(Map<dynamic, dynamic> map) =>
      DeviceRealtimStatusModel(
        volt: (map['volt'] as num).toDouble(),
        current: (map['current'] as num).toDouble(),
        power: (map['power'] as num).toDouble(),
        load1: map['load1'],
        load2: map['load2'],
        load3: map['load3'],
        voltTh: ((map['voltTh'] ?? map['volt']) as num).toDouble(),
        currentTh: ((map['currentTh'] ?? map['current']) as num).toDouble(),
        powerTh: ((map['powerTh'] ?? map['power']) as num).toDouble(),
      );

  DeviceRealtimeStatus toEntity() => DeviceRealtimeStatus(
        volt: volt,
        current: current,
        power: power,
        load1: load1,
        load2: load2,
        load3: load3,
        voltTh: voltTh,
        currentTh: currentTh,
        powerTh: powerTh,
      );
}
