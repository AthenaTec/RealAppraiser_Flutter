import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/fs_model_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/non_case_activity_entity.dart';

abstract class NonCaseActivityState extends Equatable {
  NonCaseActivityState();

  @override
  List<Object> get props => [];
}

class NonCaseActivityInitialState extends NonCaseActivityState {}

class LoadNonCaseActivityInitialState extends NonCaseActivityState {}

class LoadNonCaseActivitySuccessState extends NonCaseActivityState {
  final LoadNonCaseActivitiesEntity loadNonCaseActivitiesEntity;

  LoadNonCaseActivitySuccessState({required this.loadNonCaseActivitiesEntity});
}

class LoadNonCaseActivityErrorState extends NonCaseActivityState {
  final String message;

  LoadNonCaseActivityErrorState({required this.message});
}

class FSTrackerDetailsInitialState extends NonCaseActivityState {}

class FSTrackerDetailsSuccessState extends NonCaseActivityState {
  final FsTrackerEntity fsTrackerEntity;

  FSTrackerDetailsSuccessState({required this.fsTrackerEntity});
}

class FSTrackerDetailsErrorState extends NonCaseActivityState {
  final String message;

  FSTrackerDetailsErrorState({required this.message});
}
