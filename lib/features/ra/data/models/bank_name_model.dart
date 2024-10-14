import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';

class BankNameModel extends BankNameEntity {
  const BankNameModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory BankNameModel.fromMap(Map<String, dynamic> json) => BankNameModel(
        status: json["status"],
        data: List<DatumModel>.from(
            json["data"].map((x) => DatumModel.fromMap(x))),
        msg: json["msg"],
      );
}

class DatumModel extends DatumEntity {
  const DatumModel({
    required super.name,
    required super.bankId,
  });

  factory DatumModel.fromMap(Map<String, dynamic> json) => DatumModel(
        name: json["Name"],
        bankId: json["BankId"],
      );
}
