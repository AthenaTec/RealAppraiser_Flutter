import 'package:equatable/equatable.dart';

class GetTicketDetailsEntity extends Equatable{
  final int status;
  final List<DatumEntity> data;
  final String msg;

  const GetTicketDetailsEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status,data,msg];

}

class DatumEntity extends Equatable{
  final int ticketId;
  final String query;
  final String status;
  final String date;

  const DatumEntity({
    required this.ticketId,
    required this.query,
    required this.status,
    required this.date,
  });

  @override
  List<Object?> get props => [ticketId,query,status,date];

}
