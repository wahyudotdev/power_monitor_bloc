import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:power_monitor_app/core/error/exception.dart';
import 'package:power_monitor_app/features/history/data/datasources/history_remote_datasources.dart';
import 'package:power_monitor_app/features/history/domain/entities/history.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final FirebaseDatabase rtdb;
  final HistoryRemoteDatasource remoteDatasource;
  HistoryRepositoryImpl({required this.rtdb, required this.remoteDatasource});
  @override
  Stream listenHistory() {
    return rtdb.reference().child('/logs').orderByChild('time').onValue;
  }

  @override
  Future<Either<Failure, List<History>>> getHistoryData(int? numOfData) async {
    try {
      if (numOfData != null) {
        final result =
            await remoteDatasource.getHistoryData(numOfData: numOfData);
        return Right(result);
      } else {
        final result = await remoteDatasource.getHistoryData(numOfData: 20);
        return Right(result);
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
