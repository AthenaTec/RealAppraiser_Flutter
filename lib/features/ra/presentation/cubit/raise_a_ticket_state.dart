import 'package:equatable/equatable.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/insert_ticket_entity.dart';

abstract class RaiseATicketState extends Equatable {
  const RaiseATicketState();

  @override
  List<Object> get props => [];
}

class RaiseATicketInitialState extends RaiseATicketState {}

class GetTicketQueryInitialState extends RaiseATicketState {}

class GetTicketQuerySuccessState extends RaiseATicketState {
  final GetTicketQueriesEntity getTicketQueriesEntity;

  const GetTicketQuerySuccessState({required this.getTicketQueriesEntity});
}

class GetTicketQueryErrorState extends RaiseATicketState {
  final String message;

  const GetTicketQueryErrorState({required this.message});
}


//Insert ticket system

class CreateTicketInitialState extends RaiseATicketState {}

class CreateTicketSuccessState extends RaiseATicketState {
  final InsertTicketEntity insertTicketEntity;

  const CreateTicketSuccessState({required this.insertTicketEntity});
}

class CreateTicketErrorState extends RaiseATicketState {
  final String message;

  const CreateTicketErrorState({required this.message});
}
