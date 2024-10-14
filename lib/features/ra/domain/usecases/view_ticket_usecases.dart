import 'package:dartz/dartz.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_filter_status_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_details_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/view_ticket_repository.dart';

import '../../../../common_utilis/service_failure.dart';

class ViewTicketUseCases {
  final ViewTicketRepository viewTicketRepository;

  ViewTicketUseCases({required this.viewTicketRepository});

  Future<Either<Failure, GetTicketDetailsEntity>> getTicketDetails(TicketFilterInput input) {
    return viewTicketRepository.getTicketDetails(input);
  }
  Future<Either<Failure,TicketFilterStatusEntity>>getFilterStatus(){
    return viewTicketRepository.getFilterStatus();
  }
}

class TicketFilterInput {
  final String empId;
  final String fromDate;
  final String toDate;
  final String? filterBy;
  final String? ticketId;
  final String? status;
  final int? roleId;

  TicketFilterInput({
    required this.empId,
    required this.fromDate,
    required this.toDate,
    this.filterBy,
    this.ticketId,
    this.status,
    this.roleId,
  });

  // Method to convert the input to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'EmpId': empId,
      'fromdate': fromDate,
      'todate': toDate,
      'fillterby': filterBy ?? '', // Defaults to an empty string if not provided
      'ticketId': ticketId ?? '', // Defaults to an empty string if not provided
      'status': status ?? '', // Defaults to an empty string if not provided
      'roleId': roleId ?? 0, // Defaults to 0 if not provided
    };
  }
}
