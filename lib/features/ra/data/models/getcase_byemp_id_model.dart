import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';

class GetCaseByEmployeeIdModel extends GetCaseByEmployeeIdEntity {
  GetCaseByEmployeeIdModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory GetCaseByEmployeeIdModel.fromMap(Map<String, dynamic> json) =>
      GetCaseByEmployeeIdModel(
        status: json["status"] ?? '', // Provide a default value if null
        data: json["data"] != null ? DataModel.fromMap(json["data"]) : DataModel(open: [], close: []), // Handle null object
        msg: json["msg"] ?? '',
      );
}

class DataModel extends DataEntity {
  DataModel({
    required super.open,
    required super.close,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
    open: json["Open"] != null
        ? List<CloseModel>.from(json["Open"].map((x) => CloseModel.fromMap(x)))
        : [], // Default empty list if null
    close: json["Close"] != null
        ? List<CloseModel>.from(json["Close"].map((x) => CloseModel.fromMap(x)))
        : [], // Default empty list if null
  );
}

class CloseModel extends CloseEntity {
  CloseModel({
    required super.caseId,
    required super.applicantName,
    required super.applicantContactNo,
    required super.propertyAddress,
    required super.contactPersonName,
    required super.contactPersonNumber,
    required super.bankName,
    required super.bankReferenceNo,
    required super.bankId,
    required super.agencyBranchId,
    required super.bankBranchName,
    required super.propertyType,
    required super.assignedAt,
    required super.status,
    required super.fieldStaff,
    required super.assignedTo,
    required super.reportMaker,
    required super.propertyId,
    required super.reportFile,
    required super.reportId,
    required super.reportTemplateId,
    required super.propertyCategoryId,
    required super.reportName,
    required super.employeeName,
    required super.statusId,
    required super.uniqueIdoftheValuation,
  });

  factory CloseModel.fromMap(Map<String, dynamic> json) => CloseModel(
    caseId: json["CaseId"] ?? '',
    applicantName: json["ApplicantName"] ?? '',
    applicantContactNo: json["ApplicantContactNo"] ?? '',
    propertyAddress: json["PropertyAddress"] ?? '',
    contactPersonName: json["ContactPersonName"] ?? '',
    contactPersonNumber: json["ContactPersonNumber"] ?? '',
    bankName: json["BankName"] ?? '',
    bankReferenceNo: json["BankReferenceNo"] ?? '',
    bankId: json["BankId"] ?? '',
    agencyBranchId: json["AgencyBranchId"] ?? '',
    bankBranchName: json["BankBranchName"] ?? '',
    propertyType: json["PropertyType"] ?? '',
    assignedAt: json["AssignedAt"] != null ? DateTime.parse(json["AssignedAt"]) : DateTime.now(),
    status: json["Status"] ?? '',
    fieldStaff: json["FieldStaff"] ?? '',
    assignedTo: json["AssignedTo"] ?? '',
    reportMaker: json["ReportMaker"] ?? '',
    propertyId: json["PropertyId"] ?? '',
    reportFile: json["ReportFile"] ?? '',
    reportId: json["ReportId"] ?? '',
    reportTemplateId: json["ReportTemplateId"] ?? '',
    propertyCategoryId: json["PropertyCategoryId"] ?? '',
    reportName: json["ReportName"] ?? '',
    employeeName: json["EmployeeName"] ?? '',
    statusId: json["StatusId"] ?? '',
    uniqueIdoftheValuation: json["UniqueIdoftheValuation"] ?? '',
  );
}
