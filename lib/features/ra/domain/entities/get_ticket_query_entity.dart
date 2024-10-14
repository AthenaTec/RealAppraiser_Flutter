import 'package:equatable/equatable.dart';

class GetTicketQueriesEntity extends Equatable {
  final int status;
  final List<DatumEntity> data;
  final String msg;

  const GetTicketQueriesEntity({
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

  const DatumEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
