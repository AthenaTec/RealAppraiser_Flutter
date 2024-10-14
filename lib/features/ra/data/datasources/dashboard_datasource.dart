import 'dart:convert';

import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/bank_name_model.dart';
import 'package:real_appraiser/features/ra/data/models/create_case_model.dart';
import 'package:real_appraiser/features/ra/data/models/employee_branch_model.dart';
import 'package:real_appraiser/features/ra/data/models/fresh_case_model.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class DashBoardDataSource {
  Future getEmployeeBranch();

  Future getFreshCase();

  Future getBankName(String id);

  Future createCase(CreateCaseData data);
}

class DashBoardDataSourceImpl extends DashBoardDataSource {
  @override
  Future getEmployeeBranch() async {
    String loginId = RAUtilis.getStorage(StorageString.loginId);
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };
      final Map<String, dynamic> queryParams = {
        'LoginId': loginId,
      };
      var url =
          "https://dev-ra.usa.athenatec.com/Api/Login/app_GetEmployeeBranches";
      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      var result = await ApiHelper.getRequestUri(
        uri,
        header,
        false,
      );
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return EmployeeBranchModel.fromJson(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getFreshCase() async {
    String token = RAUtilis.getStorage(StorageString.accessToken);
    String branchId = RAUtilis.getStorage(StorageString.branchId);
    String agencyId = RAUtilis.getStorage(StorageString.agencyId);

    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'agencyBranchId': branchId,
        'agencyId': agencyId,
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/Case/app_GetFreshCaseSelections";
      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      var result = await ApiHelper.getRequestUri(
        uri,
        header,
        false,
      );
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return GetFreshCaseModel.fromMap(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getBankName(String id) async {
    String token = RAUtilis.getStorage(StorageString.accessToken);
    String branchId = RAUtilis.getStorage(StorageString.branchId);
    String agencyId = RAUtilis.getStorage(StorageString.agencyId);
    print("Agencyid==>$agencyId");

    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'PropertytypeId': id,
        'agencyBranchId': branchId,
        'agencyId': agencyId,
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/AgencyBank/app_GetByAgencyBranchAndPropertyCategoryId";
      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      var result = await ApiHelper.getRequestUri(
        uri,
        header,
        false,
      );
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return BankNameModel.fromMap(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future createCase(CreateCaseData d) async {
    String token = RAUtilis.getStorage(StorageString.accessToken);

    try {
      var url =
          "https://dev-ra.usa.athenatec.com/api/Case/app_InsertCaseFromFS";

      var data = {
        "ApplicantName": d.applicantName,
        "PropertyType": d.propertyType,
        "BankId": d.bankId,
        "CreatedBy": d.createdBy,
        "CaseAdminId": d.caseAdminId,
        "ReportMakerId": d.reportMakerId,
        "SubBranch": d.subBranch,
        "AgencyBranchId": d.agencyBranchId,
        "FSAgencyBranchId": d.fsAgencyBranchId,
        "AssignedBranchId": d.assignedBranchId,
        "BankReferenceNO": d.bankReferenceNo,
        "CAAgencyBranchId": d.caAgencyBranchId,
        "RMAgencyBranchId": d.rmAgencyBranchId
      };

      var header = <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"

      };

      var result = await ApiHelper.postRequest(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return CreateCaseModel.fromMap(res);
          }
        } else {
          return "Case Creation Failed";
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
