import 'dart:convert';

import 'package:real_appraiser/common_utilis/strings.dart';
import 'package:real_appraiser/common_utilis/utilis.dart';
import 'package:real_appraiser/features/ra/data/models/fs_tracker_model.dart';
import 'package:real_appraiser/features/ra/data/models/non_case_activity_model.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';
import 'package:real_appraiser/service_helpers/api_service_helper.dart';

abstract class NonCaseActivityDatasource {
  Future loadNonCaseActivity();

  Future fsTrackerDetails(NonCaseActivityInput inputData);
}

class NonCaseActivityDataSourceImpl extends NonCaseActivityDatasource {
  @override
  Future loadNonCaseActivity() async {
    try {
      dynamic header = <String, String>{
        "Content-Type": "application/json",
      };

      var url =
          "https://dev-ra.usa.athenatec.com/api/NonCaseActivities/LoadNonCaseActivities";
      final Uri uri = Uri.parse(url).replace();

      var result = await ApiHelper.getRequestUri(
        uri,
        header,
        false,
      );
      if (result
          .toString()
          .isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return LoadNonCaseActivitiesModel.fromMap(res);
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
  Future fsTrackerDetails(NonCaseActivityInput inputData) async {
    try {
      String loginId = RAUtilis.getStorage(StorageString.loginId);
      String branchId = RAUtilis.getStorage(StorageString.branchId);
      String token = RAUtilis.getStorage(StorageString.accessToken);
      var url = "https://dev-ra.usa.athenatec.com/api/Case/app_InsertFSTrackerDetails";
      var data = {
        "Address": inputData.address,
        "AgencyBranchId": branchId,
        "CaseId": inputData.caseId,
        "Comments": inputData.comments,
        "Latitude": inputData.latitude,
        "Type": inputData.type,
        "Longitude": inputData.longitude,
        "TrackerTime": inputData.trackerTime,
        "ActivityType": inputData.activityType,
        "FieldStaffId": loginId
      };
      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      var result = await ApiHelper.postRequest(url, data, header);
      if (result
          .toString()
          .isNotEmpty) {
        var res = jsonDecode(result);
        if (res["status"] == 1) {
          if (res["msg"] == "Success") {
            return FsTrackerModel.fromMap(res);
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
