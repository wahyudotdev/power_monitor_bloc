import 'package:equatable/equatable.dart';

class LatestData extends Equatable {
  final double tinggiAir;
  final double tekananAir;
  final DateTime waktu;
  LatestData(
      {required this.tinggiAir, required this.tekananAir, required this.waktu});

  @override
  List<Object?> get props => [tinggiAir, tekananAir, waktu];
}
