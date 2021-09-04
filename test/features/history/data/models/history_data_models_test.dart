import 'package:flutter_test/flutter_test.dart';
import 'package:power_monitor_app/features/history/data/models/history_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final waktu = DateTime(2021, 9, 1, 22, 22, 14);
  final tTinggiAir = 30.59;
  final tTekananAir = 5.36;
  final tHistoryData = HistoryModel(
      tinggiAir: tTinggiAir, tekananAir: tTekananAir, waktu: waktu);
  test('should return tHistoryData when provided with json string', () {
    final jsonString = fixture('realtime_data.json');
    final result = HistoryModel.fromJsonString(jsonString);
    expect(result, equals(tHistoryData));
  });
}
