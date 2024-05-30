import 'dart:convert';

import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/employee_branch_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class DashBoardDataSource {
  Future getEmployeeBranch();
}

class DashBoardDataSourceImpl extends DashBoardDataSource {
  @override
  Future getEmployeeBranch() async {
String loginId=RAUtilis.getStorage(StorageString.loginId);
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
}
