import 'package:equatable/equatable.dart';

class History extends Equatable {
  final double tinggiAir;
  final double tekananAir;
  final DateTime waktu;

  History({
    required this.tinggiAir,
    required this.tekananAir,
    required this.waktu,
  });
  @override
  List<Object?> get props => [tinggiAir, tekananAir, waktu];
}
