import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_details_entity.dart';

abstract class ViewTicketState extends Equatable {
  const ViewTicketState();

  @override
  List<Object> get props => [];
}

class ViewTicketInitialState extends ViewTicketState {}

//Get Ticket Details
class GetTicketDetailsInitialState extends ViewTicketState {}

class GetTicketDetailsSuccessState extends ViewTicketState {
  final GetTicketDetailsEntity getTicketDetailsEntity;

  const GetTicketDetailsSuccessState({required this.getTicketDetailsEntity});
}

class GetTicketDetailsErrorState extends ViewTicketState {
  final String message;

  const GetTicketDetailsErrorState({required this.message});
}

//Filter status
class GetFilterStatusInitialState extends ViewTicketState {}

class GetFilterStatusSuccessState extends ViewTicketState {
  final TicketFilterStatusEntity ticketFilterStatusEntity;

  const GetFilterStatusSuccessState({required this.ticketFilterStatusEntity});
}

class GetFilterStatusErrorState extends ViewTicketState{
  final String message;
  const GetFilterStatusErrorState({required this.message});
}