import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/create_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';

abstract class DashBoardRepository{
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch();
  Future<Either<Failure, GetFreshCaseEntity>> getFreshCase();
  Future<Either<Failure, BankNameEntity>> getBankName(String id);
  Future<Either<Failure,CreateCaseEntity>>createCase(CreateCaseData data);


}