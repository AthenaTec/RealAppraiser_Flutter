import 'package:equatable/equatable.dart';

class BankNameEntity extends Equatable {
  final int status;
  final List<DatumEntity> data;
  final String msg;

  const BankNameEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class DatumEntity extends Equatable {
  final String name;
  final int bankId;

  const DatumEntity({
    required this.name,
    required this.bankId,
  });

  @override
  List<Object?> get props => [name, bankId];
}
