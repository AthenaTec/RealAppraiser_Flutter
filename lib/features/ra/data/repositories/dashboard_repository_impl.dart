import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/dashboard_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/create_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/dashboard_repository.dart';
import 'package:real_appraiser/features/ra/domain/usecases/dashboard_usercases.dart';

class DashBoardRepositoryImpl extends DashBoardRepository {
  DashBoardRepositoryImpl({required this.dashBoardDataSource});

  final DashBoardDataSource dashBoardDataSource;

  @override
  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch() async {
    try {
      var result = await dashBoardDataSource.getEmployeeBranch();
      if (result is EmployeeBranchEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetFreshCaseEntity>> getFreshCase() async {
    try {
      var result = await dashBoardDataSource.getFreshCase();
      if (result is GetFreshCaseEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BankNameEntity>> getBankName(String id) async {
    try {
      var result = await dashBoardDataSource.getBankName(id);
      if (result is BankNameEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateCaseEntity>> createCase(CreateCaseData data) async {
    try {
      var result = await dashBoardDataSource.createCase(data);
      if (result is CreateCaseEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
