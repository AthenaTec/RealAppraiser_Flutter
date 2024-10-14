import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/non_case_activity_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/fs_model_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/non_case_activity_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/non_case_activity_repository.dart';
import 'package:real_appraiser/features/ra/domain/usecases/non_case_activity_usecases.dart';

class NonCaseActivityRepositoryImpl extends NonCaseActivityRepository {
  final NonCaseActivityDatasource nonCaseActivityDatasource;

  NonCaseActivityRepositoryImpl({required this.nonCaseActivityDatasource});

  @override
  Future<Either<Failure, LoadNonCaseActivitiesEntity>>
      loadNonCaseActivity() async {
    try {
      var result = await nonCaseActivityDatasource.loadNonCaseActivity();
      if (result is LoadNonCaseActivitiesEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FsTrackerEntity>> fsTrackerDetails(NonCaseActivityInput inputData) async{
    try {
      var result = await nonCaseActivityDatasource.fsTrackerDetails(inputData);
      if (result is FsTrackerEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
