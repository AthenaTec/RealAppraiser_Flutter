import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/fresh_case_model.dart';
import 'package:real_appraiser/features/ra/data/models/getcase_byemp_id_model.dart';
import 'package:real_appraiser/features/ra/data/models/update_casestatus_byid_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class HomepageDatasource {
  Future getCaseByEmpId(BuildContext c);

  Future updateStatusByCaseId(String caseId, String status);
}

class HomepageDatasourceImpl extends HomepageDatasource {
  @override
  Future getCaseByEmpId(BuildContext c) async {
    // Get the current date
    DateTime currentDate = DateTime.now();
    print(currentDate);

    // Get the date one month ago
    DateTime oneMonthAgo = DateTime(
      currentDate.year,
      currentDate.month - 1,
      currentDate.day,
    );

    // Format the dates in ddMMyyyy
    String startDate = DateFormat('dd/MM/yyyy').format(currentDate);
    String endDate = DateFormat('dd/MM/yyyy').format(oneMonthAgo);
    String loginId = RAUtilis.getStorage(StorageString.loginId);
    String branchId = RAUtilis.getStorage(StorageString.branchId);
    String token = RAUtilis.getStorage(StorageString.accessToken);
    String token1 = token.replaceAll(' ', '');
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'empId': loginId,
        'startDate': startDate,
        'endDate': endDate,
        'agencyBranchId': branchId
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/Case/app_GetCaseByEmployeeID";
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
            return GetCaseByEmployeeIdModel.fromMap(res);
          }
        } else {
          return "Enter a valid Url";
        }
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  @override
  Future updateStatusByCaseId(String caseId, String status) async {
    try {
      String loginId = RAUtilis.getStorage(StorageString.loginId);
      String branchId = RAUtilis.getStorage(StorageString.branchId);
      String token = RAUtilis.getStorage(StorageString.accessToken);
      var url =
          "https://dev-ra.usa.athenatec.com/api/Case/app_UpdateCaseStatusById";
      var data = {
        "CaseId": caseId,
        "Status": status,
        "ModifiedBy": loginId,
      };
      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      var result = await ApiHelper.putRequest(url, data, header);
      if (result.toString().isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return UpdateCaseStatusByIdModel.fromMap(res);
          }
        } else {
          return "Service Failure";
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
