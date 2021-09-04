import 'package:power_monitor_app/core/error/exception.dart';
import 'package:power_monitor_app/features/home/data/datasources/latest_data_remote_datasource.dart';
import 'package:power_monitor_app/features/home/domain/entities/latest_data.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/features/home/domain/repositories/latest_data_repository.dart';

class LatestDataRepositoryImpl implements LatestDataRepository {
  final LatestDataRemoteDatasource remoteDatasource;

  LatestDataRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, LatestData>> getLatestData() async {
    try {
      final result = await remoteDatasource.getRealtimeData();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
