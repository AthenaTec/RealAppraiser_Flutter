import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/fs_model_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/non_case_activity_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';

abstract class NonCaseActivityRepository {
  Future<Either<Failure, LoadNonCaseActivitiesEntity>> loadNonCaseActivity();
  Future<Either<Failure, FsTrackerEntity>> fsTrackerDetails(NonCaseActivityInput inputData);

}
