import 'package:real_appraiser/features/ra/domain/entities/custom_conveyance_report_entity.dart';

class CustomConveyanceReportModel extends CustomConveyanceReportEntity {
  CustomConveyanceReportModel({
    required super.status,
    required super.data,
    required super.msg,
  });

  factory CustomConveyanceReportModel.fromMap(Map<String, dynamic>? json) =>
      CustomConveyanceReportModel(
        status: json?["status"] ?? "", // Handle null with default value
        data: json?["data"] != null
            ? List<Datum>.from(json!["data"].map((x) => Datum.fromMap(x)))
            : [], // Handle null for data with an empty list
        msg: json?["msg"] ?? "", // Handle null with default value
      );
}

class Datum extends DatumEntity {
  Datum({
    required super.dateofTravel,
    required super.stateName,
    required super.branchName,
    required super.employeeName,
    required super.saPcode,
    required super.loginTime,
    required super.logoutTime,
    required super.noOfActivities,
    required super.routeUrl,
    required super.totalDistance,
  });

  factory Datum.fromMap(Map<String, dynamic>? json) => Datum(
        dateofTravel: json?["DateofTravel"] ?? "",
        // Handle null with default value
        stateName: json?["StateName"] ?? "",
        // Handle null
        branchName: json?["BranchName"] ?? "",
        // Handle null
        employeeName: json?["EmployeeName"] ?? "",
        // Handle null
        saPcode: json?["SAPcode"] ?? "",
        // Handle null
        loginTime: json?["LoginTime"] ?? "",
        // Handle null
        logoutTime: json?["LogoutTime"] ?? "",
        // Handle null
      noOfActivities: json?["NoOfActivities"] is int
      ? json!["NoOfActivities"]
      : (json?["NoOfActivities"] as num?)?.toInt() ?? 0,
        // Handle null with default value
        routeUrl: json?["RouteURL"] ?? "",
        // Handle null
        totalDistance:
            json?["TotalDistance"] ?? 0.0, // Handle null and convert to double
      );
}
