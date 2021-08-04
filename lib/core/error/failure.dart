import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  static const MESSAGE = 'Koneksi ke server gagal';
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  static const MESSAGE = 'Terjadi error cache data';
  @override
  List<Object?> get props => [];
}

class UserRegisterFailure extends Failure {
  static const MESSAGE = 'Gagal mendaftarkan pengguna baru';
  @override
  List<Object?> get props => [];
}

class UserLoginFailure extends Failure {
  static const MESSAGE = 'Login gagal';
  @override
  List<Object?> get props => [];
}

class UserUpdateFailure extends Failure {
  static const MESSAGE = 'Gagal mengubah data pengguna';
  @override
  List<Object?> get props => [];
}

class UserNotFoundFailure extends Failure {
  static const MESSAGE = 'Pengguna tidak ditemukan';
  @override
  List<Object?> get props => [];
}
