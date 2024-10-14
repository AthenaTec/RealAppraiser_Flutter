import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/update_casestatus_byid_entity.dart';

abstract class HomepageRepository {
  Future<Either<Failure, GetCaseByEmployeeIdEntity>> getCaseByEmpId(BuildContext c);
  Future<Either<Failure, UpdateCaseStatusByIdEntity>> updateStatusByCaseId(String caseId, String status);

}
