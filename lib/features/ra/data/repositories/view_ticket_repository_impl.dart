import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/view_ticket_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_details_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/view_ticket_repository.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';

class ViewTicketRepositoryImpl extends ViewTicketRepository {
  final ViewTicketDatasource viewTicketDatasource;

  ViewTicketRepositoryImpl({required this.viewTicketDatasource});

  @override
  Future<Either<Failure, GetTicketDetailsEntity>> getTicketDetails(
      TicketFilterInput input) async {
    try {
      var result = await viewTicketDatasource.getTicketDetails(input);
      if (result is GetTicketDetailsEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketFilterStatusEntity>> getFilterStatus() async {
    try {
      var result = await viewTicketDatasource.getFilterStatus();
      if (result is TicketFilterStatusEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
