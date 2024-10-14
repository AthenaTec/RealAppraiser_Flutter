import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetFreshCaseEntity extends Equatable {
  final int status;
  final GetFreshCaseDataEntity data;
  final String msg;

  const GetFreshCaseEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class GetFreshCaseDataEntity extends Equatable {
  final List<PropertyTypeEntity> propertyType;
  final List<dynamic> bank;
  final List<CaseAdminEntity> caseAdmin;
  final List<CaseAdminEntity> reportMaker;

  const GetFreshCaseDataEntity({
    required this.propertyType,
    required this.bank,
    required this.caseAdmin,
    required this.reportMaker,
  });

  @override
  List<Object?> get props => [propertyType, bank, caseAdmin, reportMaker];
}

class CaseAdminEntity extends Equatable {
  final int employeeId;
  final String firstName;
  final int agencyBranchId;
  final String lastName;
  final int roleId;
  final String fullName;

  const CaseAdminEntity({
    required this.employeeId,
    required this.firstName,
    required this.agencyBranchId,
    required this.lastName,
    required this.roleId,
    required this.fullName,
  });

  @override
  List<Object?> get props =>
      [employeeId, firstName, agencyBranchId, lastName, roleId, fullName];
}

class PropertyTypeEntity extends Equatable {
  final int typeOfPropertyId;
  final String name;
  final bool isActive;
  final int propertyCategoryId;
  final DateTime createdOn;
  final int createdBy;
  final DateTime modifiedOn;
  final int modifiedBy;

  const PropertyTypeEntity({
    required this.typeOfPropertyId,
    required this.name,
    required this.isActive,
    required this.propertyCategoryId,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
  });

  @override
  List<Object?> get props => [
        typeOfPropertyId,
        name,
        isActive,
        propertyCategoryId,
        createdOn,
        createdBy,
        modifiedOn,
        modifiedBy
      ];
}
