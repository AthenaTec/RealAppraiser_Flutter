import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';

class EmployeeBranchModel extends EmployeeBranchEntity {
  const EmployeeBranchModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory EmployeeBranchModel.fromJson(Map<String, dynamic> json) =>
      EmployeeBranchModel(
        status: json["status"],
        data: List<EmployeeBranchDatumModel>.from(
            json["data"].map((x) => EmployeeBranchDatumModel.fromJson(x))),
        msg: json["msg"],
      );
}

class EmployeeBranchDatumModel extends EmployeeBranchDatumEntity {
  const EmployeeBranchDatumModel({
    required super.branchName,
    required super.agencyBranchId,
  });

  factory EmployeeBranchDatumModel.fromJson(Map<String, dynamic> json) =>
      EmployeeBranchDatumModel(
        branchName: json["BranchName"],
        agencyBranchId: json["AgencyBranchId"],
      );
}
