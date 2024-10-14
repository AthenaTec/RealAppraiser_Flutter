import 'package:equatable/equatable.dart';

class InsertTicketEntity  extends Equatable{
  final int status;
  final Data data;
  final String msg;

  const InsertTicketEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status,data,msg];

}

class Data extends Equatable{
  final int ticketIdVal;

  Data({
    required this.ticketIdVal,
  });

  @override
  List<Object?> get props => [];

}
