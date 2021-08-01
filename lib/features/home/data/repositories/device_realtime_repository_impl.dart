import 'package:firebase_database/firebase_database.dart';
import 'package:power_monitor_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:power_monitor_app/features/home/domain/repositories/device_realtime_repository.dart';

class DeviceRealtimeRepositoryImpl implements DeviceRealtimeRepository {
  final FirebaseDatabase db;

  DeviceRealtimeRepositoryImpl({required this.db});
  @override
  Stream realtimeData() {
    return db.reference().child('/realtime').onValue;
  }

  @override
  Future<Either<Failure, void>> toggleLoadState(String load) {
    // TODO: implement toggleLoadState
    throw UnimplementedError();
  }
}
