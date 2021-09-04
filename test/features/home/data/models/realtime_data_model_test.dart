import 'package:flutter_test/flutter_test.dart';
import 'package:power_monitor_app/features/home/data/models/latest_data_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final waktu = DateTime(2021, 9, 1, 22, 22, 14);
  final tRealtimeData =
      LatestDataModel(tinggiAir: 30.59, tekananAir: 5.36, waktu: waktu);
  test('test json parser', () {
    final jsonString = fixture('realtime_data.json');
    final result = LatestDataModel.fromJsonString(jsonString);
    expect(result, equals(tRealtimeData));
  });
}
