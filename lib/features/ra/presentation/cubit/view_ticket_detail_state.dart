import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_image_by_ticket_id_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/ticket_details_by_id_entity.dart';

abstract class ViewTicketDetailState extends Equatable {
  const ViewTicketDetailState();

  @override
  List<Object> get props => [];
}

class ViewTicketDetailInitialState extends ViewTicketDetailState {}

//View ticket Details by Id
class ViewTicketDetailsByIdInitialState extends ViewTicketDetailState {}

class ViewTicketDetailsByIdSuccessState extends ViewTicketDetailState {
  final TicketDetailsbyIdEntity ticketDetailsbyIdEntity;

  const ViewTicketDetailsByIdSuccessState(
      {required this.ticketDetailsbyIdEntity});
}

class ViewTicketDetailsByIdErrorState extends ViewTicketDetailState {
  final String message;

  const ViewTicketDetailsByIdErrorState({required this.message});
}

//Get Image by ticket id
class GetImageByIdInitialState extends ViewTicketDetailState {}

class GetImageByIdSuccessState extends ViewTicketDetailState {
  final GetImageByTicketIdEntity getImageByTicketIdEntity;

  const GetImageByIdSuccessState({required this.getImageByTicketIdEntity});
}

class GetImageByIdErrorState extends ViewTicketDetailState {
  final String message;

  const GetImageByIdErrorState({required this.message});
}
