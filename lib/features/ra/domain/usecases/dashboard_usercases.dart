import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/dashboard_repository.dart';

class DashboardUseCases {
  final DashBoardRepository dashBoardRepository;

  DashboardUseCases({required this.dashBoardRepository});

  Future<Either<Failure, EmployeeBranchEntity>> getEmployeeBranch() {
    return dashBoardRepository.getEmployeeBranch();
  }
}
