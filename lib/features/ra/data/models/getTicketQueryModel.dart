import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';

class GetTicketQueriesModel extends GetTicketQueriesEntity {
  const GetTicketQueriesModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetTicketQueriesModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return const GetTicketQueriesModel(
        status: 0, // Default 0 for status when json is null
        data: [], // Default empty list when data is null
        msg: '', // Default empty string when msg is null
      );
    }

    return GetTicketQueriesModel(
      status: json["status"] ?? 0, // Handle null with default value (0 for int)
      data: json["data"] != null
          ? List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)))
          : [], // Default empty list when data is null
      msg: json["msg"] ?? '', // Handle null with default value (empty string)
    );
  }
}

class Datum extends DatumEntity {
  const Datum({
    required super.id,
    required super.name,
  });

  factory Datum.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return const Datum(
        id: 0, // Default value for ID when null
        name: '', // Default empty string for name when null
      );
    }

    return Datum(
      id: json["ID"] ?? 0, // Handle null with default value (0 for int)
      name: json["Name"] ?? '', // Handle null with default value (empty string)
    );
  }
}
