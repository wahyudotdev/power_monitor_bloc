import 'package:equatable/equatable.dart';

class UserForm extends Equatable {
  final String email;
  final String password;
  final String displayName;

  UserForm(
      {required this.email, required this.password, required this.displayName});

  @override
  List<Object?> get props => [email, password, displayName];
}
