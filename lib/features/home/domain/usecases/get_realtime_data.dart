import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/core/usecases/no_params.dart';
import 'package:power_monitor_app/core/usecases/usecase.dart';
import 'package:power_monitor_app/features/home/domain/entities/realtime_data.dart';
import 'package:power_monitor_app/features/home/domain/repositories/antares_repository.dart';

class GetRealtimeData implements UseCase<RealtimeData, NoParams> {
  final AntaresRepository _repository;

  GetRealtimeData(this._repository);
  @override
  Future<Either<Failure, RealtimeData>> call(NoParams params) async {
    return await _repository.getRealtimeData();
  }
}
