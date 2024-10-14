import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/custom_conveyance_report_model.dart';
import 'package:real_appraiser/features/ra/data/models/daily_conveyance_report_model.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

import '../../../../common_utilis/strings.dart';

abstract class ConveyanceReportDatasource {
  Future getDailyReport();

  Future getCustomReport(String sDate, String eDate);
}

class ConveyanceReportDataSourceImpl extends ConveyanceReportDatasource {
  @override
  Future getDailyReport() async {
    // Get the current date
    DateTime currentDate = DateTime.now();
    print(currentDate);

    // Get the date one month ago

    // Format the dates in ddMMyyyy
    String fromDate = DateFormat('yyyy-MM-dd').format(currentDate);
    String toDate = DateFormat('yyyy-MM-dd').format(currentDate);
    String loginId = RAUtilis.getStorage(StorageString.loginId);
    String branchId = RAUtilis.getStorage(StorageString.branchId);
    String token = RAUtilis.getStorage(StorageString.accessToken);
    print("Date===> $toDate");
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'AgencyBranchId': branchId,
        'FieldStaff': loginId,
        'FromDate': fromDate,
        'ToDate': toDate
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/FsConveyance/app_DailyConveyanceReport";
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
            return DailyConveyanceReportModel.fromMap(res);
          }
        } else {
          return "Service Failure";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future getCustomReport(String sDate, String eDate) async {
    // Get the current date
    String fromDate = sDate;
    String toDate = eDate;
    String loginId = RAUtilis.getStorage(StorageString.loginId);
    String branchId = RAUtilis.getStorage(StorageString.branchId);
    String token = RAUtilis.getStorage(StorageString.accessToken);
    print("Date===> $toDate");
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final Map<String, dynamic> queryParams = {
        'AgencyBranchId': branchId,
        'FieldStaff': loginId,
        'FromDate': fromDate,
        'ToDate': toDate
      };
      var url =
          "https://dev-ra.usa.athenatec.com/api/FsConveyance/app_CustomConveyanceReport";
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
            return CustomConveyanceReportModel.fromMap(res);
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
