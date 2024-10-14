import 'package:real_appraiser/features/ra/domain/entities/fs_model_entity.dart';

class FsTrackerModel extends FsTrackerEntity {
  const FsTrackerModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory FsTrackerModel.fromMap(Map<String, dynamic> json) => FsTrackerModel(
        status: json["status"],
        data: json["data"],
        msg: json["msg"],
      );
}
