import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/custom_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';

abstract class ConveyanceReportRepository {
  Future<Either<Failure, DailyConveyanceReportEntity>> getDailyReport();
  Future<Either<Failure, CustomConveyanceReportEntity>> getCustomReport(String sDate,String eDate);

}
