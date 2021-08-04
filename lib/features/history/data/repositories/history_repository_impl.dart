import 'package:firebase_database/firebase_database.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final FirebaseDatabase db;

  HistoryRepositoryImpl(this.db);
  @override
  Stream listenHistory() {
    return db.reference().child('/logs').orderByChild('time').onValue;
  }
}
