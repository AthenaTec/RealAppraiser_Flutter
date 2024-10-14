import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_appraiser/features/ra/domain/usecases/conveyance_report_usecases.dart';
import 'package:real_appraiser/features/ra/presentation/cubit/conveyance_report_state.dart';

class ConveyanceReportCubit extends Cubit<ConveyanceReportState> {
  ConveyanceReportCubit({required this.conveyanceReportUseCases})
      : super(ConveyanceReportInitialState());
  ConveyanceReportUseCases conveyanceReportUseCases;

  Future getDailyReport() async {
    try {
      emit(CrDailyReportInitialState());
      var result = await conveyanceReportUseCases.getDailyReport();
      result.fold((failure) {
        emit(CrDailyErrorState(message: failure.message));
      }, (data) {
        print("dailyreportsuccess");
        emit(CrDailyReportSuccessState(dailyConveyanceReportEntity: data));
      });
    } catch (e) {
      emit(CrDailyErrorState(message: e.toString()));
    }
  }

  Future getCustomReport(String fromDate, String eDate) async {
    try {
      emit(CrCustomReportInitialState());
      var result = await conveyanceReportUseCases.getCustomReport(fromDate,eDate);
      result.fold((failure) {
        emit(CrCustomErrorState(message: failure.message));
      }, (data) {
        print("CustomSuccess");
        emit(CrCustomReportSuccessState(customConveyanceReportEntity: data));
      });
    } catch (e) {
      emit(CrCustomErrorState(message: e.toString()));
    }
  }
}
