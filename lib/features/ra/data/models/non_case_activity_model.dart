import 'package:real_appraiser/features/ra/domain/entities/non_case_activity_entity.dart';

class LoadNonCaseActivitiesModel extends LoadNonCaseActivitiesEntity {
  const LoadNonCaseActivitiesModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory LoadNonCaseActivitiesModel.fromMap(Map<String, dynamic> json) =>
      LoadNonCaseActivitiesModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        msg: json["msg"],
      );
}

class Datum extends DatumEntity {
  Datum({
    required super.id,
    required super.name,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        name: json["Name"],
      );
}
