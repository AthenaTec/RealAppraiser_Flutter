import 'package:dartz/dartz.dart';
import 'package:real_appraiser/common_utilis/service_failure.dart';
import 'package:real_appraiser/features/ra/data/datasources/raise_a_ticket_datasource.dart';
import 'package:real_appraiser/features/ra/domain/entities/get_ticket_query_entity.dart';
import 'package:real_appraiser/features/ra/domain/entities/insert_ticket_entity.dart';
import 'package:real_appraiser/features/ra/domain/repositories/raise_a_ticket_repository.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';

class RaiseATicketRepositoryImpl extends RaiseATicketRepository {
  final RaiseATicketDatasource raiseATicketDatasource;

  RaiseATicketRepositoryImpl({required this.raiseATicketDatasource});

  @override
  Future<Either<Failure, GetTicketQueriesEntity>> getTicketQuery() async {
    try {
      var result = await raiseATicketDatasource.getTicketQuery();
      if (result is GetTicketQueriesEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InsertTicketEntity>> createTicket(
      InsertTicketInputData inputData) async {
    try {
      var result = await raiseATicketDatasource.createTicket(inputData);
      if (result is InsertTicketEntity) {
        return Right(result);
      } else {
        return Left(Failure(message: result));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
