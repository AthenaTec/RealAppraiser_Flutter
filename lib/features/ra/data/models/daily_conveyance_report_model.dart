import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';

class DailyConveyanceReportModel extends DailyConveyanceReportEntity {
  DailyConveyanceReportModel({
    required super.status,
    required super.dataEntity,
    required super.msg,
  });

  factory DailyConveyanceReportModel.fromMap(Map<String, dynamic>? json) =>
      DailyConveyanceReportModel(
        status: json?["status"] ?? "", // Handle null, provide default value
        dataEntity: json?["data"] != null
            ? Data.fromMap(json!["data"])
            : Data.empty(), // Handle null for Data
        msg: json?["msg"] ?? "", // Default to empty string if msg is null
      );
}

class Data extends DataEntity {
  Data({
    required super.stateName,
    required super.branchName,
    required super.employeeName,
    required super.saPcode,
    required super.dateofTravel,
    required super.totalDistance,
    required super.noOfActivities,
    required super.activities,
  });

  /// Provide a method to return an empty Data object if the map is null
  factory Data.empty() => Data(
    stateName: '',
    branchName: '',
    employeeName: '',
    saPcode: '',
    dateofTravel: '',
    totalDistance: 0.0,
    noOfActivities: 0,
    activities: [],
  );

  factory Data.fromMap(Map<String, dynamic>? json) => Data(
    stateName: json?["StateName"] ?? "", // Default to empty string if null
    branchName: json?["BranchName"] ?? "", // Handle null
    employeeName: json?["EmployeeName"] ?? "", // Handle null
    saPcode: json?["SAPcode"] ?? "", // Handle null
    dateofTravel: json?["DateofTravel"] ?? "", // Handle null
    totalDistance: (json?["TotalDistance"] ?? 0.0)?.toDouble(), // Handle null, convert to double
    noOfActivities: json?["NoOfActivities"] ?? 0, // Default to 0 if null
    activities: json?["Activities"] != null
        ? List<Activity>.from(json!["Activities"]
        .map((x) => Activity.fromMap(x))) // Handle nested nulls
        : [], // Provide an empty list if Activities is null
  );
}

class Activity extends ActivityEntity {
  Activity({
    required super.activity,
    required super.caseId,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.time,
  });

  factory Activity.fromMap(Map<String, dynamic>? json) => Activity(
    activity: json?["Activity"] ?? "", // Handle null
    caseId: json?["CaseId"] != null ? json!["CaseId"] as int? : null, // Handle null for caseId
    latitude: (json?["Latitude"] ?? 0.0)?.toDouble(), // Handle null, convert to double
    longitude: (json?["Longitude"] ?? 0.0)?.toDouble(), // Handle null, convert to double
    address: json?["Address"] ?? "", // Handle null
    time: json?["Time"] ?? "", // Handle null
  );
}
