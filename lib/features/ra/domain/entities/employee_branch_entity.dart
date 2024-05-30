import 'package:equatable/equatable.dart';

class EmployeeBranchEntity extends Equatable {
  final int status;
  final List<EmployeeBranchDatumEntity> data;
  final String msg;

  const EmployeeBranchEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class EmployeeBranchDatumEntity extends Equatable {
  final String branchName;
  final int agencyBranchId;

  const EmployeeBranchDatumEntity({
    required this.branchName,
    required this.agencyBranchId,
  });

  @override
  List<Object?> get props => [branchName, agencyBranchId];
}
