import 'package:real_appraiser/features/ra/domain/entities/get_store_entity.dart';

class GetStoreModel extends GetStoreEntity {
  const GetStoreModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetStoreModel.fromJson(Map<String, dynamic> json) => GetStoreModel(
        status: json["status"],
        data: json["data"],
        msg: json["msg"],
      );
}
