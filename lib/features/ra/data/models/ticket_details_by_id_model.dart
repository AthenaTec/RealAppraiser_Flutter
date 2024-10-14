import 'package:real_appraiser/features/ra/domain/entities/ticket_details_by_id_entity.dart';

class TicketDetailsbyIdModel extends TicketDetailsbyIdEntity {
  TicketDetailsbyIdModel({
    required super.status,
    required super.dataEntity,
    required super.msg,
  });

  // Factory method to create an instance from a JSON map
  factory TicketDetailsbyIdModel.fromJson(Map<String, dynamic>? json) =>
      TicketDetailsbyIdModel(
        status: json?["status"] ?? '', // Handle null and provide a default empty string
        dataEntity: json?["data"] != null
            ? DataModel.fromJson(json!["data"])
            : DataModel.empty(), // Use empty constructor if DataModel is null
        msg: json?["msg"] ?? '', // Provide default empty string if msg is null
      );
}

class DataModel extends DataEntity {
  DataModel({
    required super.id,
    required super.queryType,
    required super.description,
    required super.emailId,
    required super.sapid,
    required super.contactNumber,
    required super.ticketStatus,
    required super.assignedTo,
    required super.createdOn,
    required super.createdBy,
    required super.modifiedOn,
    required super.modifiedBy,
    required super.otherQueries,
  });

  // Empty constructor to provide default values
  factory DataModel.empty() => DataModel(
    id: 0,
    queryType: 0,
    description: '',
    emailId: '',
    sapid: '',
    contactNumber: '',
    ticketStatus: 0,
    assignedTo: '',
    createdOn: '',
    createdBy: '',
    modifiedOn: '',
    modifiedBy: '',
    otherQueries: '',
  );

  // Factory method to create an instance from a JSON map
  factory DataModel.fromJson(Map<String, dynamic>? json) => DataModel(
    id: json?["ID"] ?? 0, // Handle null, default to 0 for ID
    queryType: json?["QueryType"] ?? 0, // Handle null, default to 0 for queryType
    description: json?["Description"] ?? '', // Default to empty string if null
    emailId: json?["EmailId"] ?? '', // Default to empty string if null
    sapid: json?["SAPID"] ?? '', // Default to empty string if null
    contactNumber: json?["ContactNumber"] ?? '', // Default to empty string if null
    ticketStatus: json?["TicketStatus"] ?? 0, // Handle null, default to 0 for ticketStatus
    assignedTo: json?["AssignedTo"] ?? '', // Default to empty string if null
    createdOn: json?["CreatedOn"] ?? '', // Handle null, convert to string if necessary
    createdBy: json?["CreatedBy"] ?? '', // Default to empty string if null
    modifiedOn: json?["ModifiedOn"] ?? '', // Handle null, convert to string if necessary
    modifiedBy: json?["ModifiedBy"] ?? '', // Default to empty string if null
    otherQueries: json?["OtherQueries"] ?? '', // Default to empty string if null
  );
}
