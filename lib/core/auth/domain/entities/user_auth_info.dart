import 'package:equatable/equatable.dart';

class UserAuthInfo extends Equatable {
  final String email;
  final String displayName;
  final String frontName;
  UserAuthInfo({
    required this.email,
    required this.displayName,
    required this.frontName,
  });
  @override
  List<Object?> get props => [email, displayName, frontName];
}
