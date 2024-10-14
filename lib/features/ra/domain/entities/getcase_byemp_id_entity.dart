import 'package:equatable/equatable.dart';

class GetCaseByEmployeeIdEntity extends Equatable {
  final int status;
  final DataEntity data;
  final String msg;

  const GetCaseByEmployeeIdEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class DataEntity extends Equatable {
  final List<CloseEntity> open;
  final List<CloseEntity> close;

  DataEntity({
    required this.open,
    required this.close,
  });

  @override
  List<Object?> get props => [open, close];
}

class CloseEntity extends Equatable {
  final int caseId;
  final String applicantName;
  final String applicantContactNo;
  final String propertyAddress;
  final String contactPersonName;
  final String contactPersonNumber;
  final String bankName;
  final String bankReferenceNo;
  final int bankId;
  final int agencyBranchId;
  final String bankBranchName;
  final String propertyType;
  final DateTime assignedAt;
  final String status;
  final int fieldStaff;
  final int assignedTo;
  final int reportMaker;
  final int propertyId;
  final int reportFile;
  final int reportId;
  final int reportTemplateId;
  final int propertyCategoryId;
  final String reportName;
  final String employeeName;
  final int statusId;
  final String uniqueIdoftheValuation;

  CloseEntity({
    required this.caseId,
    required this.applicantName,
    required this.applicantContactNo,
    required this.propertyAddress,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.bankName,
    required this.bankReferenceNo,
    required this.bankId,
    required this.agencyBranchId,
    required this.bankBranchName,
    required this.propertyType,
    required this.assignedAt,
    required this.status,
    required this.fieldStaff,
    required this.assignedTo,
    required this.reportMaker,
    required this.propertyId,
    required this.reportFile,
    required this.reportId,
    required this.reportTemplateId,
    required this.propertyCategoryId,
    required this.reportName,
    required this.employeeName,
    required this.statusId,
    required this.uniqueIdoftheValuation,
  });

  @override
  List<Object?> get props => [
        caseId,
        applicantName,
        applicantContactNo,
        propertyAddress,
        contactPersonName,
        contactPersonNumber,
        bankName,
        bankReferenceNo,
        bankId,
        agencyBranchId,
        bankBranchName,
        propertyType,
        assignedAt,
        status,
        fieldStaff,
        assignedTo,
        reportMaker,
        propertyId,
        reportFile,
        reportId,
        reportTemplateId,
        propertyCategoryId,
        reportName,
        employeeName,
        statusId,
        uniqueIdoftheValuation
      ];
}
