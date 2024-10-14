import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/fs_model_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/non_case_activity_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/non_case_activity_repository.dart';

class NonCaseActivityUseCases {
  final NonCaseActivityRepository nonCaseActivityRepository;

  NonCaseActivityUseCases({required this.nonCaseActivityRepository});

  Future<Either<Failure, LoadNonCaseActivitiesEntity>> loadNonCaseActivity() {
    return nonCaseActivityRepository.loadNonCaseActivity();
  }

  Future<Either<Failure, FsTrackerEntity>> fsTrackerDetails(
      NonCaseActivityInput inputData) {
    return nonCaseActivityRepository.fsTrackerDetails(inputData);
  }
}

class NonCaseActivityInput {
  String address;
  String agencyBranchId;
  String caseId;
  String comments;
  String latitude;
  String longitude;
  String trackerTime;
  String type;
  String activityType;
  String fieldStaffId;

  NonCaseActivityInput({
    required this.address,
    required this.agencyBranchId,
    this.caseId = "",
    required this.comments,
    required this.latitude,
    required this.longitude,
    required this.trackerTime,
    required this.type,
    required this.activityType,
    required this.fieldStaffId,
  });

  // You can also add a factory method for creating an instance from JSON
  factory NonCaseActivityInput.fromJson(Map<String, dynamic> json) {
    return NonCaseActivityInput(
      address: json['Address'],
      agencyBranchId: json['AgencyBranchId'],
      caseId: json['CaseId'] ?? "",
      comments: json['Comments'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      trackerTime: json['TrackerTime'],
      type: json['Type'],
      activityType: json['ActivityType'],
      fieldStaffId: json['FieldStaffId'],
    );
  }

  // And a method to convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'Address': address,
      'AgencyBranchId': agencyBranchId,
      'CaseId': caseId,
      'Comments': comments,
      'Latitude': latitude,
      'Longitude': longitude,
      'TrackerTime': trackerTime,
      'Type': type,
      'ActivityType': activityType,
      'FieldStaffId': fieldStaffId,
    };
  }
}
