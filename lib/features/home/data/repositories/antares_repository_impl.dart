import 'package:power_monitor_app/core/error/exception.dart';
import 'package:power_monitor_app/features/home/data/datasources/remote_datasource.dart';
import 'package:power_monitor_app/features/home/domain/entities/realtime_data.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/features/home/domain/repositories/antares_repository.dart';

class AntaresRepositoryImpl implements AntaresRepository {
  final RemoteDatasource remoteDatasource;

  AntaresRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, RealtimeData>> getRealtimeData() async {
    try {
      final result = await remoteDatasource.getRealtimeData();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
