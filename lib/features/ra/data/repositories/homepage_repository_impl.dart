import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/homepage_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/update_casestatus_byid_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/homepage_repository.dart';

class HomepageRepositoryImpl extends HomepageRepository {
  HomepageRepositoryImpl({required this.homepageDatasource});

  final HomepageDatasource homepageDatasource;

  @override
  Future<Either<Failure, GetCaseByEmployeeIdEntity>> getCaseByEmpId(
      BuildContext c) async {
    try {
      var result = await homepageDatasource.getCaseByEmpId(c);
      if (result is GetCaseByEmployeeIdEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateCaseStatusByIdEntity>> updateStatusByCaseId(
      String caseId, String status) async {
    try {
      var result =
          await homepageDatasource.updateStatusByCaseId(caseId, status);
      if (result is UpdateCaseStatusByIdEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
