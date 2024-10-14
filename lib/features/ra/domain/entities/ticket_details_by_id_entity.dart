import 'package:equatable/equatable.dart';

class TicketDetailsbyIdEntity extends Equatable {
  final int status;
  final DataEntity dataEntity;
  final String msg;

  const TicketDetailsbyIdEntity({
    required this.status,
    required this.dataEntity,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, dataEntity, msg];
}

class DataEntity extends Equatable {
  final int id;
  final int queryType;
  final String description;
  final String emailId;
  final String sapid;
  final String contactNumber;
  final int ticketStatus;
  final dynamic assignedTo;
  final String createdOn;
  final dynamic createdBy;
  final String modifiedOn;
  final dynamic modifiedBy;
  final dynamic otherQueries;

  const DataEntity({
    required this.id,
    required this.queryType,
    required this.description,
    required this.emailId,
    required this.sapid,
    required this.contactNumber,
    required this.ticketStatus,
    required this.assignedTo,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.otherQueries,
  });

  @override
  List<Object?> get props => [
        id,
        queryType,
        description,
        emailId,
        sapid,
        contactNumber,
        ticketStatus,
        assignedTo,
        createdOn,
        createdBy,
        modifiedOn,
        modifiedBy,
        otherQueries
      ];
}
