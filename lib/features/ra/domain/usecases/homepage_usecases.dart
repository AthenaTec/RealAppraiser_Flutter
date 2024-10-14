import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/update_casestatus_byid_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/homepage_repository.dart';

class HomepageUsecases {
  final HomepageRepository homepageRepository;

  HomepageUsecases({required this.homepageRepository});

  Future<Either<Failure, GetCaseByEmployeeIdEntity>> getCaseByEmpId(
      BuildContext c) {
    return homepageRepository.getCaseByEmpId(c);
  }

  Future<Either<Failure, UpdateCaseStatusByIdEntity>> updateStatusByCaseId(
      String caseId, String status) {
    return homepageRepository.updateStatusByCaseId(caseId, status);
  }
}
