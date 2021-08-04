import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class DeviceRealtimeRepository {
  Stream realtimeData();
  Future<Either<Failure, void>> toggleLoadState(String load);
  Future<Either<Failure, void>> setMaxValue(
      {required String path, required double value});
  Future<Either<Failure, void>> turnOffAll();
}
