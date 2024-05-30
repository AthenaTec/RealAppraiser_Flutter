import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final int status;
  final String data;
  final String msg;

  const LoginEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}
