import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';

class TicketFilterStatusModel extends TicketFilterStatusEntity {
  const TicketFilterStatusModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory TicketFilterStatusModel.fromJson(Map<String, dynamic> json) =>
      TicketFilterStatusModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        msg: json["msg"],
      );
}

class Datum extends DatumEntity {
  const Datum({
    required super.id,
    required super.name,
    required super.isAdmin,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["ID"],
        name: json["Name"],
        isAdmin: json["IsAdmin"],
      );
}
