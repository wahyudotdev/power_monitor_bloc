import 'dart:convert';

import 'package:http/http.dart';
import 'package:power_monitor_app/core/error/exception.dart';
import 'package:power_monitor_app/features/history/data/models/history_model.dart';
import 'package:power_monitor_app/features/history/domain/entities/history.dart';

abstract class HistoryRemoteDatasource {
  Future<List<History>> getHistoryData({required int numOfData});
}

class HistoryRemoteDatasourceImpl implements HistoryRemoteDatasource {
  static const ANTARES_BASE_URL = 'https://platform.antares.id:8443/~';
  static const ANTARES_KEY = 'ac91ffdeb8892ccc:06b039ce7af2ae9a';
  final Client client;

  HistoryRemoteDatasourceImpl(this.client);

  @override
  Future<List<History>> getHistoryData({required int numOfData}) async {
    String antaresUrl =
        'https://platform.antares.id:8443/~/antares-cse/antares-id/Monitoringwaduk/monitoringwaduk?fu=1&ty=4&drt=1&lim=$numOfData';
    Response response = await client.get(
      Uri.parse(antaresUrl),
      headers: {
        'X-M2M-Origin': ANTARES_KEY,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<String> urlList = json.decode(response.body)['m2m:uril'];
      List<History> histories = [];
      for (var i = 0; i < urlList.length; i++) {
        final history = await client.get(
          Uri.parse(urlList[i]),
          headers: {
            'X-M2M-Origin': ANTARES_KEY,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );
        if (history.statusCode == 200) {
          histories.add(HistoryModel.fromJsonString(history.body));
        }
      }
      return histories;
    } else
      throw ServerException();
  }
}
