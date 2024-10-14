import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/create_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/dashboard_repository.dart';

class DashboardUseCases {
  final DashBoardRepository dashBoardRepository;

  DashboardUseCases({required this.dashBoardRepository});

  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch() {
    return dashBoardRepository.getEmployeeBranch();
  }

  Future<Either<Failure, GetFreshCaseEntity>> getFreshCase() {
    return dashBoardRepository.getFreshCase();
  }

  Future<Either<Failure, BankNameEntity>> getBankName(String id) {
    return dashBoardRepository.getBankName(id);
  }

  Future<Either<Failure, CreateCaseEntity>> createCase(CreateCaseData data) {
    return dashBoardRepository.createCase(data);
  }
}

class CreateCaseData {
  String applicantName;
  String propertyType;
  String bankId;
  String createdBy;
  String caseAdminId;
  String reportMakerId;
  String subBranch;
  String agencyBranchId;
  String? fsAgencyBranchId;
  String assignedBranchId;
  String bankReferenceNo;
  String caAgencyBranchId;
  String rmAgencyBranchId;

  CreateCaseData({
    required this.applicantName,
    required this.propertyType,
    required this.bankId,
    required this.createdBy,
    required this.caseAdminId,
    required this.reportMakerId,
    this.subBranch = "",
    required this.agencyBranchId,
    this.fsAgencyBranchId,
    required this.assignedBranchId,
    required this.bankReferenceNo,
    required this.caAgencyBranchId,
    required this.rmAgencyBranchId,
  });

  // Factory constructor to create an object from a map (for example, from JSON)


  // Method to convert the object to a map (for example, to JSON)
  Map<String, dynamic> toJson() {
    return {
      'ApplicantName': applicantName,
      'PropertyType': propertyType,
      'BankId': bankId,
      'CreatedBy': createdBy,
      'CaseAdminId': caseAdminId,
      'ReportMakerId': reportMakerId,
      'SubBranch': subBranch,
      'AgencyBranchId': agencyBranchId,
      'FSAgencyBranchId': fsAgencyBranchId,
      'AssignedBranchId': assignedBranchId,
      'BankReferenceNO': bankReferenceNo,
      'CAAgencyBranchId': caAgencyBranchId,
      'RMAgencyBranchId': rmAgencyBranchId,
    };
  }
}
