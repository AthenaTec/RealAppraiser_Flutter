import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/ticket_details_by_id_entity.dart';

abstract class ViewTicketDetailsRepository{
  Future<Either<Failure,TicketDetailsbyIdEntity>>getTicketDetailsById(String ticketId);
  Future<Either<Failure,GetImageByTicketIdEntity>>getTicketImagesById(String ticketId);
}