import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';
import 'package:power_monitor_app/features/home/domain/entities/latest_data.dart';
import 'package:power_monitor_app/features/home/domain/repositories/latest_data_repository.dart';

class GetLatestData implements UseCase<LatestData, NoParams> {
  final LatestDataRepository repository;

  GetLatestData(this.repository);
  @override
  Future<Either<Failure, LatestData>> call(NoParams params) async {
    return await repository.getLatestData();
  }
}
