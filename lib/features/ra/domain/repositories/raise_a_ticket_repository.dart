import 'package:dartz/dartz.dart';
import 'package:flutter/gestures.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/insert_ticket_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';

abstract class RaiseATicketRepository{
  Future<Either<Failure, GetTicketQueriesEntity>> getTicketQuery();
  Future<Either<Failure,InsertTicketEntity>>createTicket(InsertTicketInputData inputData);

}