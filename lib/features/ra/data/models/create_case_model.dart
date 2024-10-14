import 'package:real_appraiser/features/ra/domain/entities/create_case_entity.dart';

class CreateCaseModel extends CreateCaseEntity {
  const CreateCaseModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  // Factory constructor to handle null values safely
  factory CreateCaseModel.fromMap(Map<String, dynamic> json) {
    return CreateCaseModel(
      status: json["status"] ?? '', // Provide a default empty string if null
      data: json["data"] ?? {}, // Default to an empty map if null
      msg: json["msg"] ?? '', // Provide a default empty string if null
    );
  }
}