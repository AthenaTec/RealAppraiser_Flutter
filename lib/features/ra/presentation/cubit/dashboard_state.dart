import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardStateInitialState extends DashboardState {}

class EmployeeBranchInitialState extends DashboardState {}

class EmployeeBranchSuccessState extends DashboardState {
  final EmployeeBranchEntity employeeBranchEntity;

  const EmployeeBranchSuccessState({required this.employeeBranchEntity});
}

class EmployeeBranchErrorState extends DashboardState {
  final String message;

  const EmployeeBranchErrorState({required this.message});
}
