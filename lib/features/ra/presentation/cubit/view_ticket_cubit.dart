import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_state.dart';

class ViewTicketCubit extends Cubit<ViewTicketState> {
  ViewTicketUseCases viewTicketUseCases;

  ViewTicketCubit({required this.viewTicketUseCases})
      : super(ViewTicketInitialState());

  //Get Ticket Details
  Future getTicketDetails(TicketFilterInput input) async {
    try {
      emit(GetTicketDetailsInitialState());
      var result = await viewTicketUseCases.getTicketDetails(input);
      result.fold((failure) {
        emit(GetTicketDetailsErrorState(message: failure.message));
      }, (data) {
        print("GetTicketQuerySuccessState");
        emit(GetTicketDetailsSuccessState(getTicketDetailsEntity: data));
      });
    } catch (e) {
      emit(GetTicketDetailsErrorState(message: e.toString()));
    }
  }

  Future getFilterStatus() async {
    try {
      emit(GetFilterStatusInitialState());
      var result = await viewTicketUseCases.getFilterStatus();
      result.fold((failure) {
        emit(GetFilterStatusErrorState(message: failure.message));
      }, (data) {
        print("GetFilterStatus");
        emit(GetFilterStatusSuccessState(ticketFilterStatusEntity: data));
      });
    } catch (e) {
      emit(GetFilterStatusErrorState(message: e.toString()));
    }
  }
}
