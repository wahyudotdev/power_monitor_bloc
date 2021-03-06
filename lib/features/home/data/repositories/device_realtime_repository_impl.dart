import 'package:firebase_database/firebase_database.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/device_realtime_repository.dart';

class DeviceRealtimeRepositoryImpl implements DeviceRealtimeRepository {
  final FirebaseDatabase db;

  DeviceRealtimeRepositoryImpl({required this.db});
  @override
  Stream realtimeData() {
    return db.reference().child('/realtime').onValue;
  }

  @override
  Future<Either<Failure, void>> toggleLoadState(String load) async {
    try {
      final state = await db.reference().child('/realtime').child(load).get();
      await db.reference().child('/realtime').child(load).set(!state!.value);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setMaxValue(
      {required String path, required double value}) async {
    try {
      await db.reference().child('/realtime').child(path).set(value);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> turnOffAll() async {
    try {
      await db.reference().child('/realtime').child('load1').set(false);
      await db.reference().child('/realtime').child('load2').set(false);
      await db.reference().child('/realtime').child('load3').set(false);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
