import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';

abstract class DashBoardRepository{
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch();
}