import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/custom_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';

abstract class ConveyanceReportState extends Equatable {
  const ConveyanceReportState();

  @override
  List<Object> get props => [];
}

class ConveyanceReportInitialState extends ConveyanceReportState {}

//For Daily conveyance report
class CrDailyReportInitialState extends ConveyanceReportState {}

class CrDailyReportSuccessState extends ConveyanceReportState {
  final DailyConveyanceReportEntity dailyConveyanceReportEntity;

  const CrDailyReportSuccessState({required this.dailyConveyanceReportEntity});
}

class CrDailyErrorState extends ConveyanceReportState {
  final String message;

  const CrDailyErrorState({required this.message});
}

//For Custom conveyance report
class CrCustomReportInitialState extends ConveyanceReportState {}

class CrCustomReportSuccessState extends ConveyanceReportState {
  final CustomConveyanceReportEntity customConveyanceReportEntity;

  const CrCustomReportSuccessState(
      {required this.customConveyanceReportEntity});
}

class CrCustomErrorState extends ConveyanceReportState {
  final String message;

  const CrCustomErrorState({required this.message});
}
