import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/features/home/domain/entities/realtime_data.dart';

abstract class AntaresRepository {
  Future<Either<Failure, RealtimeData>> getRealtimeData();
}
