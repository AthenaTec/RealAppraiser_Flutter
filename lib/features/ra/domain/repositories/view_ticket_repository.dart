import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_details_entity.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';

abstract class ViewTicketRepository{
Future<Either<Failure,GetTicketDetailsEntity>>getTicketDetails(TicketFilterInput input);

Future<Either<Failure,TicketFilterStatusEntity>>getFilterStatus();
}