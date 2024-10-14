import 'package:real_appraiser/features/ra/domain/entities/get_ticket_details_entity.dart';

class GetTicketDetailsModel extends GetTicketDetailsEntity {
  const GetTicketDetailsModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetTicketDetailsModel(
        status: json["status"] ?? 0,
        data: json["data"] != null
            ? List<DatumModel>.from(
                json["data"].map((x) => DatumModel.fromJson(x)))
            : [],
        msg: json["msg"] ?? '',
      );
}

class DatumModel extends DatumEntity {
  const DatumModel({
    required super.ticketId,
    required super.query,
    required super.status,
    required super.date,
  });

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
      ticketId: json["TicketId"] ?? 0,
      query: json["Query"] ?? '',
      status: json["Status"] ?? '',
      date: json["Date"] ?? ''
      );
}
