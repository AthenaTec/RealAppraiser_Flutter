import 'package:equatable/equatable.dart';

class TicketFilterStatusEntity extends Equatable {
  final int status;
  final List<DatumEntity> data;
  final String msg;

  const TicketFilterStatusEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class DatumEntity extends Equatable {
  final int id;
  final String name;
  final bool isAdmin;

  const DatumEntity({
    required this.id,
    required this.name,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [id, name, isAdmin];
}
