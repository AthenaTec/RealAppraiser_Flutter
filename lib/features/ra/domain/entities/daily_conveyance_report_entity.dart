import 'package:equatable/equatable.dart';

class DailyConveyanceReportEntity extends Equatable {
  final int status;
  final DataEntity dataEntity;
  final String msg;

  DailyConveyanceReportEntity({
    required this.status,
    required this.dataEntity,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, dataEntity, msg];
}

class DataEntity extends Equatable {
  final dynamic stateName;
  final dynamic branchName;
  final dynamic employeeName;
  final dynamic saPcode;
  final String dateofTravel;
  final double totalDistance;
  final int noOfActivities;
  final List<ActivityEntity> activities;

  DataEntity({
    required this.stateName,
    required this.branchName,
    required this.employeeName,
    required this.saPcode,
    required this.dateofTravel,
    required this.totalDistance,
    required this.noOfActivities,
    required this.activities,
  });

  @override
  List<Object?> get props => [
        stateName,
        branchName,
        employeeName,
        saPcode,
        dateofTravel,
        totalDistance,
        noOfActivities,
        activities
      ];
}

class ActivityEntity extends Equatable {
  final String activity;
  final int? caseId;
  final double latitude;
  final double longitude;
  final String address;
  final String time;

  ActivityEntity({
    required this.activity,
    required this.caseId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.time,
  });

  @override
  List<Object?> get props =>
      [activity, caseId, latitude, longitude, address, time];
}
