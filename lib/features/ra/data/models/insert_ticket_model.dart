import 'package:real_appraiser/features/ra/domain/entities/insert_ticket_entity.dart';

class InsertTicketDetailsModel extends InsertTicketEntity {
  const InsertTicketDetailsModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory InsertTicketDetailsModel.fromMap(Map<String, dynamic> json) =>
      InsertTicketDetailsModel(
        status: json["status"] != null
            ? json["status"] as int
            : 0, // Handle null by providing default value (0 for int)
        data: json["data"] != null
            ? DataModel.fromMap(json["data"])
            : DataModel(ticketIdVal: 0), // Default value for DataModel
        msg: json["msg"] ??
            '', // Handle null by providing default value (empty string)
      );
}

class DataModel extends Data {
  DataModel({
    required super.ticketIdVal,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        ticketIdVal: json["TicketIDVal"] != null
            ? json["TicketIDVal"] as int
            : 0, // Handle null with default value (0 for int)
      );
}
