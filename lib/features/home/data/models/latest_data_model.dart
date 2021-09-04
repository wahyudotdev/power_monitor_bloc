import 'dart:convert';
import 'package:power_monitor_app/features/home/domain/entities/latest_data.dart';

class LatestDataModel extends LatestData {
  final double tinggiAir;
  final double tekananAir;
  final DateTime waktu;
  LatestDataModel(
      {required this.tinggiAir, required this.tekananAir, required this.waktu})
      : super(
          tinggiAir: tinggiAir,
          tekananAir: tekananAir,
          waktu: waktu,
        );

  factory LatestDataModel.fromJsonString(String jsonString) {
    final result = json.decode(jsonString);
    String con = result['m2m:cin']['con'];
    String ct = result['m2m:cin']['ct'];
    int year = int.parse(ct[0] + ct[1] + ct[2] + ct[3]);
    int month = int.parse(ct[4] + ct[5]);
    int day = int.parse(ct[6] + ct[7]);
    int hour = int.parse(ct[9] + ct[10]);
    int minute = int.parse(ct[11] + ct[12]);
    int second = int.parse(ct[13] + ct[14]);
    DateTime waktu = DateTime(year, month, day, hour, minute, second);
    String dataString = json.decode(con)['data'];
    double tinggiAir = double.parse(dataString.split(',')[0]);
    double tekananAir = double.parse(dataString.split(',')[1]);
    return LatestDataModel(
      tinggiAir: tinggiAir,
      tekananAir: tekananAir,
      waktu: waktu,
    );
  }
}
