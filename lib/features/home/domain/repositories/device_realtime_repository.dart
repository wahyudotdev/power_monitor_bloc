import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/error/failure.dart';

abstract class DeviceRealtimeRepository {
  Stream realtimeData();
  Future<Either<Failure, void>> toggleLoadState(String load);
  Future<Either<Failure, void>> setMaxValue(
      {required String path, required double value});
}
