import 'package:equatable/equatable.dart';

class RealtimeData extends Equatable {
  final double tinggiAir;
  final double tekananAir;
  final DateTime waktu;
  RealtimeData(
      {required this.tinggiAir, required this.tekananAir, required this.waktu});

  @override
  List<Object?> get props => [tinggiAir, tekananAir];
}
