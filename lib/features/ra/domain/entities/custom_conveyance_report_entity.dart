import 'package:equatable/equatable.dart';

class CustomConveyanceReportEntity extends Equatable {
  final int status;
  final List<DatumEntity> data;
  final String msg;

  CustomConveyanceReportEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class DatumEntity extends Equatable {
  final String dateofTravel;
  final String stateName;
  final String branchName;
  final String employeeName;
  final String saPcode;
  final String loginTime;
  final String logoutTime;
  final dynamic noOfActivities;
  final String routeUrl;
  final dynamic totalDistance;

  DatumEntity({
    required this.dateofTravel,
    required this.stateName,
    required this.branchName,
    required this.employeeName,
    required this.saPcode,
    required this.loginTime,
    required this.logoutTime,
    required this.noOfActivities,
    required this.routeUrl,
    required this.totalDistance,
  });

  @override
  List<Object?> get props => [
        dateofTravel,
        stateName,
        branchName,
        employeeName,
        saPcode,
        loginTime,
        logoutTime,
        noOfActivities,
        routeUrl,
        totalDistance
      ];
}
