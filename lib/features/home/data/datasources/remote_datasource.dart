import 'dart:io';

import 'package:power_monitor_app/core/error/exception.dart';
import 'package:power_monitor_app/features/home/data/models/realtime_data_model.dart';
import 'package:power_monitor_app/features/home/domain/entities/realtime_data.dart';
import 'package:http/http.dart';

abstract class RemoteDatasource {
  Future<RealtimeData> getRealtimeData();
}

class RemoteDatasourceImpl implements RemoteDatasource {
  static const ANTARES_BASE_URL =
      'https://platform.antares.id:8443/~/antares-cse/antares-id/Monitoringwaduk/monitoringwaduk';
  static const ANTARES_KEY = 'ac91ffdeb8892ccc:06b039ce7af2ae9a';
  final Client client;

  RemoteDatasourceImpl(this.client);
  @override
  Future<RealtimeData> getRealtimeData() async {
    Response response = await client.get(
      Uri.parse(ANTARES_BASE_URL),
      headers: {
        'X-M2M-Origin': ANTARES_KEY,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return RealtimeDataModel.fromJsonString(response.body);
    } else
      throw ServerException();
  }
}
