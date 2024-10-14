import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/bank_name_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/fresh_case_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/getcase_byemp_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/update_casestatus_byid_entity.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitialState extends HomepageState {}

//Home page open case listing
class GetCaseByEmpIdInitialState extends HomepageState {}

class GetCaseByEmpIdSuccessState extends HomepageState {
  final GetCaseByEmployeeIdEntity getCaseByEmployeeIdEntity;

  const GetCaseByEmpIdSuccessState({required this.getCaseByEmployeeIdEntity});
}

class GetCaseByEmpIdErrorState extends HomepageState {
  final String message;

  const GetCaseByEmpIdErrorState({required this.message});
}

//Update Case by status id

class UpdateStatusIdInitialState extends HomepageState {}

class UpdateStatusIdSuccessState extends HomepageState {
  final int index;
  final UpdateCaseStatusByIdEntity updateCaseStatusByIdEntity;

  const UpdateStatusIdSuccessState({required this.updateCaseStatusByIdEntity,required this.index});
}

class UpdateStatusIdErrorState extends HomepageState {
  final String message;

  const UpdateStatusIdErrorState({required this.message});
}
