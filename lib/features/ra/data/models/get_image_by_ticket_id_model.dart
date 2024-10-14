import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';

class GetImageByTicketIdModel extends GetImageByTicketIdEntity {
  const GetImageByTicketIdModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetImageByTicketIdModel.fromJson(Map<String, dynamic>? json) =>
      GetImageByTicketIdModel(
        status: json?["status"] ?? '', // Default to empty string if null
        data: json?["data"] != null
            ? List<DatumModel>.from(
            json!["data"].map((x) => DatumModel.fromJson(x)))
            : [], // Provide an empty list if data is null
        msg: json?["msg"] ?? '', // Default to empty string if null
      );
}

class DatumModel extends Datum {
  const DatumModel({
    required super.id,
    required super.ticketId,
    required super.filePath,
    required super.image,
    required super.fileName,
  });

  factory DatumModel.fromJson(Map<String, dynamic>? json) => DatumModel(
    id: json?["ID"] ?? 0, // Default to 0 if ID is null
    ticketId: json?["TicketID"] ?? 0, // Default to 0 if TicketID is null
    filePath: json?["FilePath"] ?? '', // Default to empty string if null
    image: json?["Image"] ?? '', // Default to empty string if null
    fileName: json?["FileName"] ?? '', // Default to empty string if null
  );
}
