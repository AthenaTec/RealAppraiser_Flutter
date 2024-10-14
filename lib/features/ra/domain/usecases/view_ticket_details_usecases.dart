import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/ticket_details_by_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/view_ticket_details_repository.dart';

class ViewTicketDetailsUseCases {
  final ViewTicketDetailsRepository viewTicketDetailsRepository;

  ViewTicketDetailsUseCases({required this.viewTicketDetailsRepository});

  Future<Either<Failure, TicketDetailsbyIdEntity>> getTicketDetailsById(String ticketId) {
    return viewTicketDetailsRepository.getTicketDetailsById(ticketId);
  }

  Future<Either<Failure, GetImageByTicketIdEntity>> getTicketImagesById(String ticketId) {
    return viewTicketDetailsRepository.getTicketImagesById(ticketId);
  }

}
