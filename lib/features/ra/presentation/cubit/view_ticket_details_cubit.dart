import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/view_ticket_details_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/view_ticket_detail_state.dart';

class ViewTicketDetailsCubit extends Cubit<ViewTicketDetailState> {
  ViewTicketDetailsUseCases viewTicketDetailsUseCases;

  ViewTicketDetailsCubit({required this.viewTicketDetailsUseCases})
      : super(ViewTicketDetailInitialState());

  //Get Ticket Details by Id
  Future getTicketDetailsById(String ticketId) async {
    try {
      emit(ViewTicketDetailsByIdInitialState());
      var result =
          await viewTicketDetailsUseCases.getTicketDetailsById(ticketId);
      result.fold((failure) {
        emit(ViewTicketDetailsByIdErrorState(message: failure.message));
      }, (data) {
        print("ViewTicketDetailsByIdSuccessState");
        print(data.dataEntity.contactNumber);
        emit(ViewTicketDetailsByIdSuccessState(ticketDetailsbyIdEntity: data));
      });
    } catch (e) {
      emit(ViewTicketDetailsByIdErrorState(message: e.toString()));
    }
  }

  //get images by ticket id
  Future getImagesByTicketId(String ticketId) async {
    try {
      emit(GetImageByIdInitialState());
      var result =
          await viewTicketDetailsUseCases.getTicketImagesById(ticketId);
      result.fold((failure) {
        emit(GetImageByIdErrorState(message: failure.message));
      }, (data) {
        print("GetImageByIdSuccessState");
        emit(GetImageByIdSuccessState(getImageByTicketIdEntity: data));
      });
    } catch (e) {
      emit(GetImageByIdErrorState(message: e.toString()));
    }
  }
}
