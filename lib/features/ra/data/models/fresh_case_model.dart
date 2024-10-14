import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';

class GetFreshCaseModel extends GetFreshCaseEntity {
  const GetFreshCaseModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetFreshCaseModel.fromMap(Map<String, dynamic> json) =>
      GetFreshCaseModel(
        status: json["status"] ?? '',
        data: json["data"] != null
            ? GetFreshCaseDataModel.fromMap(json["data"])
            : const GetFreshCaseDataModel(
                propertyType: [], bank: [], caseAdmin: [], reportMaker: []),
        msg: json["msg"] ?? '',
      );
}

class GetFreshCaseDataModel extends GetFreshCaseDataEntity {
  const GetFreshCaseDataModel({
    required super.propertyType,
    required super.bank,
    required super.caseAdmin,
    required super.reportMaker,
  });

  factory GetFreshCaseDataModel.fromMap(Map<String, dynamic> json) =>
      GetFreshCaseDataModel(
        propertyType: json["PropertyType"] != null
            ? List<PropertyType>.from(
                json["PropertyType"].map((x) => PropertyType.fromMap(x)))
            : [],
        bank: json["Bank"] != null
            ? List<dynamic>.from(json["Bank"].map((x) => x))
            : [],
        caseAdmin: json["CaseAdmin"] != null
            ? List<CaseAdmin>.from(
                json["CaseAdmin"].map((x) => CaseAdmin.fromMap(x)))
            : [],
        reportMaker: json["ReportMaker"] != null
            ? List<CaseAdmin>.from(
                json["ReportMaker"].map((x) => CaseAdmin.fromMap(x)))
            : [],
      );
}

class CaseAdmin extends CaseAdminEntity {
  const CaseAdmin({
    required super.employeeId,
    required super.firstName,
    required super.agencyBranchId,
    required super.lastName,
    required super.roleId,
    required super.fullName,
  });

  factory CaseAdmin.fromMap(Map<String, dynamic> json) => CaseAdmin(
        employeeId: json["EmployeeId"] ?? '',
        firstName: json["FirstName"] ?? '',
        agencyBranchId: json["AgencyBranchId"] ?? '',
        lastName: json["LastName"] ?? '',
        roleId: json["RoleId"] ?? '',
        fullName: json["FullName"] ?? '',
      );
}

class PropertyType extends PropertyTypeEntity {
  const PropertyType({
    required super.typeOfPropertyId,
    required super.name,
    required super.isActive,
    required super.propertyCategoryId,
    required super.createdOn,
    required super.createdBy,
    required super.modifiedOn,
    required super.modifiedBy,
  });

  factory PropertyType.fromMap(Map<String, dynamic> json) => PropertyType(
        typeOfPropertyId: json["TypeOfPropertyId"] ?? 0,
        name: json["Name"] ?? '',
        isActive: json["isActive"] ?? false,
        propertyCategoryId: json["PropertyCategoryId"] ?? 0,
        createdOn: json["CreatedOn"] != null
            ? DateTime.parse(json["CreatedOn"])
            : DateTime.now(),
        createdBy: json["CreatedBy"] ?? '',
        modifiedOn: json["ModifiedOn"] != null
            ? DateTime.parse(json["ModifiedOn"])
            : DateTime.now(),
        modifiedBy: json["ModifiedBy"] ?? '',
      );
}
