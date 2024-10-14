import 'package:equatable/equatable.dart';

class CreateCaseEntity extends Equatable {
  final int status;
  final String data;
  final String msg;

  const CreateCaseEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}
