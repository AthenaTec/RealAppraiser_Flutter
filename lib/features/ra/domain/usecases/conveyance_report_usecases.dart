import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/custom_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/conveyance_report_repository.dart';

class ConveyanceReportUseCases {
  final ConveyanceReportRepository conveyanceReportRepository;

  ConveyanceReportUseCases({required this.conveyanceReportRepository});

  Future<Either<Failure, DailyConveyanceReportEntity>> getDailyReport() {
    return conveyanceReportRepository.getDailyReport();
  }

  Future<Either<Failure, CustomConveyanceReportEntity>> getCustomReport(String sDate,String eDate) {
    return conveyanceReportRepository.getCustomReport(sDate,eDate);
  }
}
