import 'dart:convert';

import '../../domain/entities/history.dart';

class HistoryModel extends History {
  final double tinggiAir;
  final double tekananAir;
  final DateTime waktu;
  HistoryModel({
    required this.tinggiAir,
    required this.tekananAir,
    required this.waktu,
  }) : super(tinggiAir: tinggiAir, tekananAir: tekananAir, waktu: waktu);

  factory HistoryModel.fromSnapshot(Map<dynamic, dynamic> map) {
    final tinggiAir = (map['volt'] as num).toDouble();
    final tekananAir = (map['current'] as num).toDouble();
    final waktu =
        DateTime.fromMillisecondsSinceEpoch((int.parse(map['time']) * 1000))
            .toLocal();
    return HistoryModel(
        tinggiAir: tinggiAir, tekananAir: tekananAir, waktu: waktu);
  }

  History toEntity() {
    return History(tinggiAir: tinggiAir, tekananAir: tekananAir, waktu: waktu);
  }

  static List<History> fromSnapshotList(Map<dynamic, dynamic> list) {
    List<History> history = [];
    list.forEach((key, value) =>
        history.add(HistoryModel.fromSnapshot(value).toEntity()));
    return history.reversed.toList();
  }

  factory HistoryModel.fromJsonString(String jsonString) {
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
    return HistoryModel(
        tinggiAir: tinggiAir, tekananAir: tekananAir, waktu: waktu);
  }
}
