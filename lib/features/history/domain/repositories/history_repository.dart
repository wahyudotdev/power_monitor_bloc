import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:power_monitor_app/features/history/domain/entities/history.dart';

abstract class HistoryRepository {
  Stream listenHistory();
  Future<Either<Failure, List<History>>> getHistoryData(int? numOfData);
}
