import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';
import 'package:power_monitor_app/features/history/domain/entities/history.dart';
import 'package:power_monitor_app/features/history/domain/repositories/history_repository.dart';

class GetHistoryData implements UseCase<List<History>, Params> {
  final HistoryRepository repository;
  GetHistoryData(this.repository);

  @override
  Future<Either<Failure, List<History>>> call(Params params) async {
    return await repository.getHistoryData(params.numOfData);
  }
}

class Params {
  final int? numOfData;

  Params({this.numOfData});
}
