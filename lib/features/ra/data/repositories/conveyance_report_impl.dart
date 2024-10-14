import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/conveyance_report_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/custom_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/daily_conveyance_report_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/conveyance_report_repository.dart';

class ConveyanceReportImpl extends ConveyanceReportRepository {
  ConveyanceReportImpl({required this.conveyanceReportDatasource});

  final ConveyanceReportDatasource conveyanceReportDatasource;

  @override
  Future<Either<Failure, DailyConveyanceReportEntity>> getDailyReport() async {
    try {
      var result = await conveyanceReportDatasource.getDailyReport();
      if (result is DailyConveyanceReportEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomConveyanceReportEntity>>
      getCustomReport(String sDate,String eDate) async {
    try {
      var result = await conveyanceReportDatasource.getCustomReport(sDate,eDate);
      if (result is CustomConveyanceReportEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
