import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';
import 'package:power_monitor_app/features/home/domain/entities/realtime_data.dart';
import 'package:power_monitor_app/features/home/domain/repositories/antares_repository.dart';

class GetHistoryData implements UseCase<List<RealtimeData>, HistoryDataParam> {
  final AntaresRepository repository;

  GetHistoryData(this.repository);
  @override
  Future<Either<Failure, List<RealtimeData>>> call(
      HistoryDataParam params) async {
    return await repository.getHistoryData();
  }
}

class HistoryDataParam {
  final int? numOfResult;

  HistoryDataParam({this.numOfResult});
}
