import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/dashboard_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/dashboard_repository.dart';

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
}
