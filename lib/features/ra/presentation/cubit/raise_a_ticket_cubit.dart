import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/raise_a_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/raise_a_ticket_state.dart';

class RaiseATicketCubit extends Cubit<RaiseATicketState> {
  RaiseATicketUseCases raiseATicketUseCases;

  RaiseATicketCubit({required this.raiseATicketUseCases})
      : super(RaiseATicketInitialState());

  Future getTicketQuery() async {
    try {
      emit(GetTicketQueryInitialState());
      var result = await raiseATicketUseCases.getTicketQuery();
      result.fold((failure) {
        emit(GetTicketQueryErrorState(message: failure.message));
      }, (data) {
        print("GetTicketQuerySuccessState");
        emit(GetTicketQuerySuccessState(getTicketQueriesEntity: data));
      });
    } catch (e) {
      emit(GetTicketQueryErrorState(message: e.toString()));
    }
  }

  Future createTicket(InsertTicketInputData inputData) async {
    try {
      emit((CreateTicketInitialState()));
      var result = await raiseATicketUseCases.createTicket(inputData);
      result.fold((failure) {
        emit(CreateTicketErrorState(message: failure.message));
      }, (data) {
        print("");
        emit(CreateTicketSuccessState(insertTicketEntity: data));
      });
    } catch (e) {
      emit(CreateTicketErrorState(message: e.toString()));
    }
  }
}
