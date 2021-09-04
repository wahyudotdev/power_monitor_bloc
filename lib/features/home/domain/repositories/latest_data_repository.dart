import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/features/home/domain/entities/latest_data.dart';

abstract class LatestDataRepository {
  Future<Either<Failure, LatestData>> getLatestData();
}
