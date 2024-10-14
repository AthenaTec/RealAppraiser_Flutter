import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/view_ticket_details_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/ticket_details_by_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/view_ticket_details_repository.dart';

class ViewTicketDetailsRepositoryImpl extends ViewTicketDetailsRepository {
  final ViewTicketDetailsDatasource viewTicketDetailsDatasource;

  ViewTicketDetailsRepositoryImpl({required this.viewTicketDetailsDatasource});

  @override
  Future<Either<Failure, TicketDetailsbyIdEntity>> getTicketDetailsById(
      String ticketId) async {
    try {
      var result =
          await viewTicketDetailsDatasource.getTicketDetailsById(ticketId);
      if (result is TicketDetailsbyIdEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetImageByTicketIdEntity>> getTicketImagesById(String ticketId) async {
    try {
      var result =
          await viewTicketDetailsDatasource.getTicketImagesById(ticketId);
      if (result is GetImageByTicketIdEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
