import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/create_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/employee_branch_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';

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

//Fresh case dropdown values

class GetFreshCaseInitialState extends DashboardState {}

class GetFreshCaseSuccessState extends DashboardState {
  final GetFreshCaseEntity getFreshCaseEntity;

  const GetFreshCaseSuccessState({required this.getFreshCaseEntity});
}

class GetFreshCaseErrorState extends DashboardState {
  final String message;

  const GetFreshCaseErrorState({required this.message});
}

//GetBankName
class GetBankNameInitialState extends DashboardState {}

class GetBankNameSuccessState extends DashboardState {
  final BankNameEntity bankNameEntity;

  const GetBankNameSuccessState({required this.bankNameEntity});
}

class GetBankNameErrorState extends DashboardState {
  final String message;

  const GetBankNameErrorState({required this.message});
}

//CreateCaseAPI
class CreateCaseInitialState extends DashboardState {}

class CreateCaseSuccessState extends DashboardState {
  final CreateCaseEntity createCaseEntity;

  const CreateCaseSuccessState({required this.createCaseEntity});
}

class CreateCaseErrorState extends DashboardState {
  final String message;

  const CreateCaseErrorState({required this.message});
}
